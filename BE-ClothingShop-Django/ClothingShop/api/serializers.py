from itertools import product
from rest_framework import serializers
from clothing_shop.models import Category, Product, Cart, Cartitems, ProductImage

from django.contrib.auth.models import User
# from django.contrib.auth import auth  enticate

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
        child = serializers.ImageField(max_length = 1000000, allow_empty_file = False, use_url = False),
        write_only=True)
    
    class Meta:
        model = Product
        fields = [ "product_id", "product_name", "description", "price", "stock", "images", "uploaded_images"]
    
    
    def create(self, validated_data):
        uploaded_images = validated_data.pop("uploaded_images")
        product = Product.objects.create(**validated_data)
        for image in uploaded_images:
            newproduct_image = ProductImage.objects.create(product=product, image=image)
        return product
    
    
# class RegisterSerializer(serializers.ModelSerializer):
#     password = serializers.CharField(write_only=True)

#     class Meta:
#         model = User
#         fields = ('username', 'password', 'email', 'first_name', 'last_name')



# class LoginSerializer(serializers.Serializer):
#     username = serializers.CharField()
#     password = serializers.CharField(write_only=True)
#     def validate(self, data):
#         user = authenticate(**data)
#         if user and user.is_active:
#             return user
#         raise serializers.ValidationError("False")
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


class AddCartItemSerializer(serializers.ModelSerializer):
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