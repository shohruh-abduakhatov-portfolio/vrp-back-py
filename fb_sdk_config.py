import firebase_admin
from firebase_admin import credentials

from middleware.settings import service_account_key


cred = credentials.Certificate(service_account_key)
default_app = firebase_admin.initialize_app(cred)
