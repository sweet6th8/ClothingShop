from django.contrib import admin
from .models import *
from django.contrib.auth.admin import UserAdmin
from django.contrib.auth import get_user_model
from django.contrib.admin.sites import AlreadyRegistered
from django.utils.translation import gettext_lazy as _
from django.urls import path
from django.utils.safestring import mark_safe 
from django.template.response import TemplateResponse
from . import admin_views
from .models import OrderItem, Cart, Cartitems, Subcategory, ProductImage, Order

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
    def index(self):
        return self.render('admin/index.html', stats=admin_views.products_by_category_view())
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

# Hiển Thị Các Trạng Thái Thân Thiện Trong Admin
class OrderAdmin(admin.ModelAdmin):
    list_display = ('id', 'owner', 'pending_status_display', 'placed_at', 'total_price')
    
    def pending_status_display(self, obj):
        return obj.get_pending_status_display()
    pending_status_display.short_description = 'Payment Status'


# đã đăng ký rồi
admin.site.register(OrderItem)
admin.site.register(Cart)
admin.site.register(Cartitems)
admin.site.register(Subcategory)
admin.site.register(ProductImage)
admin.site.register(Order, OrderAdmin)
