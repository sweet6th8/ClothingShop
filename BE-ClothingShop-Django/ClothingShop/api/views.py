from urllib import response
# from django.shortcuts import render, get_object_or_404
# from rest_framework.decorators import api_view
from .serializers import *
from clothing_shop.models import Category, Product, Cart, Cartitems, Profile
from rest_framework.response import Response
from rest_framework import status
from rest_framework.views import APIView
from rest_framework.viewsets import ModelViewSet, GenericViewSet
from rest_framework.mixins import CreateModelMixin, RetrieveModelMixin, DestroyModelMixin
from api import serializers
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.filters import SearchFilter, OrderingFilter
from api.filters import ProductFilter
from rest_framework.parsers import MultiPartParser, FormParser
from rest_framework.permissions import IsAuthenticated
from rest_framework.permissions import IsAuthenticatedOrReadOnly
from .pagination import CustomPagination
from rest_framework.exceptions import NotFound
from rest_framework.exceptions import ValidationError
from django.http import JsonResponse
from rest_framework.decorators import api_view
from gradio_client import Client
import tempfile
from djoser.views import UserViewSet
from django.contrib.auth import get_user_model
from django.utils.http import urlsafe_base64_decode
from rest_framework.exceptions import PermissionDenied
from django.shortcuts import get_object_or_404
from rest_framework.exceptions import NotAuthenticated


# from django.contrib.auth import login, logout
from rest_framework.authtoken.models import Token
# from .serializers import RegisterSerializer, LoginSerializer
import requests
from rest_framework.decorators import action
from rest_framework.permissions import AllowAny

# Create your views here.

class ProductViewSet(ModelViewSet):
    queryset = Product.objects.all() # lấy tất cả products
    serializer_class = ProductSerializer
    filter_backends = [DjangoFilterBackend, SearchFilter, OrderingFilter]
    filterset_class = ProductFilter
    search_fields = ['product_name', 'description']
    ordering_fields = ['price']
    pagination_class = CustomPagination  
    permission_classes = [AllowAny]  # Cho phép truy cập không cần xác thực
    
    def create(self, request, *args, **kwargs):
        return super().create(request, *args, **kwargs)
    

    # lấy danh sách sản phẩm ngẫu nhiên
    @action(detail=False, methods=['get'], url_path='random/(?P<count>[0-9]+)')
    def random(self, request, *args, **kwargs):
        count = kwargs.get('count')  # Lấy tham số count từ kwargs
        try:
            count = int(count)  
            if count <= 0:
                raise ValueError
        except ValueError:
            raise ValidationError({"count": "Tham số 'count' phải là một số nguyên dương."})

        # Lấy danh sách sản phẩm ngẫu nhiên, giới hạn theo 'count'
        random_products = Product.objects.order_by('?')[:count]
    
        page = self.paginate_queryset(random_products)  # Áp dụng phân trang

        if page is not None:
            serializer = self.get_serializer(page, many=True)
            return self.get_paginated_response(serializer.data)

        serializer = self.get_serializer(random_products, many=True)
        return Response(serializer.data)

    

class CategoryViewSet(ModelViewSet):
    permission_classes = [AllowAny]
    queryset = Category.objects.all() # lấy tất cả categories
    serializer_class = CategorySerializer
    



class SubcategoryViewSet(ModelViewSet):
    permission_classes = [AllowAny]
    queryset = Subcategory.objects.all()
    serializer_class = SubcategorySerializer

    # Lấy danh sách subcategory theo category_id

    filter_backends = (DjangoFilterBackend, OrderingFilter)
    filterset_fields = ['category_id']  # Định nghĩa query parameter category_id
    

    def get_queryset(self):
        queryset = Subcategory.objects.all()
        category_id = self.request.query_params.get('category_id', None)
        if category_id is not None:
            queryset = queryset.filter(category_id=category_id)
        return queryset




