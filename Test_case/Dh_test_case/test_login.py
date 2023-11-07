from Common.base_request import *
from Common.utils import *
import requests

class TestLogin:
    def test_bind_authenticator(self):
        url='http://clinical-test.eclincloud.net/mds-api/plt/auth/bindAuthenticator'
        headers={
            'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36'
        }
        data={
                "account": "admin361",
                "verificationCode": "612106",
                "password": "0192023A7BBD73250516F069DF18B500"
            }
        res=requests.post(url=url,headers=headers,json=data)
        print(res.json())

    def test_login(self):
        url='http://clinical-test.eclincloud.net/mds-api/plt/auth/verificationCode'
        headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36'
        }
        data = {
                "account": "admin361",
                "password": "0192023A7BBD73250516F069DF18B500",
                "verificationCode": "612106",
                "rememberCheck": 2
        }
        res = requests.post(url=url, headers=headers, json=data)
        print(res.json())

