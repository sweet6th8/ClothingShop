from django.http import JsonResponse
from django.db.models import Count
from .models import Product

def products_by_category_view(request):
    product_data = Product.objects.values('category__title').annotate(total_products=Count('product_id'))
    data = list(product_data)
    return JsonResponse(data, safe=False)