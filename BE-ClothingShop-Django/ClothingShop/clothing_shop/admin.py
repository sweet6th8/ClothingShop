from django.contrib import admin
from .models import Category, Product, Cart, Cartitems

@admin.register(Category)
class CategoryAdmin(admin.ModelAdmin):
    list_display = ('category_id', 'title', 'slug', 'description')
    search_fields = ('title', 'slug')

@admin.register(Product)
class ProductAdmin(admin.ModelAdmin):
    list_display = ('product_id', 'product_name', 'slug', 'price', 'stock', 'is_available', 'category')
    search_fields = ('product_name', 'slug')
    list_filter = ('is_available', 'category')
# đã đăng ký rồi

# admin.site.register(Category, CategoryAdmin)
# admin.site.register(Product, ProductAdmin)
admin.site.register(Cart)
admin.site.register(Cartitems)