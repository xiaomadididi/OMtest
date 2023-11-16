import os
import yaml
class YamlUtil:
    #获取当前文件的目录
    cur_path=os.path.abspath(os.path.dirname(__file__))

    #获取根目录
    root_path=cur_path[:cur_path.find('OMtest\\')+len('OMtest\\')]


    # 读取
    def read_yaml(self, key):
        with open(YamlUtil.root_path + "/extract.yaml", encoding="utf-8") as f:
            value = yaml.load(stream=f, Loader=yaml.FullLoader)
            return value[key]

    # 写入
    def write_yaml(self, data):
        for key in data:
            print(key)
        # print(data[key])
        with open(YamlUtil.root_path + "/extract.yaml", encoding='utf-8') as f:
            dict_temp = yaml.load(f, Loader=yaml.FullLoader)
            try:
                dict_temp[key] = data[key]
            except:
                if not dict_temp:
                    dict_temp = {}
                dict_temp.update({key: data[key]})

        with open(YamlUtil.root_path + "/extract.yaml",encoding="utf-8", mode="w") as f:
            yaml.dump(dict_temp, stream=f, allow_unicode=True)

    # 清空
    def clean_yaml(self):
        with open(YamlUtil.root_path + "/extract.yaml", encoding="utf-8", mode="w") as f:
            f.truncate()


if __name__ == '__main__':
    a = {'rs_id': '3'}
    YamlUtil().write_yaml(a)
