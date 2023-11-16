import requests
class Common:
    '''
    封装通用接口
    '''
    #初始化一个session对象
    sess=requests.session()
    def post1(self, url, **kwargs):
        data = kwargs.get('data')
        json = kwargs.get('json')
        files = kwargs.get('files')
        headers = kwargs.get('headers')
        res = Common().sess.post(url, headers=headers, data=data, json=json, files=files)
        return res
    def get1(self,url,params=None,**kwargs):
        params=kwargs.get('params')
        headers = kwargs.get('headers')
        res=Common().sess.get(url,headers=headers,params=params)
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
