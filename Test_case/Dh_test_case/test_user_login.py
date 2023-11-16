import pytest

from Common.yamlutil import *
from Service.datahub.login import *
from  Service.datahub.portal import *

class TestUserLogin:

    '''
    普通用户登录》
    @:param 注册成功的账号

    '''
    # 普通用户绑定双因素
    def test_get_check_type(self):
        account = YamlUtil().read_yaml('account_email')
        password = '2BC1514D90296DDDA5016E52BAA2A6CE'
        Login().get_check_type(account,password)
        Login().bind_authenticator(account,password)
        #用户登录
        user_login()
    #普通获取角色id
    def test_get_rid(self):
        account_id=YamlUtil().read_yaml('account_id')
        tenant_id=YamlUtil().read_yaml('tenant_id')
        Portal().get_rid(account_id,tenant_id)
if __name__ == '__main__':
    pytest.main(['v', 'Test_case/Dh_test_case/test_user_login.py'])