import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.SocketException;
import java.net.UnknownHostException;

public class server01 {

//	方式一
	public static void ServerReceviedByTcp() {
        // 声明一个ServerSocket对象
        ServerSocket serverSocket = null;
        try {
            // 创建一个ServerSocket对象，并让这个Socket在1989端口监听
            serverSocket = new ServerSocket(1989);
            // 调用ServerSocket的accept()方法，接受客户端所发送的请求，
            // 如果客户端没有发送数据，那么该线程就停滞不继续
            Socket socket = serverSocket.accept();
            // 从Socket当中得到InputStream对象
            InputStream inputStream = socket.getInputStream();
            byte buffer[] = new byte[1024 * 4];
            int temp = 0;
            // 从InputStream当中读取客户端所发送的数据
            while ((temp = inputStream.read(buffer)) != -1) {
                System.out.println(new String(buffer, 0, temp));
            }
            serverSocket.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    	
    }


//	方式二
	public static void ServerReceviedByUdp(){
        //创建一个DatagramSocket对象，并指定监听端口。（UDP使用DatagramSocket）  
        DatagramSocket socket;
        try {
            socket = new DatagramSocket(10025);
            //创建一个byte类型的数组，用于存放接收到得数据  
            byte data[] = new byte[4*1024];  
            //创建一个DatagramPacket对象，并指定DatagramPacket对象的大小  
            DatagramPacket packet = new DatagramPacket(data,data.length);  
            //读取接收到得数据  
            while(true){
            socket.receive(packet);  
            //把客户端发送的数据转换为字符串。  
            //使用三个参数的String方法。参数一：数据包 参数二：起始位置 参数三：数据包长  
            String result = new String(packet.getData(),packet.getOffset() ,packet.getLength());  
            System.out.println("result:"+result);
            

            byte data2[] = new byte[4*1024];  
            //创建一个DatagramPacket对象，并指定DatagramPacket对象的大小  
            DatagramPacket packet2 = new DatagramPacket(data2,data2.length);  
            socket.send(packet);
            }
        } catch (SocketException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }  
    }

	private void sleep(){
		try{
		    Thread thread = Thread.currentThread();
		    thread.sleep(1500);//暂停1.5秒后程序继续执行
		}catch (InterruptedException e) {
		    // TODO Auto-generated catch block
		    e.printStackTrace();
		}
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		System.out.println("server start ...");
//		while(true){
//		ServerReceviedByTcp();
		ServerReceviedByUdp();
//		}
	}

}
