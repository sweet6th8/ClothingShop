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
from django.shortcuts import get_object_or_404, redirect
from rest_framework.exceptions import NotAuthenticated


# from django.contrib.auth import login, logout
from rest_framework.authtoken.models import Token
# from .serializers import RegisterSerializer, LoginSerializer
import requests
from rest_framework.decorators import action
from rest_framework.permissions import AllowAny

from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity
import numpy as np

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
        Product.objects.select_related
    
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
       # """Lấy cart của user đã đăng nhập"""
        return Cart.objects.filter(user=self.request.user)

    @action(detail=False, methods=["get"], url_path="mine", permission_classes=[IsAuthenticated])
    def get_user_cart(self, request):
       # """Lấy hoặc tạo cart của user"""
        cart, created = Cart.objects.get_or_create(user=request.user)
        serializer = self.get_serializer(cart, context={'request': request})  # Truyền request vào context
        return Response(serializer.data)

    @action(detail=False, methods=['get'], url_path='total-quantity', permission_classes=[IsAuthenticated])
    def get_total_quantity(self, request):
       # """Trả về tổng số lượng sản phẩm trong giỏ hàng."""
        cart = Cart.objects.filter(user=request.user).first()
        if not cart:
            return Response({"total_quantity": 0})
        total_quantity = sum(item.quantity for item in cart.items.all())
        return Response({"total_quantity": total_quantity})

    @action(detail=False, methods=["get"], url_path="shirts", permission_classes=[IsAuthenticated])
    def get_shirts_in_cart(self, request):
        # Lọc sản phẩm áo trong giỏ hàng của người dùng
        cart = Cart.objects.filter(user=request.user).first()
        if not cart:
            return Response({"message": "Giỏ hàng không tồn tại."}, status=status.HTTP_404_NOT_FOUND)
        
        # Lọc các sản phẩm áo trong giỏ hàng
        shirts = Cartitems.objects.filter(cart=cart, product__subcategory__title__icontains="Áo")
        
        # Dùng serializer chỉ trả về tên và ảnh của sản phẩm
        serializer = SimpleProductForShirtCartSerializer(
            [item.product for item in shirts], 
            many=True, 
            context={'request': request}
        )
        
        return Response(serializer.data)




class CartitemViewSet(ModelViewSet):
    http_method_names = ["get", "post", "patch", "delete"]
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        #"""Trả về danh sách các sản phẩm trong giỏ hàng của user."""
        if not self.request.user.is_authenticated:
            raise NotAuthenticated("Bạn cần đăng nhập để thực hiện thao tác này.")
        
        cart = Cart.objects.filter(user=self.request.user).first()
        if not cart:
            # Tạo giỏ hàng nếu không tồn tại
            cart = Cart.objects.create(user=self.request.user)
        
        return Cartitems.objects.filter(cart=cart)


    def get_serializer_class(self):
        #"""Chọn serializer tương ứng với phương thức HTTP"""
        if self.request.method == "POST":
            return AddCartItemSerializer
        elif self.request.method == "PATCH":
            return UpdateCartItemSerializer
        return CartItemSerializer

    def get_serializer_context(self):
       # """Truyền cart_id từ user vào context của serializer."""
        if not self.request.user.is_authenticated:
            raise NotAuthenticated("Bạn cần đăng nhập để thực hiện thao tác này.")
       # """Truyền thêm request và cart_id vào context của serializer."""
        context = super().get_serializer_context()
        cart = Cart.objects.filter(user=self.request.user).first()
        if not cart:
            raise NotFound("Giỏ hàng không tồn tại.")
        context.update({
            "cart_id": cart.id,
            "request": self.request  # Truyền thêm request vào context
        })
        return context


    
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
        return {
            "user_id": self.request.user.id,
            "request": self.request,  # Thêm request vào context
        }

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        # Lấy id của Order từ serializer
        order_id = serializer.save()

        # Trả về id của Order
        return Response({"order_id": order_id}, status=201)

    
    @action(detail=True, methods=['POST'])
    def pay(self, request, pk):
        order = self.get_object()
        amount = order.total_price
        email = request.user.email
        order_id = str(order.id)
        # redirect_url = "http://127.0.0.1:8000/confirm"
        return initiate_payment(amount, email, order_id)
    
    @action(detail=False,  methods=["GET", "POST"], permission_classes=[AllowAny])
    def confirm_payment(self, request):
        order_id = request.GET.get("o_id")
        order = Order.objects.get(id=order_id)
        
        # Cập nhật trạng thái đơn hàng là "Completed" (hoàn thành)
        order.pending_status = "C"
        order.save()

        serializer = OrderSerializer(order)
        
        data = {
            "msg": "Payment was successful",
            "data": serializer.data
        }
        return Response(data)

    
