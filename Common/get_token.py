import pytest
import requests
from Common.yamlutil import *

'''
超管登录

'''
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
    YamlUtil().write_yaml({'account_id':account_id})
    YamlUtil().write_yaml({'access_token':access_token})
    # YamlUtil().write_yaml({'tenant_id':tenant_id})

    return {'account_id': account_id, 'access_token': access_token, 'tenant_id': tenant_id}

# '''
# 普通用户登录 获取token
# '''
#
def user_login():
    url = 'http://clinical-test.eclincloud.net/mds-api/plt/auth/verificationCode'
    data = {
        "account": YamlUtil().read_yaml('account_email'),
        "password": "2BC1514D90296DDDA5016E52BAA2A6CE",
        "verificationCode": "612106",
        "rememberCheck": 2
    }
    headers = {
        'User - Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36',
        'appId': '1'
    }
    res = requests.post(url=url, json=data, headers=headers)

    account_id = res.json().get('data').get('userId')
    access_token = res.json().get('data').get('accessToken')
    tenant_id = res.json().get('data').get('tenantVoList')[0].get('tenantId')
    # print(access_token)
    YamlUtil().write_yaml({'account_id':account_id})
    YamlUtil().write_yaml({'access_token':access_token})
    # YamlUtil().write_yaml({'user_tenant_id':tenant_id})


if __name__ == '__main__':
    user_login()

