from django.urls import path, include
from . import views
from rest_framework.routers import DefaultRouter
from .views import *
from rest_framework_nested import routers



router = routers.DefaultRouter()

router.register(r'categories', CategoryViewSet, basename='Categories')

router.register(r'products', ProductViewSet, basename='Products')
router.register(r'carts', CartViewSet, basename='Carts')
router.register('n_profiles', ProfileViewSet, basename='Profiles')
router.register('orders', OrderViewSet, basename='Orders')



cart_router = routers.NestedDefaultRouter(router, "carts", lookup="cart")
cart_router.register("items", CartitemViewSet, basename="cart-items")

# Khởi tạo router phụ cho Subcategory (Danh mục con)
subcategory_router = routers.NestedDefaultRouter(router, r'categories', lookup='category')
subcategory_router.register(r'subcategories', SubcategoryViewSet, basename='Subcategories')

urlpatterns = [
    path('', include(router.urls)),
    path('', include(cart_router.urls)),
    path('', include(subcategory_router.urls)),
]
