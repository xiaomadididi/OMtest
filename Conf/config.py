from Common.base_request import Common
from Test_case.Dh_test_case.test_login import TestLogin
from Common.base_request import *

# 环境信息
def om_server_ip():
    om_test_url = 'http://platformtest.eclincloud.net/'
    om_utest_url = 'http://platformtest.eclincloud.net/'
    return om_test_url


def dh_sever_ip():
    dh_test_url = 'http://clinical-test.eclincloud.net/'
    return dh_test_url


def rm_server_ip():
    pass


def om_token():
    Authorization = 'eyJhbGciOiJIUzUxMiJ9.eyJ1c2VyX2lkIjoxLCJ1c2VyX2tleSI6IjM1MTRkZTEzLWUwZTYtNDA1NS1hYjU1LTRmMDZjYjczMzc1MCIsInVzZXJuYW1lIjoiYWRtaW4ifQ.BXF3Kefex6BjU_Z7a2K0Yi5FW957yPilQ4FXU10KOdmLMgNsHKQHXxkb4HRwPDNx_DlA7mlTnZs2zoUY9SZOMA'
    return Authorization


def om_headers():
    om_header = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36',
        'Authorization': om_token(),
    }
    return om_header

def dh_headers():
    dh_headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36',
        'Authorization': 'Bearer ' + Common().get_dh_token()['access_token'],
        'aid': Common().get_dh_token()['account_id'],
        'appId': 1,
        'tid': Common().get_dh_token()['tenant_id']
    }
    return dh_headers


def login_headers():
    login_headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36'
    }
    return login_headers

if __name__ == '__main__':
   dh_headers()
   print(dh_headers())