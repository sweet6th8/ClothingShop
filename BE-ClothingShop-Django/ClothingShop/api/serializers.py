from itertools import product
from rest_framework import serializers
from clothing_shop.models import *

from djoser.serializers import UserCreateSerializer

from django.contrib.auth.models import User
# from django.contrib.auth import auth  enticate
from django.db import transaction




class MyUserCreateSerializer(UserCreateSerializer):
    class Meta(UserCreateSerializer.Meta):
        fields = ["id", "email", "first_name", "last_name", "password", "username"]

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
    class Meta:
        model = Product
        fields = ["product_id", "product_name", "price"]

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


class  AddCartItemSerializer(serializers.ModelSerializer):
    product_id = serializers.UUIDField()

    def validate_product_id(self, value):
        if not Product.objects.filter(pk=value).exists():
            raise serializers.ValidationError("There is no product associated with the given ID")
        
        return value

    def save(self, **kwargs):
        cart_id = self.context["cart_id"]
        product_id = self.validated_data["product_id"]
        quantity = self.validated_data["quantity"]
        try:
            cartitem = Cartitems.objects.get(product_id=product_id,cart_id=cart_id)
            cartitem.quantity += quantity
            cartitem.save()

            self.instance = cartitem
            
        except:
            self.instance = Cartitems.objects.create(cart_id=cart_id, **self.validated_data)

        return self.instance
    

    class Meta:
        model = Cartitems
        fields = ["id", "product_id", "quantity"]

class UpdateCartItemSerializer(serializers.ModelSerializer):
    # id = serializers.IntegerField(read_only=True)
    class Meta:
        model = Cartitems
        fields = ["quantity"] # cập nhật số lượng

class ProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = Profile
        fields = ["id", "name", "bio", "picture"]

class OrderItemSerializer(serializers.ModelSerializer):
    product = SimpleProductSerializer()
    class Meta:
        model = OrderItem
        fields = ["id", "product", "quantity"]

class OrderSerializer(serializers.ModelSerializer):
    items = OrderItemSerializer(many=True, read_only=True)
    class Meta:
        model = Order
        fields = ["id", "placed_at", "pending_status", "owner", "items"]

class CreateOrderSerializer(serializers.Serializer):
    cart_id = serializers.UUIDField()

    def save (self, **kwargs):
        with transaction.atomic():
            cart_id = self.validated_data["cart_id"]
            user_id = self.context["user_id"]
            order = Order.objects.create(owner_id = user_id)
            cartitems = Cartitems.objects.filter(cart_id=cart_id)
             # Tạo danh sách các đối tượng OrderItem từ các Cartitems
            orderitems = [
                OrderItem(order=order, product=item.product, quantity=item.quantity)
            for item in cartitems
            ]
             # Sử dụng bulk_create để chèn nhiều OrderItem vào cơ sở dữ liệu cùng một lúc, giúp tăng hiệu năng
            OrderItem.objects.bulk_create(orderitems)
            Cart.objects.filter(id=cart_id).delete()

class UpdateOrderSerializer(serializers.ModelSerializer):
    class Meta:
        model = Order 
        fields = ["pending_status"]
        
    

