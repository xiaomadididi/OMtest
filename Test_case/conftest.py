from Common.yamlutil import *
from Common.logutils import *

# 整体执行前清空yaml文件
# @pytest.fixture(scope='session', autouse=True)
# def clear_yaml():
#     YamlUtil().clean_yaml()
def pytest_sessionfinish(session):
    """测试完成自动生成并打开allure报告"""
    if session.config.getoption('allure_report_dir'):
        try:
            # 判断allure在环境路径中，通常意味着可以直接执行
            if [i for i in os.getenv('path').split(';') if os.path.exists(i) and 'allure' in os.listdir(i)]:
                # 默认生成报告路径为: ./allure-report
                os.system(f"allure generate -c {session.config.getoption('allure_report_dir')}")
                os.system(f"allure open allure-report")
            else:
                ApiAutoLog().warn('allure不在环境变量中，无法直接生成html报告！')
        except Exception as e:
            ApiAutoLog().warn(e)


def pytest_collection_modifyitems(config, items):
    # 期望用例顺序按照.py文件执行
    appoint_classes = {'TestCreateScript': [], "TestAdminLogin": [], "TestInviteUser": [], "TestUserLogin": [],
                       'TestBaseInfo': []}
    for item in items:
        for cls_name in appoint_classes:
            if item.parent.name == cls_name:
                appoint_classes[cls_name].append(item)
    items.clear()
    for cases in appoint_classes.values():
        items.extend(cases)
