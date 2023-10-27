import os.path

import pytest
import requests

from Common import common


class Testscript:

    # 上传sql文件 获取文件地址

    def test_upload_sql(self):
        comm = common.Common()
        uri = 'plt-api/system/file/uploadSql'
        file = {
            'file': open("../../files/datahub_v3.5.7.000_release_om.sql", 'rb')
        }
        res = comm.post_file(uri, file)
        file_name = os.path.basename(file['file'].name)
        parts = file_name.split('_')
        file_version = parts[0] + '_' + parts[1]
        sql_path = res.json().get('data')
        msg = res.json().get('msg')
        assert msg == '操作成功'
        return {'sql_path': sql_path, 'file_name': file_name, 'file_version': file_version}

    # 创建版本初始化脚本
    def test_save_script(self):
        comm = common.Common()
        self.test_upload_sql()
        uri = 'plt-api/system/initScript/save'
        data = {
            'sysId': '1',
            'subsystemVersion': self.test_upload_sql()['file_version'],
            'sqlPath': self.test_upload_sql()['sql_path'],
            'fileName': self.test_upload_sql()['file_name']
        }
        res = comm.post(uri, data)

        msg = res.json().get('msg')
        assert msg == '操作成功'