class CartViewSet(GenericViewSet, CreateModelMixin):
    permission_classes = [IsAuthenticated]
    queryset = Cart.objects.all()
    serializer_class = CartSerializer

    def get_queryset(self):
        """Lấy cart của user đã đăng nhập"""
        return Cart.objects.filter(user=self.request.user)

    @action(detail=False, methods=["get"], url_path="mine", permission_classes=[IsAuthenticated])
    def get_user_cart(self, request):
        """Lấy hoặc tạo cart của user"""
        cart, created = Cart.objects.get_or_create(user=request.user)
        serializer = self.get_serializer(cart)
        return Response(serializer.data)

    @action(detail=False, methods=['get'], url_path='total-quantity', permission_classes=[IsAuthenticated])
    def get_total_quantity(self, request):
        """Trả về tổng số lượng sản phẩm trong giỏ hàng."""
        cart = Cart.objects.filter(user=request.user).first()
        if not cart:
            return Response({"total_quantity": 0})
        total_quantity = sum(item.quantity for item in cart.items.all())
        return Response({"total_quantity": total_quantity})


class CartitemViewSet(ModelViewSet):
    http_method_names = ["get", "post", "patch", "delete"]
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        """Trả về danh sách các sản phẩm trong giỏ hàng của user."""
        if not self.request.user.is_authenticated:
            raise NotAuthenticated("Bạn cần đăng nhập để thực hiện thao tác này.")
        
        cart = Cart.objects.filter(user=self.request.user).first()
        if not cart:
            raise NotFound("Giỏ hàng không tồn tại.")
        return Cartitems.objects.filter(cart=cart)

    def get_serializer_class(self):
        """Chọn serializer tương ứng với phương thức HTTP"""
        if self.request.method == "POST":
            return AddCartItemSerializer
        elif self.request.method == "PATCH":
            return UpdateCartItemSerializer
        return CartItemSerializer

    def get_serializer_context(self):
        """Truyền cart_id từ user vào context của serializer."""
        if not self.request.user.is_authenticated:
            raise NotAuthenticated("Bạn cần đăng nhập để thực hiện thao tác này.")
        
        cart = Cart.objects.filter(user=self.request.user).first()
        if not cart:
            raise NotFound("Giỏ hàng không tồn tại.")
        return {"cart_id": cart.id}


    
class ProfileViewSet(ModelViewSet):
      
    queryset = Profile.objects.all()
    serializer_class = ProfileSerializer
    parser_classes = (MultiPartParser, FormParser) # tuong thich voi react

    def create(self, request, *args, **kwargs):
        name = request.data["name"]
        bio = request.data["bio"]
        picture = request.data["picture"]

        Profile.objects.create(name=name, bio=bio, picture=picture)

        return Response("Profile created successfully", status=status.HTTP_200_OK)
    

class OrderViewSet(ModelViewSet):
    
    def get_serializer_class(self):
        if self.request.method == "POST":
            return CreateOrderSerializer
        return OrderSerializer

    def get_queryset(self):
        user = self.request.user
        if user.is_staff:
            return Order.objects.all()
        return Order.objects.filter(owner=user)
    
    def get_serializer_context(self):
        return {"user_id": self.request.user.id}
    
    
    @action(detail=True, methods=['POST'])
    def pay(self, request, pk):
        order = self.get_object()
        amount = order.total_price
        email = request.user.email
        order_id = str(order.id)
        # redirect_url = "http://127.0.0.1:8000/confirm"
        return initiate_payment(amount, email, order_id)
    
    @action(detail=False, methods=["POST"])
    def confirm_payment(self, request):
        order_id = request.GET.get("o_id")
        order = Order.objects.get(id=order_id)
        order.pending_status = "C"
        order.save()
        serializer = OrderSerializer(order)
        
        data = {
            "msg": "payment was successful",
            "data": serializer.data
        }
        return Response(data)
    
