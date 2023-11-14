from time import sleep

from Api.dh_api.inviteregister_api import *
from Common.utils import *
class User:

    def invite_user(self,permissionList,invitemail,permissionList_newStr):

        res=InviteAPI().api_invite_register_mail(permissionList,invitemail,permissionList_newStr)
        print(invitemail)
        return res
    def send_mail_code(self,invitemail,tenantId):
        res=InviteAPI().api_send_mail_code(invitemail,tenantId)
        sleep(20)
        return res
    def check_mail_status(self,tenantId,invitemail,inviteCode):
        res=InviteAPI().api_check_mail_status(tenantId,invitemail,inviteCode)
        return  res
