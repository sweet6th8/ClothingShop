# Generated by Django 5.1.2 on 2024-11-27 09:21

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('clothing_shop', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='cartitems',
            name='quantity',
            field=models.PositiveSmallIntegerField(default=0),
        ),
    ]