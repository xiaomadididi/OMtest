import pytest

from Common.yamlutil import *
from Service.datahub.login import *
from Service.datahub.portal import *


class TestAdminLogin:

    # 超管绑定双因素
    def test_get_check_type(self):
        account = YamlUtil().read_yaml('admin_accout')
        password = '0192023A7BBD73250516F069DF18B500'
        Login().get_check_type(account, password)
        Login().bind_authenticator(account, password)
        # 超管登录获取token
        get_token()

    # 超管获取角色id
    def test_get_rid(self):
        account_id = YamlUtil().read_yaml('account_id')
        tenant_id = YamlUtil().read_yaml('tenant_id')
        Portal().get_rid(account_id, tenant_id)

    #
    #
    # def test_get_check_type(self):
    #     res = LoginAPI().api_get_chek_type(self.account, self.password)
    #     return res
    #
    # def test_bind_authenticator(self):
    #     res=LoginAPI().api_bind_authenticator(self.account,self.password)
    #     print(self.account)
    #     print(res)
    #     return res

    # def test_login(self):
    #     res = LoginAPI().api_verificationcode_login(self.account, self.password)
    #     print(res)
    #     return res
    # #
    # def test_get_rid(self):
    #     account_id = self.test_login()['account_id']
    #     tenant_id = self.test_login()['tenant_id']
    #     sysId='1'
    #     res = LoginAPI().api_is_pass_exam(account_id, tenant_id,sysId)
    #     print(res)
    #     return res


if __name__ == '__main__':
    pytest.main(['v', 'Test_case/Dh_test_case/test_admin_login.py'])
