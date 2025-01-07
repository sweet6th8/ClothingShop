import hashlib
import hmac
from urllib.parse import urlencode, quote_plus

class VNPay:
    def __init__(self, vnp_TmnCode, vnp_HashSecret, vnp_Url):
        self.vnp_TmnCode = vnp_TmnCode
        self.vnp_HashSecret = vnp_HashSecret
        self.vnp_Url = vnp_Url
        self.params = {}

    def add_param(self, key, value):
        self.params[key] = value

    def get_payment_url(self):
        sorted_params = sorted(self.params.items())
        query_string = urlencode(sorted_params, quote_via=quote_plus)
        hash_data = '&'.join([f"{key}={value}" for key, value in sorted_params])
        hmac_obj = hmac.new(
            bytes(self.vnp_HashSecret, 'utf-8'),
            bytes(hash_data, 'utf-8'),
            hashlib.sha512
        )
        secure_hash = hmac_obj.hexdigest()
        return f"{self.vnp_Url}?{query_string}&vnp_SecureHash={secure_hash}"

    @staticmethod
    def verify_response(response_params, vnp_HashSecret):
        vnp_SecureHash = response_params.pop('vnp_SecureHash', None)
        sorted_params = sorted(response_params.items())
        hash_data = '&'.join([f"{key}={value}" for key, value in sorted_params])
        hmac_obj = hmac.new(
            bytes(vnp_HashSecret, 'utf-8'),
            bytes(hash_data, 'utf-8'),
            hashlib.sha512
        )
        secure_hash = hmac_obj.hexdigest()
        return secure_hash == vnp_SecureHash


