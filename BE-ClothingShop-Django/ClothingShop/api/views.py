from urllib import response
from django.shortcuts import render, get_object_or_404
from rest_framework.decorators import api_view
from .serializers import ProductSerializer, CategorySerializer
from clothing_shop.models import Category, Product
from rest_framework.response import Response
from rest_framework import status
from rest_framework.views import APIView
from rest_framework import viewsets
from api import serializers
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.filters import SearchFilter, OrderingFilter
from api.filters import ProductFilter
from rest_framework.pagination import PageNumberPagination


from django.contrib.auth import login, logout
from rest_framework.authtoken.models import Token
from .serializers import RegisterSerializer, LoginSerializer
# Create your views here.

class ProductViewSet(viewsets.ModelViewSet):
    queryset = Product.objects.all() # lấy tất cả products
    serializer_class = ProductSerializer
    filter_backends = [DjangoFilterBackend, SearchFilter, OrderingFilter]
    filterset_class = ProductFilter
    search_fields = ['product_name', 'description']
    ordering_fields = ['price']
    pagination_class = PageNumberPagination

class CategoryViewSet(viewsets.ModelViewSet):
    queryset = Product.objects.all() # lấy tất cả categories
    serializer_class = ProductSerializer

# View cho đăng ký
class RegisterView(APIView):
    def post(self, request):
        serializer = RegisterSerializer(data=request.data)
        if serializer.is_valid():
            user = serializer.save()
            token, created = Token.objects.get_or_create(user=user)
            return Response({'token': token.key}, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

# View cho đăng nhập
class LoginView(APIView):
    def post(self, request):
        serializer = LoginSerializer(data=request.data)
        if serializer.is_valid():
            user = serializer.validated_data
            token, created = Token.objects.get_or_create(user=user)
            login(request, user)
            return Response({'token': token.key}, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

# View cho đăng xuất
class LogoutView(APIView):
    def post(self, request):
        request.user.auth_token.delete()
        logout(request)
        return Response(status=status.HTTP_204_NO_CONTENT)

   