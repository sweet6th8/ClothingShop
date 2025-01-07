import datetime

from django.db import models
from django.contrib.auth.models import AbstractUser, BaseUserManager
import uuid
from  django.conf import settings

# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `# managed = False ` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models

from api import vnpay


class UserManager(BaseUserManager):
   # """Define a model manager for User model with no username field."""

    def _create_user(self, email, password=None, **extra_fields):
    #    """Create and save a User with the given email and password."""
        if not email:
            raise ValueError('The given email must be set')
        email = self.normalize_email(email)
        user = self.model(email=email, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_user(self, email, password=None, **extra_fields):
        extra_fields.setdefault('is_staff', False)
        extra_fields.setdefault('is_superuser', False)
        return self._create_user(email, password, **extra_fields)

    def create_superuser(self, email, password=None, **extra_fields):
     #   """Create and save a SuperUser with the given email and password."""
        extra_fields.setdefault('is_staff', True)
        extra_fields.setdefault('is_superuser', True)

        if extra_fields.get('is_staff') is not True:
            raise ValueError('Superuser must have is_staff=True.')
        if extra_fields.get('is_superuser') is not True:
            raise ValueError('Superuser must have is_superuser=True.')

        return self._create_user(email, password, **extra_fields)


class User(AbstractUser):
    username = None
    email = models.EmailField(unique=True)
    is_active = models.BooleanField(default=False)  # Đảm bảo user không được kích hoạt mặc định
    
    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = []

    objects = UserManager()

    class Meta:
        db_table = 'User'  # Tên bảng trong cơ sở dữ liệu

class Category(models.Model):
    category_id = models.AutoField(primary_key=True)
    title = models.CharField(unique=True, max_length=200)
    slug = models.SlugField(default=None, blank=True, null=True)
    description = models.TextField(blank=True, null=True)

    def __str__(self):
        return self.title
    
    class Meta:
        db_table = 'Category'
        verbose_name_plural = 'Categories'  # Tên số nhiều

class Subcategory(models.Model):
    subcategory_id = models.AutoField(primary_key=True) 
    title = models.CharField(max_length=200)  
    slug = models.SlugField(default=None, blank=True, null=True)  
    description = models.TextField(blank=True, null=True)  
    category = models.ForeignKey(Category, on_delete=models.CASCADE, related_name="subcategories")  

    def __str__(self):
        return self.title  # Tên của subcategory

    class Meta:
        db_table = 'Subcategory'  # Tên bảng trong cơ sở dữ liệu
        verbose_name_plural = 'Subcategories' 



class Product(models.Model):
    product_id = models.AutoField(primary_key=True)
    product_name = models.CharField(unique=True, max_length=200)
    slug = models.SlugField(default=None, blank=True, null=True)
    description = models.TextField(blank=True, null=True)
    price = models.IntegerField()
    stock = models.IntegerField()
    is_available = models.BooleanField(default=True)
    category = models.ForeignKey(Category, models.DO_NOTHING, blank=True, null=True)
    subcategory = models.ForeignKey(Subcategory, on_delete=models.CASCADE, blank=True, null=True)  # Liên kết với Subcategory

    def __str__(self):
        return self.product_name
    
    class Meta:
        db_table = 'Product' 

class ProductImage(models.Model):
    product = models.ForeignKey(Product, related_name='images', on_delete=models.CASCADE)
    image = models.ImageField(upload_to='product_images/',  blank=True, null=True, default='')

    def __str__(self):
        return f"Image for {self.product.product_name}"
    
    class Meta:
        db_table = 'ProductImage'
    
class Cart(models.Model):
    id = models.AutoField(primary_key=True)
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name="cart")
    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)  # Thêm trường updated_at để lưu thay đổi cuối

    def __str__(self):
        return str(self.id)
    
    class Meta:
        db_table = 'Cart'

    

class Cartitems(models.Model):
    cart = models.ForeignKey(Cart, on_delete=models.CASCADE, related_name="items", blank=True, null=True)
    product = models.ForeignKey(Product, on_delete=models.CASCADE, blank=True, null=True, related_name='cartitems')
    quantity = models.PositiveSmallIntegerField(default=0)
    
    class Meta:
        db_table = 'CartItem'
        verbose_name_plural = 'CartItems' 
        unique_together = ('cart', 'product')  # Đảm bảo một sản phẩm chỉ xuất hiện một lần trong giỏ hàng
        

class Profile(models.Model):
    name = models.CharField(max_length=30)
    bio = models.TextField()
    picture = models.ImageField(upload_to='img', blank=True, null=True)

    def __str__(self):
        return self.name
    
    class Meta:
        db_table = 'Profile'

 
class Order(models.Model):
    PAYMENT_STATUS_PENDING = 'P'
    PAYMENT_STATUS_COMPLETE = 'C'
    PAYMENT_STATUS_FAILED = 'F'
    
    PAYMENT_STATUS_CHOICES = [
        (PAYMENT_STATUS_PENDING, 'Pending'),
        (PAYMENT_STATUS_COMPLETE, 'Complete'),
        (PAYMENT_STATUS_FAILED, 'Failed'),
    ]
    placed_at = models.DateTimeField(auto_now_add=True)
    pending_status = models.CharField(
        max_length=50, choices=PAYMENT_STATUS_CHOICES, default='PAYMENT_STATUS_PENDING')
    owner = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.PROTECT)
    
    def __str__(self):
        return self.pending_status
    
    class Meta:
        db_table = 'Order'

    @property 
    def total_price(self):
        items = self.items.all()
        total = sum([item.quantity * item.product.price for item in items])
        return total



class OrderItem(models.Model):
    order = models.ForeignKey(Order, on_delete=models.PROTECT, related_name = "items")
    product = models.ForeignKey(Product, on_delete=models.PROTECT)
    quantity = models.PositiveSmallIntegerField()
    

    def __str__(self):
        return self.product.product_name
    
    class Meta:
        db_table = 'OrderItem'

class Payment(models.Model):
    amount = models.IntegerField()  # Số tiền thanh toán
    status = models.CharField(max_length=20, default='pending')  # Trạng thái giao dịch
    created_at = models.DateTimeField(auto_now_add=True)  # Thời gian tạo giao dịch
    updated_at = models.DateTimeField(auto_now=True)  # Thời gian cập nhật giao dịch

    def __str__(self):
        return f'Payment {self.id} - {self.status}'