from Api.dh_api.login_api import *


class TestPortal:

    def test_get_rid(self):
        account_id = self.test_login()['account_id']
        tenant_id = self.test_login()['tenant_id']
        sysId='1'
        res = LoginAPI().api_is_pass_exam(account_id, tenant_id,sysId)
        print(res)
        return res
