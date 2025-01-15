from itertools import product
from rest_framework import serializers
from clothing_shop.models import *
from djoser.serializers import UserCreateSerializer
from django.contrib.auth.models import User
from django.db import transaction

class MyUserCreateSerializer(UserCreateSerializer):
    class Meta(UserCreateSerializer.Meta):
        fields = ["id", "email", "first_name", "last_name", "password", "username"]
        
    def create(self, validated_data):
        user = super().create(validated_data)
        user.is_active = False  # Đảm bảo user chưa được kích hoạt khi đăng ký
        user.save()
        return user


class SubcategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Subcategory
        fields = '__all__'


class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Category
        fields = '__all__'


class ProductImageSerializer(serializers.ModelSerializer):
    class Meta:
        model = ProductImage
        fields = ["id", "product", "image"]

   
class ProductSerializer(serializers.ModelSerializer):
    images = ProductImageSerializer(many=True, read_only=True)
    uploaded_images = serializers.ListField(
        child=serializers.ImageField(max_length=1000000, allow_empty_file=False, use_url=False),
        write_only=True
    )
    
    class Meta:
        model = Product
        fields = ["product_id", "product_name", "slug", "description", "price", "stock", "is_available", "category", "subcategory", "images", "uploaded_images"]
    
    def create(self, validated_data):
        uploaded_images = validated_data.pop("uploaded_images", [])  # Sửa tên trường
        product = Product.objects.create(**validated_data)
        for image in uploaded_images:
            ProductImage.objects.create(product=product, image=image)
        return product


class SimpleProductSerializer(serializers.ModelSerializer):
    image = serializers.SerializerMethodField()

    class Meta:
        model = Product
        fields = ["product_id", "product_name", "price", "image"]

    def get_image(self, obj):
        """Lấy URL đầy đủ của hình ảnh đầu tiên."""
        request = self.context.get('request')
        product_image = obj.images.first()  # Lấy hình ảnh đầu tiên của sản phẩm
        if product_image and product_image.image:
            # Tạo URL đầy đủ từ request
            return request.build_absolute_uri(product_image.image.url) if request else product_image.image.url
        return None


class SimpleProductForShirtCartSerializer(serializers.ModelSerializer):
    image = serializers.SerializerMethodField()
    class Meta:
        model = Product
        fields = ['product_name', 'image']

    def get_image(self, obj):
        request = self.context.get('request')
        if obj.images.first():  # Lấy ảnh đầu tiên của sản phẩm
            return request.build_absolute_uri(obj.images.first().image.url) if request else obj.images.first().image.url
        return None


class CartItemSerializer(serializers.ModelSerializer):
    product = SimpleProductSerializer(many=False)
    sub_total = serializers.SerializerMethodField(method_name="total")
    class Meta:
        model = Cartitems
        fields = ["id", "cart", "product", "quantity", "sub_total"]

    # Tính total cho từng item
    def total(self, cartitem:Cartitems):
        return cartitem.product.price * cartitem.quantity


class CartSerializer(serializers.ModelSerializer):
    id = serializers.UUIDField(read_only = True)
    items = CartItemSerializer(many = True, read_only = True)
    grand_total = serializers.SerializerMethodField(method_name="main_total")
    class Meta:
        model = Cart
        fields = ["id", "items", "grand_total"] #"created" automatically

    # Tính tổng giỏ hàng
    def main_total(self, cart:Cart):
        return sum(item.quantity * item.product.price for item in cart.items.all())


class AddCartItemSerializer(serializers.ModelSerializer):
    product_id = serializers.IntegerField()

    quantity = serializers.IntegerField(min_value=1, error_messages={
        "min_value": "Quantity must be greater than zero."
    })

    def validate_product_id(self, value):
        """Kiểm tra sự tồn tại của sản phẩm"""
        if not Product.objects.filter(pk=value).exists():
            raise serializers.ValidationError("There is no product associated with the given ID")
        return value

    def save(self, **kwargs):
        """Lưu hoặc cập nhật CartItem"""
        cart_id = self.context["cart_id"]
        product_id = self.validated_data["product_id"]
        quantity = self.validated_data["quantity"]

        # Kiểm tra và thêm hoặc cập nhật sản phẩm vào giỏ hàng
        cartitem, created = Cartitems.objects.get_or_create(
            product_id=product_id, cart_id=cart_id,
            defaults={"quantity": quantity}
        )

        if not created:
            cartitem.quantity += quantity
            cartitem.save()

        self.instance = cartitem
        return self.instance

    class Meta:
        model = Cartitems
        fields = ["id", "product_id", "quantity"]


class UpdateCartItemSerializer(serializers.ModelSerializer):
    """Serializer để cập nhật số lượng của một CartItem"""

    quantity = serializers.IntegerField(min_value=1, error_messages={
        "min_value": "Quantity must be greater than zero."
    })

    def validate_quantity(self, value):
        """Kiểm tra logic bổ sung (ví dụ: tồn kho)."""
        # Giả sử bạn có trường `product` trong CartItem
        product = self.instance.product
        if value > product.stock:
            raise serializers.ValidationError(f"Only {product.stock} items available in stock.")
        return value

    class Meta:
        model = Cartitems
        fields = ["quantity"]  # Cập nhật số lượng của CartItem
        

class ProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = Profile
        fields = ["id", "name", "bio", "picture"]


class OrderItemSerializer(serializers.ModelSerializer):
    product = SimpleProductSerializer(many=False)
    class Meta:
        model = OrderItem
        fields = ["id", "product", "quantity"]


class OrderSerializer(serializers.ModelSerializer):
    items = OrderItemSerializer(many=True, read_only=True)
    class Meta:
        model = Order
        fields = ["id", "placed_at", "pending_status", "owner", "total_price", "items"]


class CreateOrderSerializer(serializers.Serializer):
    item_ids = serializers.ListField(
        child=serializers.IntegerField(),
        write_only=True,
        help_text="Danh sách các CartItem ID mà người dùng muốn thanh toán"
    )

    def save(self, **kwargs):
        with transaction.atomic():
            user_id = self.context["user_id"]

            # Tìm cart của user
            cart = Cart.objects.filter(user_id=user_id).first()
            if not cart or not cart.items.exists():
                raise serializers.ValidationError("Giỏ hàng không tồn tại hoặc trống.")
            
            # Lọc các CartItem mà user đã chọn
            item_ids = self.validated_data["item_ids"]
            cartitems = Cartitems.objects.filter(cart=cart, id__in=item_ids)

            if not cartitems.exists():
                raise serializers.ValidationError("Không tìm thấy sản phẩm hợp lệ trong giỏ hàng.")

            # Tạo Order
            order = Order.objects.create(owner_id=user_id)

            # Tạo từng OrderItem và lưu
            orderitems = [
                OrderItem(order=order, product=item.product, quantity=item.quantity)
                for item in cartitems
            ]
            OrderItem.objects.bulk_create(orderitems)

            # Xóa các CartItem đã thanh toán
            cartitems.delete()

            return order.id  # Trả về id của Order


class UpdateOrderSerializer(serializers.ModelSerializer):
    class Meta:
        model = Order 
        fields = ["pending_status"]
        
    

