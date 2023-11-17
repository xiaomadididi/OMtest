import datetime
import os

import pytest

def run(project):
	# 启动pytest
	# 测试结果存放到alluredir指定目录
	# --clean-alluredir表示清理历史结果
    pytest.main([
        "Test_case/Dh_test_case/{}".format(project),
        "--alluredir=allure_result",
        "--clean-alluredir",
        "-vs"
    ])


if __name__ == '__main__':
    today = datetime.datetime.now().strftime("%Y-%m-%d")
    # 运行project1项目的自动化测试
    run("test_user_login.py")
    # 生成project1的allure测试报告到report/yyyy-mm-dd/project1目录下
    os.system("allure generate -c allure_result -o report/{0}/{1}".format(today, "test_user_login"))
