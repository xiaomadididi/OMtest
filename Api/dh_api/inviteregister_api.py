from xml import etree

from Common.base_request import *
from Conf.dh_config import *
from lxml import etree



class InviteAPI:
    # 获取生成邮件注册链接接口
    api_invite_register_mail_url=dh_sever_ip()+'mds-api/plt/register/batchInviteRegister'
    #邮箱注册 发送验证码接口
    api_send_mail_code_url=dh_sever_ip()+'mds-api/plt/user/register/sendMailCode'
    #确认邮箱状态接口
    api_check_mail_status_url=dh_sever_ip()+'mds-api/plt/register/checkStatusInPlatformOfEmail'
    #注册账号接口
    api_invite_register_url=dh_sever_ip()+'mds-api/plt/user/inviteRegister'



    #生成邮件邀请实现
    def api_invite_register_mail(self,permissionList,invitemail,permissionList_newStr):
        json={
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
        headers=dh_headers()
        new_headers=headers.update({'r_id':YamlUtil().read_yaml('r_id')})
        res=Common().post1(self.api_invite_register_mail_url,json=json,headers=headers)
        msg=res.json().get('message')
        print(res.json())
        assert msg== '操作成功'

    def api_send_mail_code(self, invitemail, tenantId):
        params = {
            'email': invitemail,
            'tenantId': tenantId
        }
        res = Common().get1(self.api_send_mail_code_url, params=params, headers=login_headers())
        msg = res.json().get('message')
        assert msg == '操作成功'

    def get_mail_code(self,email):
        # 截取邮箱验证码
        intercept_email_url = f'https://www.snapmail.cc/emailList/{email}?isPrefix=True'
        intercept_email_re = requests.get(url=intercept_email_url).json()
        code_html = intercept_email_re[0]['html']  # 拦截的数据截取HTML格式的文本
        ele = etree.HTML(code_html)
        code = ele.xpath('//body//div[@class="email-content"]/p[3]/text()')[0].split('，')[0][-6:]
        return code
    def api_check_mail_status(self,tenantId,invitemail,inviteCode):
        json={

                "tenantId": tenantId,
                "email": invitemail,
                "inviteCode": inviteCode

        }
        res=Common().post1(self.api_check_mail_status_url,json=json,headers=login_headers())
        msg = res.json().get('message')
        assert msg == '操作成功'



if __name__ == '__main__':
    a = dh_headers()
    headers = a.update({'r_id':'-1'})



