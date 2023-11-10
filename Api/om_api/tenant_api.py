import time

from Common.base_request import *
from Common.utils import *

class TenantAPI:
    # 创建租户接口
    api_create_tenant_url = om_server_ip() + 'plt-api/system/tenant/create'
    # 获取租户列表接口
    api_get_tenant_list_url=om_server_ip() + 'plt-api/system/tenant/list'
    #创建子系统接口
    api_create_license_url=om_server_ip() + "plt-api/tenantLicense/tenantLicense/create"
    #获取租户子系统列表接口
    api_get_tenant_license_list_url=om_server_ip()+'plt-api/tenantLicense/tenantLicense/list'
    #初始化子系统接口
    api_create_initsysterm_url=om_server_ip()+'plt-api/system/tenant/initSubSystem'
    #获取初始化进度接口
    api_get_initprogress_url=om_server_ip()+'plt-api/system/tenant/queryInitProgress'

    # 创建租户实现
    def api_create_tenant(self, companyName, account, email, password):
        json = {
            "companyName": companyName,
            "icon": "ac029325ae09480b89cbfe384879af73.jpg",
            "countryId": "1",
            "provinceId": "2",
            "cityId": "3",
            "address": "test",
            "orgType": "hospital_main",
            "dataSourceId": "12",
            "emailGatewayId": "1",
            "tenantType": 1,
            "loginCheckType": 1,
            "languageFlag": 1,
            "superAdmin": {
                "account": account,
                "email": email,
                "password": password
            }
        }
        res = Common().post1(self.api_create_tenant_url, json=json, headers=om_headers())
        return res.json()
    #获取租户列表实现
    def api_get_tenant_list(self):
        params = {
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
        res = Common().get1(self.api_get_tenant_list_url, params=params,headers=om_headers())
        tenant_name = res.json().get('rows')[0].get('companyName')
        tenant_id = res.json().get('rows')[0].get('id')
        admin_accout = res.json().get('rows')[0].get('account')
        print(tenant_name)
        return {'tenant_id': tenant_id, 'tenant_name': tenant_name, 'admin_accout': admin_accout}


    # 添加子系统实现
    def api_create_license(self, tenantId, tenantName, applicationId):
        json = {
            "tenantId": tenantId,
            "tenantName": tenantName,
            "applicationId":applicationId,
            "validityStartTime": get_start_time(),
            "validityEndTime": get_end_time(),
            "itemDtos": []
        }
        res = Common().post1(self.api_create_license_url, json=json, headers=om_headers())
        return res.json()
    #获取已添加子系统列表实现
    def api_get_tenant_license_list(self,tenantId):
        params = {
        'applicationId': '',
        'tenantId': tenantId,
        'createdTime': '',
        'createdStartTime': '',
        'createdEndTime': '',
        'initStatus': '',
        'search': '',
        'pageNum': '1',
        'pageSize': '15'
            }
        res = Common().get1(self.api_get_tenant_license_list_url,params=params,headers=om_headers())
        application_id = res.json().get('rows')[0].get('applicationId')
        application_ids = []
        for row in res.json().get('rows'):
            a_id = row['applicationId']
            application_ids.append(a_id)
        print(application_ids)
        assert application_id in application_ids
        return application_ids

    # 初始化子系统实现
    def api_create_initsysterm(self, tenantId, liencensList):
        # 获取需要初始化的子系统id
        syslists = []
        for i in liencensList:
            s_id = i
            if s_id != '1':
                syslists.append(s_id)
            else:
                continue
        json = {
            "tenantId": tenantId,
            "sysIdList": syslists
        }
        res = Common().post1(self.api_create_initsysterm_url, json=json, headers=om_headers())
        return res.json()
        time.sleep(30)
    #获取初始化进度实现
    def api_get_initprogress(self,tenantId):
        params = {
            'tenantId': tenantId
        }
        res = Common().get1(self.api_get_initprogress_url, params=params,headers=om_headers())
        success_list = res.json().get('data').get('successList')
        success_sys_ids = []
        for success in success_list:
            s_id = success['sysId']
            success_sys_ids.append(s_id)
        return success_sys_ids