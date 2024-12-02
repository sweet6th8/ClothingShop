from django_filters.rest_framework import FilterSet
from clothing_shop.models import Product
import django_filters


class ProductFilter(FilterSet):
     # Lọc theo category_id
    category_id = django_filters.NumberFilter(field_name='category_id', lookup_expr='exact')
    
    # Lọc theo subcategory_id
    subcategory_id = django_filters.NumberFilter(field_name='subcategoryư_id', lookup_expr='exact')
    
    # Lọc theo giá (price) với các điều kiện lớn hơn và nhỏ hơn
    price__gt = django_filters.NumberFilter(field_name='price', lookup_expr='gt')  # Lọc theo giá lớn hơn
    price__lt = django_filters.NumberFilter(field_name='price', lookup_expr='lt')  # Lọc theo giá nhỏ hơn

    class Meta:
        model = Product
        fields = ['category_id', 'subcategory_id', 'price__gt', 'price__lt']