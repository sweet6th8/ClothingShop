"""
Django settings for ClothingShop project.

Generated by 'django-admin startproject' using Django 5.1.2.

For more information on this file, see
https://docs.djangoproject.com/en/5.1/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/5.1/ref/settings/
"""
from dotenv import load_dotenv

from pathlib import Path
from datetime import timedelta
import os

load_dotenv()  # Tải biến môi trường từ file .env
# Build paths inside the project like this: BASE_DIR / 'subdir'.
BASE_DIR = Path(__file__).resolve().parent.parent


# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/5.1/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = 'django-insecure-ys*6d+hk&7*g8czzzu=s46!iayjfg3euw8oe3dk$7rx$8o0hxc'

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

ALLOWED_HOSTS = []


# Application definition

INSTALLED_APPS = [
    'jazzmin',
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'django.contrib.sites',
    'rest_framework',
    'api.apps.ApiConfig',   #sử dụng AppConfig của 'api'
    'django_filters',
    'djoser',
    'corsheaders',
    'django_extensions',
    'drf_yasg',
    'allauth',
    'allauth.account',
    'allauth.socialaccount',
    'allauth.socialaccount.providers.google',
    'allauth.socialaccount.providers.facebook',
    'dj_rest_auth',
    'clothing_shop',
]

MIDDLEWARE = [
    'corsheaders.middleware.CorsMiddleware',  # Đặt ở đầu
    'django.middleware.common.CommonMiddleware',  
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    'api.middleware.CartMiddleware', # Đặt ở sau những tác vụ như xác thực
    'allauth.account.middleware.AccountMiddleware',
    
]

CORS_ALLOW_CREDENTIALS = True

CORS_ALLOWED_ORIGINS = [
    "http://localhost:3000",
    "http://127.0.0.1:3000",
]

ROOT_URLCONF = 'ClothingShop.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [os.path.join(BASE_DIR, 'templates')],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'ClothingShop.wsgi.application'


# Database
# https://docs.djangoproject.com/en/5.1/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': os.environ.get('DB_NAME'),
        'USER': os.environ.get('DB_USER'),      
        'PASSWORD': os.environ.get('DB_PASS'),  
        'HOST': '127.0.0.1',     
        'PORT': '3306',        
    }
}


# Password validation
# https://docs.djangoproject.com/en/5.1/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]
AUTH_USER_MODEL = "clothing_shop.User"

AUTHENTICATION_BACKENDS = [
    'django.contrib.auth.backends.ModelBackend',
    'allauth.account.auth_backends.AuthenticationBackend',
]

SOCIALACCOUNT_PROVIDERS = {
    'google': {
        'APP': {
            'client_id': '1054340593759-qujai5gu4cth1mim4bupamj08ch5ke9b.apps.googleusercontent.com',
            'secret': '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'
        },
        'SCOPE': ['profile', 'email',],
        'AUTH_PARAMS': {'access_type': 'online'},
        'METHOD': 'oauth2',
        'VERIFIED_EMAIL': True,
    },

    'facebook': {
        'APP': {
            'client_id': '',
            'secret': ''
        }
    }
}

# Internationalization
# https://docs.djangoproject.com/en/5.1/topics/i18n/

LANGUAGE_CODE = 'en-us'

TIME_ZONE = 'UTC'

USE_I18N = True

USE_TZ = True


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/5.1/howto/static-files/

STATIC_URL = 'static/'

#Allauth

# django-allauth yêu cầu cấu hình SITE_ID
SITE_ID = 1

# Đặt trang chủ sau khi đăng nhập
LOGIN_REDIRECT_URL = '/'

# Đặt trang chủ sau khi đăng xuất
LOGOUT_REDIRECT_URL = '/'

# Email là bắt buộc khi đăng ký
ACCOUNT_EMAIL_REQUIRED = True

# Xác thực email (True nếu muốn gửi email xác nhận)
ACCOUNT_EMAIL_VERIFICATION = True  # Hoặc 'mandatory'

# Cho phép đăng nhập bằng email
ACCOUNT_AUTHENTICATION_METHOD = "email"

SOCIALACCOUNT_LOGIN_ON_GET=True

ACCOUNT_USER_MODEL_USERNAME_FIELD = None

