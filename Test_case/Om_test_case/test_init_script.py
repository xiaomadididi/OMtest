import pytest
from Service.om.script import *
from Service.om.tentant import *

class TestCreateScript:

    '''
    初始化升级流程流程：
    step1：选择子系统》上传sql文件》上传
    step2：创建租户》新增子系统授权》初始化子系统
    '''
    #创建升级脚本
    def test_dh_script(self):
        # 上传脚本
        Script().upload_sql(filePath='../../files/datahub_v3.5.7.002_release_om.sql')
        #创建升级脚本版本
        Script().save_script(sysId='1')

    #创建租户并初始化
    '''
    子系统id:
    DH:1
    RM:8
    ET:7
    CT:102
    
    '''
    def test_dh_tentant(self):
        #创建租户
        Tenant().create_tenant()
        #获取租户id
        Tenant().get_tenant_id()
        #创建租户子应用授权DH
        Tenant().create_license(applicationId=['1','8'])
        #获取子系统列表，验证添加子系统成功
        Tenant().get_liencens_list()
        #创建初始化子应用
        Tenant().init_subsystem()
        #初始化应用成功
        Tenant().init_progress()





if __name__ == '__main__':
    pytest.main(['v','Test_case/Om_test_case/test_init_script.py'])
