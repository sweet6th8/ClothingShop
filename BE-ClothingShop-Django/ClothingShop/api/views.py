from urllib import response
# from django.shortcuts import render, get_object_or_404
# from rest_framework.decorators import api_view
from .serializers import ProductSerializer, CategorySerializer, CartSerializer, CartItemSerializer, AddCartItemSerializer, UpdateCartItemSerializer
from clothing_shop.models import Category, Product, Cart, Cartitems
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


# from django.contrib.auth import login, logout
from rest_framework.authtoken.models import Token
# from .serializers import RegisterSerializer, LoginSerializer
# Create your views here.

class ProductViewSet(ModelViewSet):
    queryset = Product.objects.all() # lấy tất cả products
    serializer_class = ProductSerializer
    filter_backends = [DjangoFilterBackend, SearchFilter, OrderingFilter]
    filterset_class = ProductFilter
    search_fields = ['product_name', 'description']
    ordering_fields = ['price']
    pagination_class = PageNumberPagination

class CategoryViewSet(ModelViewSet):
    queryset = Product.objects.all() # lấy tất cả categories
    serializer_class = CategorySerializer

# # View cho đăng ký
# class RegisterView(APIView):
#     def post(self, request):
#         serializer = RegisterSerializer(data=request.data)
#         if serializer.is_valid():
#             user = serializer.save()
#             token, created = Token.objects.get_or_create(user=user)
#             return Response({'token': token.key}, status=status.HTTP_201_CREATED)
#         return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

# # View cho đăng nhập
# class LoginView(APIView):
#     def post(self, request):
#         serializer = LoginSerializer(data=request.data)
#         if serializer.is_valid():
#             user = serializer.validated_data
#             token, created = Token.objects.get_or_create(user=user)
#             login(request, user)
#             return Response({'token': token.key}, status=status.HTTP_200_OK)
#         return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

# # View cho đăng xuất
# class LogoutView(APIView):
#     def post(self, request):
#         request.user.auth_token.delete()
#         logout(request)
#         return Response(status=status.HTTP_204_NO_CONTENT)

class CartViewSet(CreateModelMixin, RetrieveModelMixin, DestroyModelMixin, GenericViewSet):
    #RetrieveModelMixin: lấy ra 
    #DestroyModelMixin: delete cart
    queryset = Cart.objects.all()
    serializer_class = CartSerializer

class CartitemViewSet(ModelViewSet):
    http_method_names = ["get", "post", "patch", "delete"]
    
    def get_queryset(self):
        return Cartitems.objects.filter(cart_id=self.kwargs["cart_pk"])

    
    def get_serializer_class(self):
        # add item to cart
        if self.request.method == "POST":
            return AddCartItemSerializer
        # update cart item
        elif self.request.method == "PATCH":
            return UpdateCartItemSerializer
        
        return CartItemSerializer
    
    def get_serializer_context(self):
        return {"cart_id": self.kwargs["cart_pk"]}
    
    
