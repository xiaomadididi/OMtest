from Common.get_token import *
from Api.dh_api.login_api import *
from Common.yamlutil import *


class Portal:

    def get_rid(self, account_id, tenant_id):
        account_id = account_id
        tenant_id = tenant_id
        sysId = '1'
        res = LoginAPI().api_is_pass_exam(account_id, tenant_id, sysId)
        YamlUtil().write_yaml(res)
        return res
