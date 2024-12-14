from django.utils.deprecation import MiddlewareMixin
from clothing_shop.models import Cart

class CartMiddleware(MiddlewareMixin):
    def process_request(self, request):
        # Kiểm tra xem user đã được xác thực chưa
        if request.user.is_authenticated:
            # Nếu đã đăng nhập, lấy giỏ hàng của user (nếu có)
            try:
                cart, created = Cart.objects.get_or_create(user=request.user)
                request.cart = cart  # Gắn giỏ hàng vào request
            except Cart.DoesNotExist:
                request.cart = None
        else:
            request.cart = None