def initiate_payment(amount, email, order_id):
    url = "https://api.flutterwave.com/v3/payments"
    headers = {
        "Authorization": f"Bearer {settings.FLW_SEC_KEY}"
        
    }
    
    data = {
        "tx_ref": str(uuid.uuid4()),
        "amount": str(amount), 
        "currency": "USD",
        "redirect_url": "http:/127.0.0.1:8000/api/orders/confirm_payment/?o_id=" + order_id,
        "meta": {
            "consumer_id": 23,
            "consumer_mac": "92a3-912ba-1192a"
        },
        "customer": {
            "email": email,
            "phonenumber": "080****4528",
            "name": "Yemi Desola"
        },
        "customizations": {
            "title": "Pied Piper Payments",
            "logo": "http://www.piedpiper.com/app/themes/joystick-v27/images/logo.png"
        }
    }
    

    try:
        response = requests.post(url, headers=headers, json=data)
        response_data = response.json()
        return Response(response_data)
    
    except requests.exceptions.RequestException as err:
        print("the payment didn't go through")
        return Response({"error": str(err)}, status=500)

# Luồng hoạt động tổng quát của phần thanh toán:

# Thanh toán (pay()):
# Người dùng gửi yêu cầu POST tới endpoint /api/orders/<order_id>/pay/.
# pay() gọi initiate_payment() để khởi tạo giao dịch trên Flutterwave.
# Flutterwave trả về một phản hồi, bao gồm URL để người dùng thực hiện thanh toán (là trang giao dịch).

# Xác nhận thanh toán (confirm_payment()):
# Sau khi người dùng thanh toán, Flutterwave redirect đến URL đã chỉ định (redirect_url) kèm o_id.
# Endpoint /api/orders/confirm_payment/ được gọi.
# Hệ thống cập nhật trạng thái đơn hàng và trả về thông báo thành công.

    


# import tempfile
# from gradio_client import Client
# from rest_framework.decorators import api_view
# from django.http import JsonResponse

# # Tạo client Gradio
# client = Client("https://f2edfb8f338119030b.gradio.live/")


# @api_view(["POST"])
# def predict_images(request):
#     try:
#         # Nhận file từ request
#         cloth_image = request.FILES.get("cloth_image")
#         human_image = request.FILES.get("human_image")

#         if not cloth_image or not human_image:
#             return JsonResponse({"error": "Both images are required."}, status=400)

#         # Lưu file tạm thời để gửi đến API Gradio
#         with open("temp_cloth.png", "wb") as f:
#             for chunk in cloth_image.chunks():
#                 f.write(chunk)

#         with open("temp_human.png", "wb") as f:
#             for chunk in human_image.chunks():
#                 f.write(chunk)

#         # Gửi request đến Gradio API
#         result = client.predict(
#             "temp_cloth.png",  # Đường dẫn đến ảnh quần áo
#             "temp_human.png",  # Đường dẫn đến ảnh người
#             fn_index=0
#         )

#         # Xóa file tạm nếu cần
#         import os
#         os.remove("temp_cloth.png")
#         os.remove("temp_human.png")

#         # Trả kết quả về frontend
#         return JsonResponse({"result": result}, status=200)

#     except Exception as e:
#         return JsonResponse({"error": str(e)}, status=500)

class CustomUserViewSet(UserViewSet):
    permission_classes = [AllowAny] 

    @action(detail=True, methods=["get"], url_path=r"activate/(?P<uid>[\w-]+)/(?P<token>[\w-]+)")
    def activate(self, request, uid, token):
        try:
            # Giải mã UID từ base64
            uid = urlsafe_base64_decode(uid).decode()
            # Lấy người dùng từ DB theo ID
            user = get_user_model().objects.get(pk=uid)

            # Kiểm tra token kích hoạt
            if user.activation_token == token:
                user.is_active = True  # Đánh dấu tài khoản đã kích hoạt
                user.save()
                return Response({"detail": "Account activated successfully."}, status=status.HTTP_200_OK)
            else:
                return Response({"detail": "Invalid activation link."}, status=status.HTTP_400_BAD_REQUEST)

        except get_user_model().DoesNotExist:
            # Nếu không tìm thấy người dùng
            return Response({"detail": "User not found."}, status=status.HTTP_404_NOT_FOUND)
        except Exception as e:
            # Log lỗi chi tiết nếu có
            return Response({"detail": f"Error: {str(e)}"}, status=status.HTTP_400_BAD_REQUEST)