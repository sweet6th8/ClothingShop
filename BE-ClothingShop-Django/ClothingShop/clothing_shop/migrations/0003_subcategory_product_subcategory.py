# Generated by Django 5.1.2 on 2024-12-01 05:23

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('clothing_shop', '0002_alter_cart_id'),
    ]

    operations = [
        migrations.CreateModel(
            name='Subcategory',
            fields=[
                ('subcategory_id', models.AutoField(primary_key=True, serialize=False)),
                ('title', models.CharField(max_length=200)),
                ('slug', models.SlugField(blank=True, default=None, null=True)),
                ('description', models.TextField(blank=True, null=True)),
                ('category', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='subcategories', to='clothing_shop.category')),
            ],
            options={
                'db_table': 'Subcategory',
            },
        ),
        migrations.AddField(
            model_name='product',
            name='subcategory',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='clothing_shop.subcategory'),
        ),
    ]
