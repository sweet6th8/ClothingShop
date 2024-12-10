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



class CartViewSet(CreateModelMixin, RetrieveModelMixin, DestroyModelMixin, GenericViewSet):
    
    #RetrieveModelMixin: lấy ra 
    #DestroyModelMixin: delete cart
    queryset = Cart.objects.all()
    serializer_class = CartSerializer

class CartitemViewSet(ModelViewSet):
   
    http_method_names = ["get", "post", "patch", "delete"]
    
    # Lấy danh sách các sp trong cart dựa trên cart_id
    def get_queryset(self):
        # Kiểm tra xem cart_pk có tồn tại không
        cart_pk = self.kwargs.get("cart_pk")
        try:
            cart = Cart.objects.get(pk=cart_pk)  # Kiểm tra sự tồn tại của cart
        except Cart.DoesNotExist:
            raise NotFound(detail="Cart with the given ID does not exist.")
        
        return Cartitems.objects.filter(cart=cart)

    
    def get_serializer_class(self):
        # add item to cart
        if self.request.method == "POST":
            return AddCartItemSerializer
        # update cart item
        elif self.request.method == "PATCH":
            return UpdateCartItemSerializer
        # if GET/DELETE
        return CartItemSerializer
    
    
      # Truyền cart_id vào context của serializer
    def get_serializer_context(self):
        if "cart_pk" not in self.kwargs:
            raise NotFound(detail="cart_pk parameter is missing in the URL.")

        return {"cart_id": self.kwargs["cart_pk"]}
    
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
    @action(detail=True, methods=["get"], url_path="activate/(?P<uid>[\w-]+)/(?P<token>[\w-]+)")
    def activate(self, request, uid, token):
        try:
            uid = urlsafe_base64_decode(uid).decode()
            user = get_user_model().objects.get(pk=uid)
            if user.activation_token == token:
                user.is_active = True
                user.save()
                return Response({"detail": "Account activated successfully."}, status=status.HTTP_200_OK)
            return Response({"detail": "Invalid activation link."}, status=status.HTTP_400_BAD_REQUEST)
        except Exception as e:
            return Response({"detail": "Invalid activation link."}, status=status.HTTP_400_BAD_REQUEST)