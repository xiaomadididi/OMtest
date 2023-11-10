from Api.dh_api.login_api import LoginAPI
from Common.base_request import *
from Common.utils import *
import requests
from Test_case.Om_test_case.test_tenant import *
from  Api.dh_api.login_api import *

class TestLogin:
    account= TestTenant().test_get_tenant_id()['admin_accout']
    password= '0192023A7BBD73250516F069DF18B500'

    def test_get_check_type(self):
        res = LoginAPI().api_get_chek_type(self.account, self.password)
        return res

    def test_bind_authenticator(self):
        res=LoginAPI().api_bind_authenticator(self.account,self.password)
        print(res)
        return res

    def test_login(self):
        res = LoginAPI().api_verificationcode_login(self.account, self.password)
        print(res)
        return res

    def test_get_rid(self):
        account_id = self.test_login()['account_id']
        tenant_id = self.test_login()['tenant_id']
        sysId='1'
        res = LoginAPI().api_is_pass_exam(account_id, tenant_id,sysId)
        print(res)
        return res
