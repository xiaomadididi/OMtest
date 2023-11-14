from time import sleep

from Service.datahub.user import *

class TestInviteUser:
    '''
    邀请注册流程：
    admin发送邀请邮件》邮箱跳转验证地址》获取邮箱验证码》填写注册信息
    '''

    def test_invite_register(self):
        invitemail=get_random_mail()
        permissionList =[ {
            "sysId": "1",
            "roleId": "1",
            "studyId": "",
            "envId": [],
            "siteIds": [],
            "deptIds": []
        },
        {
            "sysId": "8",
            "roleId": "8",
            "studyId": "",
            "envId": [],
            "siteIds": [],
            "deptIds": []
        }
            ]
        permissionList_newStr = '@D=(1,application_type)&-&@R=(1)&-&$tmds.user.look.all$t-$tmds.user.look.all$t-$tmds.user.look.all$t-$tmds.user.look.all$t$,$&@D=(8,application_type)&-&@R=(8)&-&$tmds.user.look.all$t-$tmds.user.look.all$t-$tmds.user.look.all$t-$tmds.user.look.all$t'
        User().invite_user(permissionList, invitemail, permissionList_newStr)
        User().send_mail_code(invitemail, YamlUtil().read_yaml('tenant_id'))
        inviteCode = InviteAPI().get_mail_code(invitemail)
        User().check_mail_status(YamlUtil().read_yaml('tenant_id'),invitemail,inviteCode)




