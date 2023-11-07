# 环境信息
def om_server_ip():
    om_test_url = 'http://platformtest.eclincloud.net/'
    om_utest_url = 'http://platformtest.eclincloud.net/'
    return om_test_url


def dh_sever_ip():
    dh_test_url='http: //clinical-test.eclincloud.net/'
    return dh_test_url


def rm_server_ip():
    pass


def om_token():
    Authorization ='eyJhbGciOiJIUzUxMiJ9.eyJ1c2VyX2lkIjoxLCJ1c2VyX2tleSI6IjZlNjVjMjQ3LTAxMzctNDFjMS1iOTNlLTVkMGU2ZTMzMDBlYyIsInVzZXJuYW1lIjoiYWRtaW4ifQ.Ne1q-QN0cVfRkloGbeNg8_3aRqmRF5knVO5GLjitfyno_ZwQUHnnaMpOAWfQsPK-zePpWOkLqyUxAztMOM4D1A'
    return Authorization

def om_headers():
    om_header={
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36',
        'Authorization': om_token(),
    }
    return om_header