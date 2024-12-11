from django.urls import path, include
from . import views
from rest_framework.routers import DefaultRouter
from .views import *
from rest_framework_nested import routers
from rest_framework_simplejwt.views import (
    TokenObtainSlidingView,
    TokenRefreshSlidingView,
)
# from .views import predict_images





router = routers.DefaultRouter()

router.register(r'categories', CategoryViewSet, basename='Categories')

router.register(r'products', ProductViewSet, basename='Products')
router.register(r'carts', CartViewSet, basename='Carts')
router.register('n_profiles', ProfileViewSet, basename='Profiles')
router.register('orders', OrderViewSet, basename='Orders')

router.register(r'subcategories', SubcategoryViewSet)

# Khởi tạo router con cho các Cartitems
cart_router = routers.NestedDefaultRouter(router, r'carts', lookup='cart')
cart_router.register(r'items', CartitemViewSet, basename='CartItems')


# Khởi tạo router phụ cho Subcategory (Danh mục con)
# subcategory_router = routers.NestedDefaultRouter(router, r'categories', lookup='category')
# subcategory_router.register(r'subcategories', SubcategoryViewSet, basename='Subcategories')

urlpatterns = [
    path('', include(router.urls)),
    path('', include(cart_router.urls)),
    path('token/', TokenObtainSlidingView.as_view(), name='token_obtain'),
    path('token/refresh/', TokenRefreshSlidingView.as_view(), name='token_refresh'),
    # path("predict/", predict_images, name="predict_images"),
    path('activate/<uid>/<token>/', CustomUserViewSet.as_view({'get': 'activate'}), name='user-activate'),  # Đăng ký view kích hoạt


]
