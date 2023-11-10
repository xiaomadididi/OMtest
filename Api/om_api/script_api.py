import os

from Conf.config import *
from Common.base_request import *


class ScriptAPI:
    # 上传脚本文件接口
    api_upload_sql_url = om_server_ip() + 'plt-api/system/file/uploadSql'
    # 保存升级脚本版本接口
    api_save_script_url = om_server_ip() + 'plt-api/system/initScript/save'

    # 上传文件实现--》获取文件地址
    def api_upload_sql(self, file):
        files = {
            'file': file
        }
        file_name = os.path.basename(file.name)
        parts = file_name.split('_')
        file_version = parts[0] + '_' + parts[1]
        res = Common().post1(self.api_upload_sql_url, files=files, headers=om_headers())
        sql_path = res.json().get('data')
        res_json=res.json()
        return {'sql_path': sql_path, 'file_name': file_name, 'file_version': file_version,'res_json':res_json}

    # 保存升级脚本实现--》

    def api_save_script(self, sysId, subsystemVersion, sqlPath, fileName):
        json = {
            'sysId': sysId,
            'subsystemVersion': subsystemVersion,
            'sqlPath': sqlPath,
            'fileName': fileName
        }
        res = Common().post1(self.api_save_script_url, json=json, headers=om_headers())
        return res.json()
