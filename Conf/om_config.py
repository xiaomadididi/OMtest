

# 环境信息
def om_server_ip():
    om_test_url = 'http://platformtest.eclincloud.net/'
    om_uptest_url = 'http://platformtest.eclincloud.net/'
    return om_test_url


def rm_server_ip():
    pass


def om_token():
    Authorization = 'eyJhbGciOiJIUzUxMiJ9.eyJ1c2VyX2lkIjoxLCJ1c2VyX2tleSI6IjA2MDNmM2Q2LTIzMGQtNGM3ZC1hOTI4LTJjZTE0OThjMDY5MyIsInVzZXJuYW1lIjoiYWRtaW4ifQ.5kVrGf7JkJrPf6kWWXdo_i8rCWPRtDPTJXmQuwB4e6-oVOzBvMz7aL07tJ8uhOoUgfnY7frccP4yKlTDh0dCxg'
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