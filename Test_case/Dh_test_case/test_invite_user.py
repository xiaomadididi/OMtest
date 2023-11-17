from time import sleep

from Service.datahub.user import *


class TestInviteUser:
    '''
    邀请注册流程：
    admin发送邀请邮件》邮箱跳转验证地址》获取邮箱验证码》填写注册信息
    @:param
    '''

    def test_invite_register(self):
        invitemail = get_random_mail()
        permissionList = [{
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
        # 发送邀请邮件
        User().invite_user(permissionList, invitemail, permissionList_newStr)
        # 拦截邮件
        mial_info = User().get_mial_info(invitemail)
        sendUserId = mial_info['sendUserId']
        invCode = mial_info['invCode']
        customerId = mial_info['customerId']
        hash = mial_info['hash']
        # 发送确认邮箱验证码
        User().send_mail_code(invitemail, YamlUtil().read_yaml('tenant_id'))
        Code = User().get_mail_code(invitemail)
        account = 'test' + get_random_num()
        # 确认邮箱状态
        User().check_mail_status(YamlUtil().read_yaml('tenant_id'), invitemail, Code)
        # 注册
        User().invite_register(sendUserId, invitemail, invCode, customerId, hash, account)
        # 验证注册成功
        sleep(10)
        User().check_user_list()

if __name__ == '__main__':
    pytest.main(['v','Test_case/Dh_test_case/test_invite_user.py',])