ACCOUNT_USERNAME_REQUIRED = False

# Default primary key field type
# https://docs.djangoproject.com/en/5.1/ref/settings/#default-auto-field

DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'

REST_FRAMEWORK = {
    'DEFAULT_AUTHENTICATION_CLASSES': (
        'rest_framework_simplejwt.authentication.JWTAuthentication',
    ),
    'DEFAULT_PERMISSION_CLASSES': (
        'rest_framework.permissions.IsAuthenticated',
    ),
    'TOKEN_MODEL': None,
}

# JWT Settings
SIMPLE_JWT = {
    'AUTH_HEADER_TYPES': ('Bearer',),
    "ACCESS_TOKEN_LIFETIME": timedelta(minutes=30),
    "REFRESH_TOKEN_LIFETIME": timedelta(days=1),
    "ROTATE_REFRESH_TOKENS": True,
    "UPDATE_LAST_LOGIN": True,
}
# Các endpoint của djoser:
# Djoser cung cấp các endpoint để thực hiện các chức năng liên quan đến người dùng như:

# Đăng ký người dùng:

# POST /auth/users/ - Đăng ký một người dùng mới. (username, email, password cần thiết).
# Đăng nhập và lấy token JWT:

# POST /auth/token/login/ - Đăng nhập và lấy token JWT (cung cấp username và password).
# POST /auth/token/logout/ - Đăng xuất và hủy token JWT.
# Thông tin người dùng hiện tại:

# GET /auth/users/me/ - Lấy thông tin người dùng đã đăng nhập (cần xác thực).
# Thay đổi mật khẩu:

# POST /auth/users/set_password/ - Thay đổi mật khẩu người dùng.
# POST /auth/users/reset_password/ - Reset mật khẩu cho người dùng.

#   "refresh": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTczMjgzNjAxNiwiaWF0IjoxNzMyNzQ5NjE2LCJqdGkiOiI1YWQ2MDRlMWFhY2E0N2Q4OTgxMmU3MGEyMWFlMDZhMCIsInVzZXJfaWQiOjF9._90RhuFWjlrC-uEzxEOUon5un6xT21bDzCZWbpd0V90",
#     "access": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzMyNzQ5OTE2LCJpYXQiOjE3MzI3NDk2MTYsImp0aSI6ImIxODk4MGQ5MjY5YjQzNDNiNmY3NGFlYzNmYzQzNWNkIiwidXNlcl9pZCI6MX0.5d5hEWgFFoG8xwPW7tilG5ru3yeeE9GrcyILXlHhVbs"

#Djoser Settings
DJOSER = {
    'LOGIN_FIELD': 'email',
    'USER_CREATE_PASSWORD_RETYPE':True,
    'ACTIVATION_URL':'api/activate/{uid}/{token}',
    'SEND_ACTIVATION_EMAIL':True,
    'SEND_CONFIRMATION_EMAIL':True,
    'PASSWORD_CHANGED_EMAIL_CONFIRMATION':True,
    'PASSWORD_RESET_CONFIRM_URL': 'password-reset/{uid}/{token}',
    'SET_PASSWORD_RETYPE': True,
    'PASSWORD_RESET_SHOW_EMAIL_NOT_FOUND': True,
    'TOKEN_MODEL': None,       # To Delete User Must Set it to None
    'SERIALIZERS':{
        'user_create': 'api.serializers.MyUserCreateSerializer',
        'user': 'api.serializers.MyUserCreateSerializer',
        'user_delete': 'djoser.serializers.UserDeleteSerializer',
    },
    # 'EMAIL': {
    #     'activation': 'api.email.ActivationEmail',
    #     'confirmation': 'api.email.ConfirmationEmail',
    #     'password_reset': 'api.email.PasswordResetEmail',
    #     'password_changed_confirmation': 'api.email.PasswordChangedConfirmationEmail',
    # },
    'EMAIL': {
        
            'activation': 'djoser.email.ActivationEmail',
            'confirmation': 'djoser.email.ConfirmationEmail',
            'password_reset': 'djoser.email.PasswordResetEmail',
            'password_changed_confirmation': 'djoser.email.PasswordChangedConfirmationEmail',
            'username_changed_confirmation': 'djoser.email.UsernameChangedConfirmationEmail',
            'username_reset': 'djoser.email.UsernameResetEmail',

    },


}



