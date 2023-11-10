import os.path

import pytest
import requests

from Common import base_request
from Common.base_request import *
from Api.om_api.script_api import *
from Common.utils import get_random_num
from Conf.config import *

class Testscript:

    # 上传主数据升级脚本
    def test_upload_sql(self):
        file = open("../../files/datahub_v3.5.7.002_release_om.sql", 'rb')
        res = ScriptAPI().api_upload_sql(file)
        msg = res['res_json'].get('msg')
        assert msg == '操作成功'
        return res

    # 创建主数据版本初始化脚本
    def test_save_script(self):
        sysId = '1'
        subsystemVersion = self.test_upload_sql()['file_version']+get_random_num()
        sqlPath = self.test_upload_sql()['sql_path']
        fileName = self.test_upload_sql()['file_name']
        res = ScriptAPI().api_save_script(sysId, subsystemVersion, sqlPath, fileName)
        msg = res.get('msg')
        assert msg == '操作成功'

if __name__ == '__main__':
   pytest.main()