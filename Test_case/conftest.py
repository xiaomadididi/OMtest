import pytest
from Common.yamlutil import *

#整体执行前清空yaml文件
@pytest.fixture(scope='session', autouse=True)
def clear_yaml():
    YamlUtil().clean_yaml()