# Email Configuration
EMAIL_BACKEND = "django.core.mail.backends.smtp.EmailBackend"
EMAIL_HOST = 'smtp.gmail.com'
EMAIL_PORT = 587
EMAIL_HOST_USER = os.environ.get('EMAIL_USER')
EMAIL_HOST_PASSWORD = os.environ.get('EMAIL_PASS')
EMAIL_USE_TLS = True

FLW_SEC_KEY  ='FLWSECK_TEST-fade50af0051fad55c5db5d0063b39d7-X'
FLW_PUB_KEY = "FLWPUBK_TEST-0732ebd993df7c9b4c3ce01158df156a-X"

MEDIA_URL = '/media/'  # URL truy cập file media
MEDIA_ROOT = os.path.join(BASE_DIR, 'media')  # Đường dẫn lưu trữ file media


SWAGGER_SETTINGS = {
    'SECURITY_DEFINITIONS': {
        'Bearer': {
            'type': 'apiKey',
            'name': 'Authorization',
            'in': 'header',
        },
    },
    'USE_SESSION_AUTH': False,
}

JAZZMIN_SETTINGS = {
    "theme": "default",
    "theme_toggle": True,
    "site_title": "Admin",
    "site_header": "Clothing shop",
    "site_brand": "Clothing shop",
    "welcome_sign": "Welcome to Clothing Shop Admin",

    #logo
    # "site_logo": "/media/logo.png",
    "login_logo": None,
    "login_logo_dark": None,
    "site_logo_classes": "img-circle",

    #top menu
    "topmenu_links": [
        {"name": "Home",  "url": "admin:index", "permissions": ["auth.view_user"]},

        {"name": "Github", "url": "https://github.com/sweet6th8/ClothingShop", "new_window": True},

        {"app": "clothingShop"},
    ],

    "search_model": ["clothing_shop.user", "auth.Group"],

    #user menu
    "usermenu_links": [
        {"model": "clothing_shop.user"}
    ],

    # Custom links to append to app groups, keyed on app name
    "custom_links": {
        
    },

    # Custom icons for side menu apps/models
    "icons": {
        "auth": "fas fa-users-cog",
        "clothing_shop.cart": "fas fa-shopping-cart",
        "clothing_shop.cartitems": "fas fa-box-open",
        "clothing_shop.category": "fas fa-list-alt",
        "clothing_shop.orderitem": "fas fa-box",
        "clothing_shop.order": "fas fa-clipboard-list",
        "clothing_shop.productimage": "fas fa-image",
        "clothing_shop.product": "fas fa-boxes",
        "clothing_shop.subcategory": "fas fa-list-alt",
        "clothing_shop.user": "fas fa-user",
        "auth.Group": "fas fa-users",
    },
    "default_icon_parents": "fas fa-chevron-circle-right",
    "default_icon_children": "fas fa-circle",

    # "related_modal_active": True,
    # "show_ui_builder": True,
}

JAZZMIN_UI_TWEAKS = {
    "navbar_small_text": False,
    "footer_small_text": False,
    "body_small_text": False,
    "brand_small_text": False,
    "brand_colour": "navbar-lightblue",
    "accent": "accent-primary",
    "navbar": "navbar-white navbar-light",
    "no_navbar_border": True,
    "navbar_fixed": True,
    "layout_boxed": False,
    "footer_fixed": False,
    "sidebar_fixed": True,
    "sidebar": "sidebar-dark-lightblue",
    "sidebar_nav_small_text": False,
    "sidebar_disable_expand": False,
    "sidebar_nav_child_indent": False,
    "sidebar_nav_compact_style": False,
    "sidebar_nav_legacy_style": False,
    "sidebar_nav_flat_style": True,
    "theme": "default",
    "dark_mode_theme": None,
    "button_classes": {
        "primary": "btn-primary",
        "secondary": "btn-secondary",
        "info": "btn-info",
        "warning": "btn-warning",
        "danger": "btn-danger",
        "success": "btn-success"
    },
    "actions_sticky_top": True
}
