from time import sleep
from xml import etree

from Common.base_request import *
from Conf.dh_config import *
from lxml import etree


class InviteAPI:
    # 获取生成邮件注册链接接口
    api_invite_register_mail_url = dh_sever_ip() + 'mds-api/plt/register/batchInviteRegister'
    # 邮箱注册 发送验证码接口
    api_send_mail_code_url = dh_sever_ip() + 'mds-api/plt/user/register/sendMailCode'
    # 确认邮箱状态接口
    api_check_mail_status_url = dh_sever_ip() + 'mds-api/plt/register/checkStatusInPlatformOfEmail'
    # 注册账号接口
    api_invite_register_url = dh_sever_ip() + 'mds-api/plt/user/inviteRegister'
    # 查询人员列表接口
    api_user_list_url = dh_sever_ip() + 'mds-api/mdsdata/api/mdsUser/queryListByPage'

    # 生成邮件邀请实现
    def api_invite_register_mail(self, permissionList, invitemail, permissionList_newStr):
        json = {
            "permissionList":
                permissionList
            ,
            "language": "zh",
            "mailList": [
                invitemail
            ],
            "expireType": 1,
            "expireTime": "",
            "deptId": "",
            "audit": {
                "title": "MDS:audit.module.userManage:USER_INVITE",
                "indexName": invitemail,
                "old": {},
                "field": {
                    "expireType": {
                        "label": "public.validityPeriod",
                        "type": ""
                    },
                    "permissionList": {
                        "label": "mds.user.look.roleAssignment",
                        "type": ""
                    }
                },
                "newStr": {
                    "expireType": "永久",
                    "permissionList": permissionList_newStr
                },
                "oldStr": {}
            }
        }
        headers = dh_headers()
        new_headers = headers.update({'r_id': YamlUtil().read_yaml('r_id')})
        res = Common().post1(self.api_invite_register_mail_url, json=json, headers=headers)
        return res.json()

    def api_send_mail_code(self, invitemail, tenantId):
        params = {
            'email': invitemail,
            'tenantId': tenantId
        }
        res = Common().get1(self.api_send_mail_code_url, params=params, headers=login_headers())
        return res.json()


    def api_check_mail_status(self, tenantId, invitemail, Code):
        json = {

            "tenantId": tenantId,
            "email": invitemail,
            "inviteCode": Code

        }
        res = Common().post1(self.api_check_mail_status_url, json=json, headers=login_headers())
        return res.json()

    def api_user_list(self):
        json = {
            "active": "",
            "keyword": "",
            "type": "",
            "personType": "",
            "pageNum": 1,
            "limit": 15
        }
        headers = dh_headers()
        new_headers = headers.update({'r_id': YamlUtil().read_yaml('r_id')})
        res = Common().post1(self.api_user_list_url, json=json, headers=headers)
        u_id = res.json().get('data').get('records')[0].get('id')
        return u_id
    def api_invite_register(self,sendUserId,invitemail,invCode,customerId,hash,account):
        json={
            "sendUserId": sendUserId,
            "email": invitemail,
            "inviteCode": invCode,
            "customerId":customerId ,
            "language": "zh",
            "hash": hash,
            "account": account,
            "firstName": '测试',
            "lastName": "账号",
            "password": "2BC1514D90296DDDA5016E52BAA2A6CE",
            "checkPass": "ecc#123456",
            "legalChecked": [
                "请阅读"
            ]
        }
        res=Common().post1(self.api_invite_register_url,json=json,headers=login_headers())
        return res.json()


if __name__ == '__main__':
    a = dh_headers()
    headers = a.update({'r_id': '-1'})
