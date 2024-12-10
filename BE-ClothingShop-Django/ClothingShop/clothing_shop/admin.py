from django.contrib import admin
from .models import *
from django.contrib.auth.admin import UserAdmin
from django.contrib.auth import get_user_model
from django.contrib.admin.sites import AlreadyRegistered
from django.utils.translation import gettext_lazy as _


@admin.register(Category)
class CategoryAdmin(admin.ModelAdmin):
    list_display = ('category_id', 'title', 'slug', 'description')
    search_fields = ('title', 'slug')

@admin.register(Product)
class ProductAdmin(admin.ModelAdmin):
    list_display = ('product_id', 'product_name', 'slug', 'price', 'stock', 'is_available', 'category')
    search_fields = ('product_name', 'slug')
    list_filter = ('is_available', 'category')


class CustomUserAdmin(UserAdmin):
    """Define admin model for custom User model with no username field."""
    fieldsets = (
        (None, {'fields': ('email', 'password')}),
        (_('Personal info'), {'fields': ('first_name', 'last_name')}),
        (_('Permissions'), {'fields': ('is_active', 'is_staff', 'is_superuser',
                                       'groups', 'user_permissions')}),
        (_('Important dates'), {'fields': ('last_login', 'date_joined')}),
    )

    add_fieldsets = (
        (None, {
            'classes': ('wide',),
            'fields': ('first_name', 'last_name', 'email', 'password1', 'password2'),
        }),
    )
    list_display = ('email', 'first_name', 'last_name', 'is_staff')
    search_fields = ('email', 'first_name', 'last_name')
    ordering = ('email',)

# Đảm bảo bạn đăng ký model với admin
try:
    admin.site.register(get_user_model(), CustomUserAdmin)
except AlreadyRegistered:
    pass  # Nếu model đã được đăng ký, bỏ qua.

# đã đăng ký rồi

# admin.site.register(Category, CategoryAdmin)
# admin.site.register(Product, ProductAdmin)
admin.site.register(Cart)
admin.site.register(Cartitems)
admin.site.register(Order)
admin.site.register(OrderItem)
admin.site.register(Subcategory)
admin.site.register(ProductImage)
