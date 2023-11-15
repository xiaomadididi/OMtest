import requests
from Common.yamlutil import *


def get_token():
    url = 'http://clinical-test.eclincloud.net/mds-api/plt/auth/verificationCode'
    data = {
        "account": YamlUtil().read_yaml('admin_accout'),
        "password": "0192023A7BBD73250516F069DF18B500",
        "verificationCode": "612106",
        "rememberCheck": 2
    }
    headers = {
        'User - Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36',
        'appId': '1'
    }
    res = requests.post(url=url, json=data, headers=headers)
    print(res.json())
    account_id = res.json().get('data').get('userId')
    access_token = res.json().get('data').get('accessToken')
    tenant_id = res.json().get('data').get('tenantVoList')[0].get('tenantId')

    return {'account_id': account_id, 'access_token': access_token, 'tenant_id': tenant_id}


if __name__ == '__main__':
    get_token()

