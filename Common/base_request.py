import requests

from Api.dh_api.login_api import LoginAPI
from Conf.config import *


class Common(object):
    '''
    封装通用接口
    '''

    def __init__(self):
        pass
        # # 被测系统的域名
        # self.om_url = om_server_ip()
        # self.headers = {
        #     'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36',
        #     'Authorization': om_token(),
        # }
        # self.dh_url = dh_sever_ip()
        # self.dh_headers = {
        #     'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36',
        #     'Authorization': 'Bearer '
        # }

    # # post请求，适用于Content-Type:application/x-www-form-urlencoded，即表单传参，类似some=data&xxx=xxx 的形式
    # def post_form(self, uri, data):
    #     url = self.om_url + uri
    #     res = requests.post(url, headers=self.headers, data=data)
    #     return res
    #
    # # post请求，适用于Content-Type:'application/json'，即json传参
    # def post(self, uri, data):
    #     url = self.om_url + uri
    #     res = requests.post(url, headers=self.headers, json=data)
    #     return res
    #
    # # post请求，适用于Content-Type:''，即 上传文件
    # def post_file(self, uri, file):
    #     url = self.om_url + uri
    #     res = requests.post(url, headers=self.headers, files=file)
    #     return res
    #
    # # get请求
    # def get(self, uri, data):
    #     url = self.om_url + uri
    #     res = requests.get(url, headers=self.headers, params=data)
    #     return res
    #
    # def dh_post(self, uri, data):
    #     url = self.dh_url + uri
    #     res = requests.post(url, headers=self.headers, json=data)
    #     return res

    def post1(self, url, **kwargs):
        data = kwargs.get('data')
        json = kwargs.get('json')
        files = kwargs.get('files')
        headers = kwargs.get('headers')
        res = requests.post(url, headers=headers, data=data, json=json, files=files)
        return res
    def get1(self,url,**kwargs):
        params=kwargs.get('params')
        headers = kwargs.get('headers')
        res=requests.get(url,headers=headers,params=params)
        return res


#
# if __name__ == '__main__':
    # comm = Common()
    # uri = 'plt-api/system/file/uploadSql'
    # print(comm.url_root)
    # file = {
    #     'file': open("datahub_v3.5.7.000_release_om.sql", 'rb')
    # }
    # r = comm.post_file(uri, file)
    # print(r.json())

    # comm = Common()
    # uri = 'plt-api/system/tenant/list'
    # data = {
    #     'tenantId': '',
    #     'companyName': '',
    #     'createdTime': '',
    #     'account': '',
    #     'email': '',
    #     'orgType': '',
    #     'search': '',
    #     'createdStartTime': '',
    #     'createdEndTime': '',
    #     'pageNum': '1',
    #     'pageSize': '15'
    # }
    # res = comm.get(uri, data)
    # print(res.text())