def initiate_payment(amount, email, order_id):
    url = "https://api.flutterwave.com/v3/payments"
    headers = {
        "Authorization": f"Bearer {settings.FLW_SEC_KEY}"
    }
    # Giả sử tỷ giá là 1 USD = 24,000 VND
    exchange_rate = 24000
    amount_in_usd = round(amount / exchange_rate, 2)  # Chuyển đổi VND sang USD
    data = {
        "tx_ref": str(uuid.uuid4()),
        "amount": str(amount_in_usd),  # Gửi số tiền đã chuyển đổi
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
        print("Response Status Code:", response.status_code)
        print("Response Text:", response.text)
        
        # Kiểm tra nếu phản hồi không phải là JSON
        if response.status_code == 200:
            response_data = response.json()
            return Response(response_data)
        else:
            return Response({"error": "Payment initiation failed", "details": response.text}, status=500)
    
    except requests.exceptions.RequestException as err:
        print("The payment didn't go through:", err)
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




class CustomUserViewSet(UserViewSet):
    permission_classes = [AllowAny]  # Cấp quyền truy cập cho tất cả

    @action(detail=False, methods=["get"], url_path="activate/(?P<uid>[\w-]+)/(?P<token>[\w-]+)")
    def activate(self, request, uid, token):
        print(f"uid: {uid}, token: {token}")
        try:
            # Gọi API kích hoạt người dùng qua POST request
            response = requests.post(
                'http://127.0.0.1:8000/auth/users/activation/',  # Đảm bảo URL chính xác
                data={'uid': uid, 'token': token}
            )

            if response.status_code == 204:
                # Nếu thành công, chuyển hướng đến trang login của frontend
                return redirect("http://localhost:3000/login")
            else:
                # Nếu có lỗi, trả về thông báo lỗi
                return JsonResponse({"error": "Không thể kích hoạt tài khoản. Vui lòng thử lại."}, status=400)

        except requests.exceptions.RequestException as e:
            # Nếu có lỗi trong quá trình gọi API, trả về lỗi
            return JsonResponse({"error": "Có lỗi xảy ra. Vui lòng thử lại sau."}, status=500)

class RecommendedProductView(APIView):
    permission_classes = [AllowAny]
    def get(self, request, selected_product_id, top_n=12):
        print("selected_product_id", selected_product_id)
        try:
            # Lấy sản phẩm đã chọn
            selected_product = Product.objects.select_related('category', 'subcategory').get(product_id=selected_product_id)
            
            # Lấy tất cả sản phẩm trong cùng danh mục, loại bỏ sản phẩm đã chọn
            products = Product.objects.select_related('category', 'subcategory').exclude(product_id=selected_product_id).filter(
                category_id=selected_product.category_id
            )
            
            # Tạo danh sách mô tả kết hợp cho sản phẩm đã chọn và các sản phẩm trong cùng danh mục
            descriptions = [
                f"{selected_product.product_name} {selected_product.category.title} {selected_product.subcategory.title} {selected_product.description}"
            ]
            for product in products:
                description = f"{product.product_name} {product.category.title} {product.subcategory.title} {product.description}"
                descriptions.append(description)
            
            # Tính TF-IDF cho mô tả của các sản phẩm
            vectorizer = TfidfVectorizer()
            tfidf_matrix = vectorizer.fit_transform(descriptions)
            
            # Tính độ tương đồng cosine giữa sản phẩm đã chọn và các sản phẩm còn lại
            similarity_scores = cosine_similarity(tfidf_matrix[0:1], tfidf_matrix[1:]).flatten()
            
            # Sắp xếp sản phẩm theo độ tương đồng từ cao đến thấp
            sorted_indices = np.argsort(similarity_scores)[::-1]
            
            # Lấy top_n sản phẩm gợi ý
            products_list = list(products) # Chuyển QuerySet thành danh sách
            recommended_products = [products_list[index] for index in sorted_indices[:top_n]]

            # Chuyển đổi các sản phẩm gợi ý thành dữ liệu có thể trả về dưới dạng JSON
            serializer = ProductSerializer(recommended_products, many=True)
            
            return Response(serializer.data, status=status.HTTP_200_OK)
        
        except Product.DoesNotExist:
            return Response({"detail": "Sản phẩm không tồn tại."}, status=status.HTTP_404_NOT_FOUND)

