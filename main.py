import datetime
import os

# import os

import pytest


# def run(project):
#     # 启动pytest
#
#     pytest.main([
#         "Test_case/Dh_test_case/{}".format(project),
#     ])
#     split = 'allure ' + 'generate ' + './report/result ' + '-o ' + './report/html ' + '--clean'  # 将测试报告转为html格式
#     os.system(split)  # system函数可以将字符串转化成命令在服务器上运行
#

if __name__ == '__main__':
    # today = datetime.datetime.now().strftime("%Y-%m-%d")
    # # 运行project1项目的自动化测试
    # run("test_user_login.py")
    # # 生成project1的allure测试报告到report/yyyy-mm-dd/project1目录下
    # os.system("allure generate -c allure_result -o report/{0}/{1}".format(today, "test_user_login"))
    # pytest.main(['Test_case/Dh_test_case/test_user_login.py'])
    pytest.main( )  # 生成json类型的测试报告
    split = 'allure ' + 'generate ' + './report/result ' + '-o ' + './report/html ' + '--clean'  # 将测试报告转为html格式
    os.system(split)  # system函数可以将字符串转化成命令在服务器上运行
    # run('test_user_login.py','test_check_baseinfo.py')
