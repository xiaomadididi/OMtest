import pytest

from Service.datahub.baseinfo import *


class TestBaseInfo:
    '''

    验证基本信息模块
    '''
    def test_check_base_info(self):
        BaseInfo().check_base_info()


if __name__ == '__main__':
    pytest.main(['v', 'Test_case/Dh_test_case/test_check_baseinfo.py'])