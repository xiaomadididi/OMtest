from Common.base_request import *
from Conf.dh_config import *


class LoginAPI:
    # 获取登录类型接口
    api_get_chek_type_url = dh_sever_ip() + 'mds-api/plt/auth/getCheckType'
    # 绑定双因素验证接口
    api_bind_authenticator_url = dh_sever_ip() + 'mds-api/plt/auth/bindAuthenticator'
    # 双因素验证码登录接口
    api_verificationcode_login_url = dh_sever_ip() + 'mds-api/plt/auth/verificationCode'
    # isPassTheExam 接口
    api_is_pass_exam_url = dh_sever_ip() + 'mds-api/elearning/clientCourse/isPassTheExam'

    # 获取登录类型实现
    def api_get_chek_type(self, account, password):
        json = {
            "account": account,
            "password": password,
            "type": '1'
        }
        res = Common().post1(self.api_get_chek_type_url, json=json, headers=login_headers())
        return res.json()
    #
    # 绑定双因素实现
    def api_bind_authenticator(self, account, password):
        json = {

            "account": account,
            "verificationCode": "612106",
            "password": password

        }
        res = Common().post1(self.api_bind_authenticator_url, json=json, headers=login_headers())
        return res.json()

    # 验证码登录实现 获取 token accountid tenantid
    # def api_verificationcode_login(self, account, password):
    #     json = {
    #
    #         "account": account,
    #         "password": password,
    #         "verificationCode": "612106",
    #         "rememberCheck": 2
    #
    #     }
    #     res = Common().post1(self.api_verificationcode_login_url, json=json, headers=login_headers())
    #     account_id = res.json().get('data').get('userId')
    #     access_token = res.json().get('data').get('accessToken')
    #     tenant_id = res.json().get('data').get('tenantVoList')[0].get('tenantId')
    #     return {'account_id': account_id, 'access_token': access_token, 'tenant_id': tenant_id}

    # api_is_pass_exam 获取账号角色id
    def api_is_pass_exam(self, account_id, tenant_id,sysId):
        params = {
            'aid': account_id,
            'tenantId': tenant_id,
            'sysId': sysId
        }
        res = Common().get1(self.api_is_pass_exam_url, params=params, headers=dh_headers())
        print(res.json())
        r_id=res.json().get('data').get('roleIds')[0]
        print(r_id)
        return {'r_id':r_id}


if __name__ == '__main__':
    a = LoginAPI().api_is_pass_exam('1725403557768859648', '1725403557798219776','1')

    print(a)
