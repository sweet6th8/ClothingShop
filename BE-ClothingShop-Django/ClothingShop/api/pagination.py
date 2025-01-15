from rest_framework.pagination import PageNumberPagination
from rest_framework.response import Response

class CustomPagination(PageNumberPagination):
    page_size = 12  # Số lượng mục mỗi trang   
    max_page_size = 100  # Giới hạn số lượng tối đa

    def get_paginated_response(self, data):
        """
        Tùy chỉnh phản hồi phân trang để bao gồm các thông tin như total_pages, current_page, page_size
        """
        return Response({
            'total_count': self.page.paginator.count,  
            'total_pages': self.page.paginator.num_pages,  
            'current_page': self.page.number,  
            'page_size': self.page.paginator.per_page,  
            'results': data  
        })
