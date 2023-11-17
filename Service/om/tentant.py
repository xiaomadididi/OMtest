import time

import pytest

from Common.utils import *

from Api.om_api.tenant_api import *
from Service.om.script import *
from Common.yamlutil import *

class Tenant:
    # 创建租户
    def create_tenant(self):
        companyName = YamlUtil().read_yaml('file_version') + get_random_num()
        account = "admin" + get_random_num()
        email = get_random_mail()
        password = "0192023A7BBD73250516F069DF18B500"
        res = TenantAPI().api_create_tenant(companyName, account, email, password)
        msg = res.get('msg')
        assert msg == '操作成功'
        return companyName

    # 获取租户列表,验证租户添加成功并返回租户id
    def get_tenant_id(self):

        res = TenantAPI().api_get_tenant_list()
        YamlUtil().write_yaml({'tenant_id':res['tenant_id']})
        YamlUtil().write_yaml({'tenant_name': res['tenant_name']})
        YamlUtil().write_yaml({'admin_accout': res['admin_accout']})
        return res


    # 进入子系统管理页面,获取所有子系统code码
    def test_get_sys_code(self):
        pass

    # 添加子系统应用授权
    def create_license(self,applicationId):
        tenantId = YamlUtil().read_yaml('tenant_id')
        tenantName = YamlUtil().read_yaml('tenant_name')
        applicationId = applicationId
        res = TenantAPI().api_create_license(tenantId, tenantName, applicationId)
        msg = res.get('msg')
        assert msg == '操作成功'

    # 获取子系统列表，验证添加子系统成功
    def get_liencens_list(self):
        tenantId=YamlUtil().read_yaml('tenant_id')
        res=TenantAPI().api_get_tenant_license_list(tenantId)
        return res

    # 初始化子系统
    def init_subsystem(self):
        liencensList=self.get_liencens_list()
        tenantId= YamlUtil().read_yaml('tenant_id')
        res = TenantAPI().api_create_initsysterm(tenantId,liencensList)
        msg = res.get('msg')
        print(res)
        assert msg == '操作成功'

    # 获取初始化进度
    def init_progress(self):
        tenantId=YamlUtil().read_yaml('tenant_id')
        res = TenantAPI().api_get_initprogress(tenantId)
        assert self.get_liencens_list()[0] in res, f'{self.get_liencens_list()[0]}:初始化未完成或失败'

if __name__ == '__main__':
   pytest.main()