# -*- coding: utf-8 -*-
from socket import *
from time import ctime
from time import localtime
import time
import hashlib
import mymd5

HOST = ''
PORT = 1122  # 设置侦听端口
BUFSIZ = 1024
ADDR = (HOST, PORT)
sock = socket(AF_INET, SOCK_STREAM)

sock.bind(ADDR)

sock.listen(5)
# 设置退出条件
STOP_CHAT = False
while not STOP_CHAT:
    print('等待接入，侦听端口:%d' % (PORT))
    tcpClientSock, addr = sock.accept()
    print('接受连接，客户端地址：', addr)
    while True:
        try:
            data_name = tcpClientSock.recv(BUFSIZ)
        except:
            # print(e)
            tcpClientSock.close()
            break
        if not data_name:
            break
        # python3使用bytes，所以要进行编码
        # s='%s发送给我的信息是:[%s] %s' %(addr[0],ctime(), data.decode('utf8'))
        # 对日期进行一下格式化
        ISOTIMEFORMAT = '%Y-%m-%d %X'
        stime = time.strftime(ISOTIMEFORMAT, localtime())
        result_name = "error"
        print([stime], '收到加密后用户名：', data_name.decode('utf8'))
        if data_name.decode('UTF-8') == mymd5.mymd5("storm"):
            result_name = "sucess"
        s = ':%s' % (result_name)
        tcpClientSock.send(s.encode('utf8'))
        # 如果输入quit(忽略大小写),则程序退出
        STOP_CHAT = (data_name.decode('utf8').upper() == "QUIT")
        if STOP_CHAT:
            break

        try:
            data_password = tcpClientSock.recv(BUFSIZ)
        except:
            tcpClientSock.close()
            break
        ISOTIMEFORMAT = '%Y-%m-%d %X'
        stime = time.strftime(ISOTIMEFORMAT, localtime())
        result_password = "error"
        if data_password.decode('UTF-8') == mymd5.mymd5("123456"):
            result_password = "sucess"
        s = ':%s' % (result_password)
        tcpClientSock.send(s.encode('utf8'))
        print([stime], '收到加密后密码：', data_password.decode('utf8'))
        print("==========================")
        # 如果输入quit(忽略大小写),则程序退出
        STOP_CHAT = (data_password.decode('utf8').upper() == "QUIT")
        if STOP_CHAT:
            break

tcpClientSock.close()
sock.close()
