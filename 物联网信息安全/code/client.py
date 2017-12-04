# -*- coding: utf-8 -*-
from socket import *
import hashlib
import mymd5


class TcpClient:
    # 测试，连接本机
    HOST = '127.0.0.1'
    # 设置侦听端口
    PORT = 1122
    BUFSIZ = 1024
    ADDR = (HOST, PORT)

    def __init__(self):
        self.client = socket(AF_INET, SOCK_STREAM)
        self.client.connect(self.ADDR)

        while True:
            data_name = input('用户名>')
            data_password = input('密码>')

            ss = hashlib.md5()
            ss.update(data_name.encode("utf-8"))
            # ss_name = ss.hexdigest()
            ss_name = mymd5.mymd5(data_name)  # 调用mymd5加密
            ss.update(data_password.encode("utf-8"))
            # ss_password = ss.hexdigest()
            ss_password = mymd5.mymd5(data_password)  # 调用mymd5加密

            if not data_name:
                break
            # python3传递的是bytes，所以要编码
            self.client.send(ss_name.encode('utf8'))
            # print('发送用户名到%s：%s' %(self.HOST,data_name))
            if data_name.upper() == "QUIT":
                break
            data_recv = self.client.recv(self.BUFSIZ)
            if not data_recv:
                break
            print('从%s收到用户名判断：%s' % (self.HOST, data_recv.decode('utf8')))

            self.client.send(ss_password.encode('utf8'))
            # print('发送密码到%s：%s' %(self.HOST,data_password))
            data_recv_pass = self.client.recv(self.BUFSIZ)
            print('从%s收到密码判断：%s' % (self.HOST, data_recv_pass.decode('utf8')))


if __name__ == '__main__':
    client = TcpClient()
