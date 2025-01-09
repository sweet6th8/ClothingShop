from django.http import JsonResponse
from django.db.models import Sum
from .models import OrderItem

def sales_by_category_view(request):
    sales_data = OrderItem.objects.values('product__category__title').annotate(total_sales=Sum('quantity'))
    data = list(sales_data)
    return JsonResponse(data, safe=False)