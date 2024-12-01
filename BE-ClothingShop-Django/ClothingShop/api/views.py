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
from rest_framework.pagination import PageNumberPagination
from rest_framework.parsers import MultiPartParser, FormParser
from rest_framework.permissions import IsAuthenticated
from rest_framework.permissions import IsAuthenticatedOrReadOnly

# from django.contrib.auth import login, logout
from rest_framework.authtoken.models import Token
# from .serializers import RegisterSerializer, LoginSerializer
import requests
from rest_framework.decorators import action

# Create your views here.

class ProductViewSet(ModelViewSet):
    queryset = Product.objects.all() # lấy tất cả products
    serializer_class = ProductSerializer
    filter_backends = [DjangoFilterBackend, SearchFilter, OrderingFilter]
    filterset_class = ProductFilter
    search_fields = ['product_name', 'description']
    ordering_fields = ['price']
    pagination_class = PageNumberPagination

    # lấy danh sách sản phẩm ngẫu nhiên
    @action(detail=False, methods=['get'])
    def random(self, request):
        random_products = Product.objects.order_by('?')[:10]  # Lấy 10 sản phẩm ngẫu nhiên
        serializer = self.get_serializer(random_products, many=True)
        return Response(serializer.data)
    
    def create(self, request, *args, **kwargs):
        return super().create(request, *args, **kwargs)


class CategoryViewSet(ModelViewSet):
    queryset = Category.objects.all() # lấy tất cả categories
    serializer_class = CategorySerializer



class SubcategoryViewSet(ModelViewSet):
    queryset = Subcategory.objects.all()
    serializer_class = SubcategorySerializer
    permission_classes = [IsAuthenticatedOrReadOnly]
    
    def perform_create(self, serializer):
        category_id = self.request.data.get('category_id')
        category = Category.objects.get(id=category_id)
        serializer.save(category=category)

class CartViewSet(CreateModelMixin, RetrieveModelMixin, DestroyModelMixin, GenericViewSet):
    #RetrieveModelMixin: lấy ra 
    #DestroyModelMixin: delete cart
    queryset = Cart.objects.all()
    serializer_class = CartSerializer

class CartitemViewSet(ModelViewSet):
    http_method_names = ["get", "post", "patch", "delete"]
    
    # Lấy danh sách các sp trong cart dựa trên cart_id
    def get_queryset(self):
        return Cartitems.objects.filter(cart_id=self.kwargs["cart_pk"])

    
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
    permission_classes = [IsAuthenticated]
    
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

    
