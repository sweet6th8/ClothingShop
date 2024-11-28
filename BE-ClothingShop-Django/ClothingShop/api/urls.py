from django.urls import path, include
from . import views
from rest_framework.routers import DefaultRouter
from .views import CategoryViewSet, ProductViewSet, CartViewSet, CartitemViewSet, ProfileViewSet
from rest_framework_nested import routers



router = routers.DefaultRouter()

router.register(r'categories', CategoryViewSet, basename='Categories')
router.register(r'products', ProductViewSet, basename='Products')
router.register(r'carts', CartViewSet, basename='Carts')
router.register('n_profiles', ProfileViewSet, basename='Profiles')


cart_router = routers.NestedDefaultRouter(router, "carts", lookup="cart")
cart_router.register("items", CartitemViewSet, basename="cart-items")

urlpatterns = [
    path('', include(router.urls)),
    path('', include(cart_router.urls)),
]
