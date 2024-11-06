from django.urls import path, include
from . import views
from rest_framework.routers import DefaultRouter
from .views import CategoryViewSet, ProductViewSet
from rest_framework_nested import routers




router = routers.DefaultRouter()
router.register(r'categories', CategoryViewSet, basename='Categories')
router.register(r'products', ProductViewSet, basename='Products')

urlpatterns = [
    path('', include(router.urls)),
]
