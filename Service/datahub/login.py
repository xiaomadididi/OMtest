from Common.yamlutil import *
from Api.dh_api.login_api import *
class Login:
    # account= YamlUtil().read_yaml('admin_accout')
    # password= '0192023A7BBD73250516F069DF18B500'

    def get_check_type(self,account,password):
        res = LoginAPI().api_get_chek_type(account, password)
        return res

    def bind_authenticator(self,account,password):
        res=LoginAPI().api_bind_authenticator(account,password)
        # print(self.account)
        # print(res)
        return res