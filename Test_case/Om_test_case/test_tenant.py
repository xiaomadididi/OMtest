import time

import Common.base_request
from Common import base_request
from Common.base_request import *
from Common.utils import *
from Test_case.Om_test_case.test_script import *
from Api.om_api.tenant_api import *

class TestTenant:
    # 创建租户
    def test_create_tenant(self):
        companyName = Testscript().test_upload_sql()['file_version'] + get_random_num()
        account = "admin" + get_random_num()
        email = get_random_mail()
        password = "0192023A7BBD73250516F069DF18B500"
        res = TenantAPI().api_create_tenant(companyName, account, email, password)
        msg = res.get('msg')
        assert msg == '操作成功'
        return companyName

    # 获取租户列表,验证租户添加成功并返回租户id
    def test_get_tenant_id(self):
        res = TenantAPI().api_get_tenant_list()
        return res

    # 进入子系统管理页面,获取所有子系统code码
    def test_get_sys_code(self):
        pass

    # 添加子系统应用授权
    def test_create_license(self):
        tenantId = self.test_get_tenant_id()['tenant_id']
        tenantName = self.test_get_tenant_id()['tenant_name']
        applicationId = ['1','8']
        res = TenantAPI().api_create_license(tenantId, tenantName, applicationId)
        msg = res.get('msg')
        assert msg == '操作成功'

    # 获取子系统列表，验证添加子系统成功
    def test_get_liencens_list(self):
        tenantId=self.test_get_tenant_id()['tenant_id']
        res=TenantAPI().api_get_tenant_license_list(tenantId)
        return res

    # 初始化子系统
    def test_init_subsystem(self):
        liencensList=self.test_get_liencens_list()
        tenantId= self.test_get_tenant_id()['tenant_id']
        res = TenantAPI().api_create_initsysterm(tenantId,liencensList)
        msg = res.get('msg')
        assert msg == '操作成功'

    # 获取初始化进度
    def test_init_progress(self):
        tenantId=self.test_get_tenant_id()['tenant_id']
        res = TenantAPI().api_get_initprogress(tenantId)
        assert self.test_get_liencens_list()[0] in res, f'{self.test_get_liencens_list()[-1]}:初始化未完成或失败'

if __name__ == '__main__':
   pytest.main()