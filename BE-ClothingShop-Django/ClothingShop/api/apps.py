from django.apps import AppConfig


class ApiConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'api'


    def ready(self):
        # Đảm bảo signal được đăng ký khi ứng dụng được khởi động
        import api.signals