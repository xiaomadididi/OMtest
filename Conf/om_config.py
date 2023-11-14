

# 环境信息
def om_server_ip():
    om_test_url = 'http://platformtest.eclincloud.net/'
    om_uptest_url = 'http://platformtest.eclincloud.net/'
    return om_test_url


def rm_server_ip():
    pass


def om_token():
    Authorization = 'eyJhbGciOiJIUzUxMiJ9.eyJ1c2VyX2lkIjoxLCJ1c2VyX2tleSI6IjUzMzdhMmIzLWQwOTgtNGQyOC1hMmQ3LTUxMTYxNGQyYjVjMCIsInVzZXJuYW1lIjoiYWRtaW4ifQ.RvAC8FGhQ_jiu1TdJ9xDLPtiLoarQGmmDYWKV62ygOOGmKxt4S-ojWC9Z5NVjc7fpJ4bJK2HaGMHEYwLdnUxmQ'
    return Authorization


def om_headers():
    om_header = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36',
        'Authorization': om_token(),
    }
    return om_header

# def dh_headers():
#     dh_headers = {
#         'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36',
#         'Authorization': 'Bearer ' + get_token()['access_token'],
#         'aid': get_token()['account_id'],
#         'appId': '1',
#         'tid': get_token()['tenant_id']
#     }
#     return dh_headers




if __name__ == '__main__':

   print(om_server_ip())