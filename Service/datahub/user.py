from time import sleep
from Common.yamlutil import *
from Api.dh_api.inviteregister_api import *
from Common.utils import *



class User:

    def invite_user(self, permissionList, invitemail, permissionList_newStr):
        res = InviteAPI().api_invite_register_mail(permissionList, invitemail, permissionList_newStr)
        print(invitemail)
        msg = res.get('message')
        assert msg == '操作成功'
        print(res)
        return res

    def user_list(self):
        res = InviteAPI().api_user_list()
        YamlUtil().write_yaml({'u_id': res})
        msg = res.get('message')
        assert msg == '操作成功'

    def send_mail_code(self, invitemail, tenantId):
        res = InviteAPI().api_send_mail_code(invitemail, tenantId)
        sleep(20)
        msg = res.get('message')
        assert msg == '操作成功'
        return res

    def b58decode(self,tmp: str) -> str:
        """
        Base58 加密
        :param tmp:
        :return:
        """
        import binascii
        base58 = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz"
        temp = []
        for i in tmp:
            temp.append(base58.index(i))
        tmp = temp[0]
        for i in range(len(temp) - 1):
            tmp = tmp * 58 + temp[i + 1]
        return binascii.unhexlify(hex(tmp)[2:].encode("utf-8")).decode("UTF-8")

    def get_mial_info(self,email):
        sleep(20)  # 等待下邮件发送
        intercept_email_url = f'https://www.snapmail.cc/emailList/{email}?isPrefix=True'
        intercept_email_re = requests.get(url=intercept_email_url).json()
        html = intercept_email_re[0]['html']  # 拦截的数据截取HTML格式的文本
        print(html)
        ele = etree.HTML(html)
        bs58 = ele.xpath('//body//a/@href')[0].split('/')[7][1:]  # 定位到html中注册链接，截取拦截中的bs58码（去掉首位E）
        print(bs58)
        decode = self.b58decode(bs58).split('&')  # 解码，得到的数据以&分割字符串，得到xx=xxx 的信息列表

        invCode = decode[0].split('=')[1]  # 以“=”截取得到key，vlue，取vlue值
        sendUserId = decode[1].split('=')[1]
        customerId = decode[2].split('=')[1]
        email_ = decode[3].split('=')[1]
        language = decode[4].split('=')[1]
        hash = decode[5].split('=')[1]
        return {'invCode':invCode,'sendUserId':sendUserId,'customerId':customerId,'hash':hash}
    def get_mail_code(self, email):
        # 截取邮箱验证码
        sleep(10)
        intercept_email_url = f'https://www.snapmail.cc/emailList/{email}?isPrefix=True'
        intercept_email_re = requests.get(url=intercept_email_url).json()
        code_html = intercept_email_re[0]['html']  # 拦截的数据截取HTML格式的文本
        print(code_html)
        ele = etree.HTML(code_html)
        print(ele)
        code = ele.xpath('//body//div[@class="email-content"]/p[3]/text()')[0].split('，')[0][-6:]
        return code

    def check_mail_status(self, tenantId, invitemail, Code):
        res = InviteAPI().api_check_mail_status(tenantId, invitemail, Code)
        msg = res.get('message')
        assert msg == '操作成功'
        return res

    def invite_register(self,sendUserId, invitemail,invCode,customerId,hash,account):
        res = InviteAPI().api_invite_register(sendUserId,invitemail,invCode,customerId,hash,account)
        print(res)
        print('注册接口执行结果--------------------------------------------------')
        sleep(20)
        msg = res.get('message')
        assert msg == '操作成功'
if __name__ == '__main__':
    data=User().get_mail_code('OzSbWqb@snapmail.cc')
    print(data)