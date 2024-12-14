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
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'rest_framework',
    'api.apps.ApiConfig',   #sử dụng AppConfig của 'api'
    'clothing_shop',
    'django_filters',
    'djoser',
    'corsheaders',
    'django_extensions',
    'drf_yasg',
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
        'DIRS': [],
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

# Internationalization
# https://docs.djangoproject.com/en/5.1/topics/i18n/

LANGUAGE_CODE = 'en-us'

TIME_ZONE = 'UTC'

USE_I18N = True

USE_TZ = True


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/5.1/howto/static-files/

STATIC_URL = 'static/'

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
}

# JWT Settings
SIMPLE_JWT = {
    'AUTH_HEADER_TYPES': ('Bearer',),
    "ACCESS_TOKEN_LIFETIME": timedelta(minutes=5),
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

FLW_SEC_KEY  ='FLWSECK_TEST-825d260605a1fb0170d7af0cc15520f5-X'
FLW_PUB_KEY = "FLWPUBK_TEST-617743b4ad9d84020bc285ed618887b3-X"

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

