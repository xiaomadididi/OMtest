from Common.base_request import *
from  Conf.dh_config import *
class BaseInfoAPI:
    #查询基本信息详情接口
    api_check_base_info_url=dh_sever_ip() +'mds-api/mdsdata/tenant/crud/detail'
    #编辑基本信息接口
    api_edit_base_info_url=dh_sever_ip()+'mds-api/mdsdata/tenant/crud/update'

    #查询基本信息实现
    def api_check_base_info(self):
        params={}
        res=Common().get1(self.api_check_base_info_url,params=params,headers=dh_headers())
        print(res.json())
        return res.json()




if __name__ == '__main__':
    BaseInfoAPI().api_check_base_info()