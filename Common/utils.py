import random
import datetime
import string


def get_random_name():
    pass
def get_random_num():
    random_number = str(random.randint(100, 999))

    return random_number
def get_random_mail():
    random_letters = ''.join(random.choices(string.ascii_letters, k=7))
    mail=random_letters+'@snapmail.cc'
    return mail


def get_start_time():
    current_time = datetime.datetime.now()

    # 计算前一天时间
    previous_time = current_time - datetime.timedelta(days=1)
    # 格式化输出
    previous_time_formatted = previous_time.strftime("%Y-%m-%d %H:%M:%S")
    return previous_time_formatted

def get_end_time():
    current_time=datetime.datetime.now()
    next_time = current_time + datetime.timedelta(days=1)
    next_time_formatted=next_time.strftime("%Y-%m-%d %H:%M:%S")
    return next_time_formatted

if __name__ == '__main__':
   admin='admin'+get_random_num()
   print(admin)
