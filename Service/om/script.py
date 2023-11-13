import pytest

from Api.om_api.script_api import *
from Common.utils import get_random_num


class Script:
    # 上传升级脚本
    def upload_sql(self,filePath):
        file = open(filePath, 'rb')
        res = ScriptAPI().api_upload_sql(file)
        msg = res['res_json'].get('msg')
        assert msg == '操作成功'
        return res


    # 创建初始化脚本
    def save_script(self,sysId,filePath):
        sysId = sysId
        subsystemVersion = self.upload_sql(filePath)['file_version']+'_'+get_random_num()
        sqlPath = self.upload_sql(filePath)['sql_path']
        fileName = self.upload_sql(filePath)['file_name']
        res = ScriptAPI().api_save_script(sysId, subsystemVersion, sqlPath, fileName)
        msg = res.get('msg')
        assert msg == '操作成功'