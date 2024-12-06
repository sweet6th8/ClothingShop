# Generated by Django 5.1.2 on 2024-12-01 07:24

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('clothing_shop', '0003_subcategory_product_subcategory'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='product',
            name='image',
        ),
        migrations.AlterField(
            model_name='product',
            name='is_available',
            field=models.BooleanField(default=True),
        ),
        migrations.AlterField(
            model_name='productimage',
            name='image',
            field=models.ImageField(blank=True, default='', null=True, upload_to='product_images/'),
        ),
        migrations.AlterModelTable(
            name='product',
            table=None,
        ),
        migrations.AlterModelTable(
            name='productimage',
            table=None,
        ),
    ]
