import os
from dotenv import load_dotenv

load_dotenv()

user = os.environ.get('user')
password = os.environ.get('password')
account = os.environ.get('account')
warehouse = os.environ.get('warehouse')
database = os.environ.get('database')
schema = os.environ.get('schema')