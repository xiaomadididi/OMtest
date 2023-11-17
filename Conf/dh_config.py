from Common.get_token import *


def dh_headers():
    dh_headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36',
        'Authorization':'Bearer '+YamlUtil().read_yaml('access_token'),
        'aid': YamlUtil().read_yaml('account_id'),
        'appId': '1',
        'tid': YamlUtil().read_yaml('tenant_id'),
        'Accept':'application/json, text/plain, */*',
        # 'rid': YamlUtil().read_yaml('r_id')
    }
    return dh_headers
def dh_sever_ip():
    dh_test_url = 'http://clinical-test.eclincloud.net/'
    return dh_test_url

def login_headers():
    login_headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36'
    }
    return login_headers



if __name__ == '__main__':

   print(dh_headers())