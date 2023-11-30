import json

import requests


# def get_uuid():
#     url='http://platformtest.eclincloud.net/plt-api/auth/slide/code/image'
#     header={
#         'Accept':'application/json, text/plain, */*',
#         'Accept-Language':'zh-CN,zh;q=0.9',
#         'Connection':'keep-alive',
#         'Cookie':'Admin-Expires-In=720',
#         'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36',
#         'X-KL-Ajax-Request':'Ajax_Request',
#         'isToken':'false'
#     }
#     params={'model':1}
#     r=requests.get(url=url,headers=header,params=params)
#     data=r.json()
#     print(data)
#     uuid=data.get('data').get('uuid')
#     print(uuid)
#     return uuid
# def get_token():
#     url='http://platformtest.eclincloud.net/plt-api/auth/login'
#     header = {
#         'Accept': 'application/json, text/plain, */*',
#         'Accept-Language': 'zh-CN,zh;q=0.9',
#         'Connection': 'keep-alive',
#         'Cookie': 'Admin-Expires-In=720',
#         'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36',
#         'X-KL-Ajax-Request': 'Ajax_Request',
#         'isToken': 'false'
#     }
#     data={
#         "username": "admin",
#         "password": "admin123",
#         "xposition": 218,
#         "uuid": get_uuid()
#     }
#     r=requests.post(url=url,headers=header,data=data)
#     re=r.json()
#     print(re)
#     # token=re.get('data').get('access_token')
#     # print(token)
#     # return token
# 上传脚本文件

def get_upload_path():
    url = 'http://platformtest.eclincloud.net/plt-api/system/file/uploadSql'
    header = {
        # 'Accept': 'application/json, text/plain, */*',
        # 'Accept-Language': 'zh-CN,zh;q=0.9',
        # 'Connection': 'keep-alive',
        # 'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36',
        # 'X-KL-Ajax-Request': 'Ajax_Request',
        'Authorization': Authorization,

    }

    path = {
        'file': open("../../files/datahub_v3.5.7.000_release_om.sql", 'rb')
    }
    r = requests.post(url=url, headers=header, files=path)
    # print(r.json())
    file_path = r.json().get('data')
    print(file_path)
    return file_path


# 添加初始化升级脚本
def save_initscript():
    url = 'http://platformtest.eclincloud.net/plt-api/system/initScript/save'
    header = {
        'Accept': 'application/json, text/plain, */*',
        'Accept-Language': 'zh-CN,zh;q=0.9',
        'Connection': 'keep-alive',
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36',
        'X-KL-Ajax-Request': 'Ajax_Request',
        # 'Content-Type': 'application/json',
        'Authorization': Authorization,


    }
    data = {
        'sysId': '1',
        'subsystemVersion': "3.5.7.000_release",
        'sqlPath': get_upload_path(),
        'fileName': "datahub_v3.5.7.000_release_om (1).sql"
    }
    r = requests.post(url=url, headers=header, json=data)
    result = r.json()
    print(result)


# 获取初子系统初始化列表
Authorization = 'eyJhbGciOiJIUzUxMiJ9.eyJ1c2VyX2lkIjoxLCJ1c2VyX2tleSI6IjA4YTdiNTgyLTQzNTItNDA2Ni1hZmM2LTRjZDEzMGQzZjY4YyIsInVzZXJuYW1lIjoiYWRtaW4ifQ.lt9zZibWJkWGVplzegunpJLpkWnEyXAExR7b2IMDiuyYde5wHg2g1A3NTT6h7gEQG6KIk2eLBkrojlW_XmUdvQ'
# def get_initScript():
#     url = 'http://platformtest.eclincloud.net/plt-api/system/initScript/list'
#     header = {
#         'Accept': 'application/json, text/plain, */*',
#         'Accept-Language': 'zh-CN,zh;q=0.9',
#         'Connection': 'keep-alive',
#         'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36',
#         'X-KL-Ajax-Request': 'Ajax_Request',
#         'Authorization': Authorization
#
#     }
#     params = {'sysId': '1'}
#     r = requests.get(url=url, headers=header, params=params)
#     print(r.json())

'''
1.获取地区
2.获取组织类型
3.获取数据库、网关配置

'''
#新建租户

def create_tenant():
    url='http://platformtest.eclincloud.net/plt-api/system/tenant/create'
    header={
        'Accept': 'application/json, text/plain, */*',
        'Accept-Language': 'zh-CN,zh;q=0.9',
        'Connection': 'keep-alive',
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36',
        'X-KL-Ajax-Request': 'Ajax_Request',
        # 'Content-Type': 'application/json',
        'Authorization': Authorization,


    }
    data={
            "companyName": "DH初始化测试31",
            "icon": "ac029325ae09480b89cbfe384879af73.jpg",
            "countryId": "1",
            "provinceId": "2",
            "cityId": "3",
            "address": "test",
            "orgType": "hospital_main",
            "dataSourceId": "12",
            "emailGatewayId": "1",
            "tenantType": 1,
            "loginCheckType": 2,
            "languageFlag": 1,
            "superAdmin": {
                "account": "admin1025",
                "email": "areloma13@snapmail.cc",
                "password": "admin123"
            }
        }

    r=requests.post(url=url,headers=header,json=data)
    print(r.json())


if __name__ == '__main__':
    # get_dept()
    # get_uuid()
    # get_token()
    # get_initScript()
    get_upload_path()
    # save_initscript()
    # create_tenant()
