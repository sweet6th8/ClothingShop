# Generated by Django 5.1.2 on 2024-12-01 07:44

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('clothing_shop', '0006_alter_product_table'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='cartitems',
            options={'verbose_name_plural': 'CartItems'},
        ),
        migrations.AlterModelOptions(
            name='subcategory',
            options={'verbose_name_plural': 'Subcategories'},
        ),
    ]
