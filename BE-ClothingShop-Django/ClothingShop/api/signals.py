from django.db.models.signals import post_save
from django.dispatch import receiver
from clothing_shop.models import Cart, User

import logging

logger = logging.getLogger(__name__)
@receiver(post_save, sender=User)
def create_cart_for_new_user(sender, instance, created, **kwargs):
    """Tạo giỏ hàng cho người dùng sau khi người dùng mới được tạo"""
    if created:
        logger.info(f"User {instance.username} created. Creating a cart.")
        Cart.objects.get_or_create(user=instance)