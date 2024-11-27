from django.db import models
import uuid

# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `# managed = False ` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models



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
    
