from django.db import models

# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class AuthGroup(models.Model):
    name = models.CharField(unique=True, max_length=150)

    class Meta:
        managed = False
        db_table = 'auth_group'


class AuthGroupPermissions(models.Model):
    id = models.BigAutoField(primary_key=True)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)
    permission = models.ForeignKey('AuthPermission', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_group_permissions'
        unique_together = (('group', 'permission'),)


class AuthPermission(models.Model):
    name = models.CharField(max_length=255)
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING)
    codename = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'auth_permission'
        unique_together = (('content_type', 'codename'),)



class Category(models.Model):
    category_id = models.AutoField(primary_key=True)
    title = models.CharField(unique=True, max_length=200)
    slug = models.CharField(unique=True, max_length=200)
    description = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'category'

    def __str__(self):
        return self.title
    
class ClothingShopCategory(models.Model):
    category_id = models.AutoField(primary_key=True)
    title = models.CharField(unique=True, max_length=200)
    slug = models.CharField(unique=True, max_length=200)
    description = models.TextField()

    class Meta:
        managed = False
        db_table = 'clothing_shop_category'


class ClothingShopProduct(models.Model):
    product_id = models.AutoField(primary_key=True)
    product_name = models.CharField(unique=True, max_length=200)
    slug = models.CharField(unique=True, max_length=200)
    description = models.TextField()
    price = models.IntegerField()
    images = models.CharField(max_length=100)
    stock = models.IntegerField()
    is_available = models.IntegerField()
    category = models.ForeignKey(ClothingShopCategory, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'clothing_shop_product'


class CoreUser(models.Model):
    id = models.BigAutoField(primary_key=True)
    password = models.CharField(max_length=128)
    last_login = models.DateTimeField(blank=True, null=True)
    is_superuser = models.IntegerField()
    first_name = models.CharField(max_length=150)
    last_name = models.CharField(max_length=150)
    is_staff = models.IntegerField()
    is_active = models.IntegerField()
    date_joined = models.DateTimeField()
    email = models.CharField(unique=True, max_length=254)

    class Meta:
        managed = False
        db_table = 'core_user'


class CoreUserGroups(models.Model):
    id = models.BigAutoField(primary_key=True)
    user = models.ForeignKey(CoreUser, models.DO_NOTHING)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'core_user_groups'
        unique_together = (('user', 'group'),)


class CoreUserUserPermissions(models.Model):
    id = models.BigAutoField(primary_key=True)
    user = models.ForeignKey(CoreUser, models.DO_NOTHING)
    permission = models.ForeignKey(AuthPermission, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'core_user_user_permissions'
        unique_together = (('user', 'permission'),)


class DjangoAdminLog(models.Model):
    action_time = models.DateTimeField()
    object_id = models.TextField(blank=True, null=True)
    object_repr = models.CharField(max_length=200)
    action_flag = models.PositiveSmallIntegerField()
    change_message = models.TextField()
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING, blank=True, null=True)
    user = models.ForeignKey(CoreUser, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'django_admin_log'


class DjangoContentType(models.Model):
    app_label = models.CharField(max_length=100)
    model = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'django_content_type'
        unique_together = (('app_label', 'model'),)


class DjangoMigrations(models.Model):
    id = models.BigAutoField(primary_key=True)
    app = models.CharField(max_length=255)
    name = models.CharField(max_length=255)
    applied = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_migrations'


class DjangoSession(models.Model):
    session_key = models.CharField(primary_key=True, max_length=40)
    session_data = models.TextField()
    expire_date = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_session'


class Product(models.Model):
    product_id = models.AutoField(primary_key=True)
    product_name = models.CharField(unique=True, max_length=200)
    slug = models.CharField(unique=True, max_length=200)
    description = models.TextField(blank=True, null=True)
    price = models.IntegerField()
    images = models.CharField(max_length=255, blank=True, null=True)
    stock = models.IntegerField()
    is_available = models.IntegerField(blank=True, null=True)
    category = models.ForeignKey(Category, models.DO_NOTHING, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'product'


class StoreappCart(models.Model):
    cart_id = models.CharField(primary_key=True, max_length=32)
    created = models.DateTimeField()
    completed = models.IntegerField()
    owner = models.ForeignKey('UserprofileCustomer', models.DO_NOTHING, blank=True, null=True)
    session_id = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'storeapp_cart'


class StoreappCartitems(models.Model):
    id = models.BigAutoField(primary_key=True)
    quantity = models.IntegerField()
    cart = models.ForeignKey(StoreappCart, models.DO_NOTHING, blank=True, null=True)
    product = models.ForeignKey('StoreappProduct', models.DO_NOTHING, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'storeapp_cartitems'


class StoreappCategory(models.Model):
    title = models.CharField(max_length=200)
    category_id = models.CharField(primary_key=True, max_length=32)
    slug = models.CharField(max_length=50)
    featured_product = models.OneToOneField('StoreappProduct', models.DO_NOTHING, blank=True, null=True)
    icon = models.CharField(max_length=100, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'storeapp_category'


class StoreappProduct(models.Model):
    name = models.CharField(max_length=200)
    description = models.TextField(blank=True, null=True)
    discount = models.IntegerField()
    image = models.CharField(max_length=100, blank=True, null=True)
    old_price = models.FloatField()
    slug = models.CharField(max_length=50)
    id = models.CharField(primary_key=True, max_length=32)
    inventory = models.IntegerField()
    top_deal = models.IntegerField()
    flash_sales = models.IntegerField()
    category = models.ForeignKey(StoreappCategory, models.DO_NOTHING, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'storeapp_product'


class StoreappSaveditem(models.Model):
    id = models.BigAutoField(primary_key=True)
    owner = models.ForeignKey('UserprofileCustomer', models.DO_NOTHING, blank=True, null=True)
    product = models.ForeignKey(StoreappProduct, models.DO_NOTHING, blank=True, null=True)
    added = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'storeapp_saveditem'


class UserprofileAddress(models.Model):
    id = models.BigAutoField(primary_key=True)
    home_address = models.CharField(max_length=50)
    bus_stop = models.CharField(max_length=20)
    city = models.CharField(max_length=20)
    state = models.CharField(max_length=20)
    customer = models.OneToOneField('UserprofileCustomer', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'userprofile_address'


class UserprofileCustomer(models.Model):
    id = models.BigAutoField(primary_key=True)
    user = models.OneToOneField(CoreUser, models.DO_NOTHING)
    email = models.CharField(unique=True, max_length=100, blank=True, null=True)
    first_name = models.CharField(max_length=100, blank=True, null=True)
    last_name = models.CharField(max_length=100, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'userprofile_customer'