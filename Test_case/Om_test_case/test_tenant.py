import time

import Common.common
from Common import common
from Common.common import *
from Common.utils import *
from Test_case.Om_test_case.test_script import *


class TestTenant:
    # 获取地区
    def test_get_country(self):
        pass

    # 获取组织
    def test_get_or(self):
        pass

    # 获取数据库配置
    def test_get_database_config(self):
        pass

    # 创建租户
    def test_create_tenant(self):
        companyName=Testscript().test_upload_sql()['file_version'] + get_random_num()
        uri = 'plt-api/system/tenant/create'
        data = {
            "companyName":companyName,
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
                "account": "admin" + get_random_num(),
                "email": get_random_mail(),
                "password": "0192023A7BBD73250516F069DF18B500"
            }
        }

        res = Common().post(uri, data)
        msg = res.json().get('msg')
        assert msg == '操作成功'
        return companyName

    # 获取租户列表,验证租户添加成功并返回租户id
    def test_get_tenant_id(self):
        uri = 'plt-api/system/tenant/list'
        data = {
            'tenantId': '',
            'companyName': '',
            'createdTime': '',
            'account': '',
            'email': '',
            'orgType': '',
            'search': '',
            'createdStartTime': '',
            'createdEndTime': '',
            'pageNum': '1',
            'pageSize': '15'
        }
        res = Common().get(uri, data)
        tenant_name = res.json().get('rows')[0].get('companyName')
        tenant_id = res.json().get('rows')[0].get('id')
        admin_accout = res.json().get('rows')[0].get('account')
        print(tenant_name)
        return {'tenant_id': tenant_id, 'tenant_name': tenant_name, 'admin_accout': admin_accout}

    # 进入子系统管理页面,获取所有子系统code码
    def test_get_sys_code(self):
        pass

    # 添加子系统应用授权
    def test_create_license(self):
        uri = 'plt-api/tenantLicense/tenantLicense/create'
        data = {
            "tenantId": self.test_get_tenant_id()['tenant_id'],
            "tenantName": self.test_get_tenant_id()['tenant_name'],
            "applicationId": [
                "1"
            ],
            "validityStartTime": get_start_time(),
            "validityEndTime": get_end_time(),
            "itemDtos": []

        }
        res = Common().post(uri, data)
        msg = res.json().get('msg')
        # print(res.json())
        assert msg == '操作成功'

    # 获取子系统列表，验证添加子系统成功
    def test_get_liencens_list(self):
        uri = 'plt-api/tenantLicense/tenantLicense/list'
        data = {
            'applicationId': '',
            'tenantId': self.test_get_tenant_id()['tenant_id'],
            'createdTime': '',
            'createdStartTime': '',
            'createdEndTime': '',
            'initStatus': '',
            'search': '',
            'pageNum': '1',
            'pageSize': '15'

        }
        res = Common().get(uri, data)
        application_id = res.json().get('rows')[0].get('applicationId')
        application_ids = []
        for row in res.json().get('rows'):
            a_id = row['applicationId']
            application_ids.append(a_id)
        print(application_ids)
        assert application_id in application_ids
        return application_ids

    # 初始化子系统
    def test_init_subsystem(self):
        uri = 'plt-api/system/tenant/initSubSystem'
        data = {
            "tenantId": self.test_get_tenant_id()['tenant_id'],
            "sysIdList": [self.test_get_liencens_list()[-1]]
        }
        res = Common().post(uri, data)
        msg = res.json().get('msg')
        print(res.json())
        assert msg == '操作成功'
        time.sleep(10)

    # 获取初始化进度
    def test_init_progress(self):
        uri = 'plt-api/system/tenant/queryInitProgress'
        data = {
            'tenantId': self.test_get_tenant_id()['tenant_id']
        }
        res = Common().get(uri, data)
        success_list = res.json().get('data').get('successList')
        success_sys_ids = []
        for success in success_list:
            s_id = success['sysId']
            success_sys_ids.append(s_id)
        assert self.test_get_liencens_list()[-1] in success_sys_ids, f'{self.test_get_liencens_list()[-1]}:初始化失败'
