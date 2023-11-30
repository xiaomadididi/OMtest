import allure
import pytest

from Service.datahub.baseinfo import *

@allure.feature('基本信息')
class TestBaseInfo:
    '''

    验证基本信息模块
    '''
    @allure.story('查看租户基本信息')
    def test_check_base_info(self):
        BaseInfo().check_base_info()



if __name__ == '__main__':
    pytest.main(['v', 'Test_case/Dh_test_case/test_check_baseinfo.py'])