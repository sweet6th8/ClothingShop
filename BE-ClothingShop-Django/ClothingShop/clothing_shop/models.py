from django.db import models
from django.contrib.auth.models import AbstractUser, BaseUserManager
import uuid

# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `# managed = False ` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models

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
    
    
    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = []

    objects = UserManager()

class Category(models.Model):
    category_id = models.UUIDField(default=uuid.uuid4, editable=False, primary_key=True, unique=True)
    title = models.CharField(unique=True, max_length=200)
    slug = models.SlugField(default=None, blank=True, null=True)
    description = models.TextField(blank=True, null=True)



    def __str__(self):
        return self.title


class Product(models.Model):
    product_id = models.UUIDField(default=uuid.uuid4, editable=False, primary_key=True, unique=True)
    product_name = models.CharField(unique=True, max_length=200)
    slug = models.SlugField(default=None, blank=True, null=True)
    description = models.TextField(blank=True, null=True)
    price = models.IntegerField()
    image = models.ImageField(upload_to = 'img', blank=True, null=True, default='')
    stock = models.IntegerField()
    is_available = models.IntegerField(blank=True, null=True)
    category = models.ForeignKey(Category, models.DO_NOTHING, blank=True, null=True)

    def __str__(self):
        return self.product_name
    
class ProductImage(models.Model):
    product = models.ForeignKey(Product, on_delete=models.CASCADE, related_name="images")
    image = models.ImageField(upload_to = 'img', blank=True, null=True, default='')
    
class Cart(models.Model):
    id = models.UUIDField(default=uuid.uuid4, primary_key=True)
    created = models.DateTimeField(auto_now_add=True)
    

    def __str__(self):
        return str(self.id)
    

class Cartitems(models.Model):
    cart = models.ForeignKey(Cart, on_delete=models.CASCADE, related_name="items", blank=True, null=True)
    product = models.ForeignKey(Product, on_delete=models.CASCADE, blank=True, null=True, related_name='cartitems')
    quantity = models.PositiveSmallIntegerField(default=0)
    
