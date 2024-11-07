from django.core.mail import send_mail
from django.conf import settings
from django.shortcuts import render
from django.http import HttpResponse
from clothing_shop.models import Category, Product, Order, Customer

def send_order_confirmation(order_id):
    # Lấy thông tin đơn hàng từ database
    order = Order.objects.get(id=order_id)

    subject = 'Xác nhận đơn hàng của bạn'
    message = f'Chào {order.customer.name},\n\n'
    message = f'Cảm ơn bạn đã đặt hàng với chúng tôi. Đơn hàng: {product.product_name} của bạn đã được xác nhận.'
    message += "" #order_items, order_date ..etc
    
    recipient_email = "abc@gmail.com" #customer email
    
    send_mail(
        subject,
        message,
        settings.DEFAULT_FROM_EMAIL,
        [recipient_email],
        fail_silently=False,
    )
    
    return HttpResponse('Đã gửi email xác nhận đơn hàng.')

