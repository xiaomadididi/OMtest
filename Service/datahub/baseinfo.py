from Api.dh_api.baseinfo_api import BaseInfoAPI
from  Common.yamlutil import *
class BaseInfo:
    #查询基本信息断言
    def check_base_info(self):
        res=BaseInfoAPI().api_check_base_info()
        tenant_id=res.get('data').get('id')
        assert tenant_id == YamlUtil().read_yaml('tenant_id')