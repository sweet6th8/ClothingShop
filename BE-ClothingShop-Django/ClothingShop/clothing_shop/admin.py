from django.contrib import admin
from .models import Category, Product, Cart, Cartitems, User
from django.contrib.auth.admin import UserAdmin
from django.contrib.auth import get_user_model
from django.contrib.admin.sites import AlreadyRegistered

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
    # fieldsets = (
    #     (None, {'fields': ('email', 'password')}),
    #     (_('Personal info'), {'fields': ('first_name', 'last_name')}),
    #     (_('Permissions'), {'fields': ('is_active', 'is_staff', 'is_superuser',
    #                                    'groups', 'user_permissions')}),
    #     (_('Important dates'), {'fields': ('last_login', 'date_joined')}),
    # )
    add_fieldsets = (
        (None, {
            'classes': ('wide',),
            'fields': ( 'first_name', 'last_name', 'email', 'password1', 'password2'),
        }),
    )
    list_display = ('email', 'first_name', 'last_name', 'is_staff')
    search_fields = ('email', 'first_name', 'last_name')
    ordering = ('email',)


try:
    admin.site.register(get_user_model(), CustomUserAdmin)
except AlreadyRegistered:
    pass  # Model đã được đăng ký, bỏ qua việc đăng ký lại
# đã đăng ký rồi

# admin.site.register(Category, CategoryAdmin)
# admin.site.register(Product, ProductAdmin)
admin.site.register(Cart)
admin.site.register(Cartitems)
