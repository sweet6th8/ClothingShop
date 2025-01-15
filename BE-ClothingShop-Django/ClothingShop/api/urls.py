from django.urls import path, include
from . import views
from rest_framework.routers import DefaultRouter
from .views import *
from rest_framework_nested import routers
from rest_framework_simplejwt.views import (
    TokenObtainSlidingView,
    TokenRefreshSlidingView,
)

router = routers.DefaultRouter()
router.register(r'categories', CategoryViewSet, basename='Categories')
router.register(r'products', ProductViewSet, basename='Products')
router.register('n_profiles', ProfileViewSet, basename='Profiles')
router.register('orders', OrderViewSet, basename='Orders')
router.register(r'subcategories', SubcategoryViewSet)
router.register(r'carts', CartViewSet, basename='Carts')
router.register(r'cart-items', CartitemViewSet, basename='CartItems')

urlpatterns = [
    path('', include(router.urls)),
    path('token/', TokenObtainSlidingView.as_view(), name='token_obtain'),
    path('token/refresh/', TokenRefreshSlidingView.as_view(), name='token_refresh'),
    path('activate/<uid>/<token>/', CustomUserViewSet.as_view({'get': 'activate'}), name='user-activate'),  
    path('products/recommended/<int:selected_product_id>/', RecommendedProductView.as_view(), name='recommended-products')
]
