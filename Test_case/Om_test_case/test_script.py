import os.path

import pytest
import requests

from Common import base_request
from Common.base_request import *
from Api.om_api.script_api import *

class Testscript:

    # 上传sql文件 获取文件地址
    def test_upload_sql(self):
        file = open("../../files/datahub_v3.5.7.002_release_om.sql", 'rb')
        res = ScriptAPI().api_upload_sql(file)

        file_name = os.path.basename(file.name)
        parts = file_name.split('_')
        file_version = parts[0] + '_' + parts[1]
        sql_path = res.get('data')
        msg = res.get('msg')
        assert msg == '操作成功'
        return {'sql_path': sql_path, 'file_name': file_name, 'file_version': file_version}

    # 创建版本初始化脚本
    def test_save_script(self):
        print(self.test_upload_sql()['file_version'])
        print(self.test_upload_sql()['sql_path'])
        print(self.test_upload_sql()['file_name'])
        sysId = '1'
        subsystemVersion = self.test_upload_sql()['file_version']
        sqlPath = self.test_upload_sql()['sql_path']
        fileName = self.test_upload_sql()['file_name']
        res=ScriptAPI().api_save_script_url(sysId='1',subsystemVersion='datahub_v3.5.7.002',sqlPath='om_init_sql/d028837c56fc46798ea7efe4ab146aa3.sql',fileName='datahub_v3.5.7.002_release_om.sql')

