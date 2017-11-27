import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.Socket;
import java.net.SocketException;
import java.net.UnknownHostException;

public class client {

	   
//    DatagramSocket socket;
//    socket = new DatagramSocket(1985);
    
//	方式一
	protected static void connectServerWithTCPSocket() {
	        Socket socket;
	        try {// 创建一个Socket对象，并指定服务端的IP及端口号
	            socket = new Socket("127.0.0.1", 1989);
	            // 创建一个InputStream用户读取要发送的文件。
	            InputStream inputStream = new FileInputStream("d://message.txt");
	            // 获取Socket的OutputStream对象用于发送数据。
	            OutputStream outputStream = socket.getOutputStream();
	            // 创建一个byte类型的buffer字节数组，用于存放读取的本地文件
	            byte buffer[] = new byte[4 * 1024];
	            int temp = 0;
	            // 循环读取文件
	            while ((temp = inputStream.read(buffer)) != -1) {
	                // 把数据写入到OuputStream对象中
	                outputStream.write(buffer, 0, temp);
	            }
	            // 发送读取的数据到服务端
	            outputStream.flush();
	       /** 或创建一个报文，使用BufferedWriter写入,看你的需求 **/
	//            String socketData = "[2143213;21343fjks;213]";
	//      BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(
	//                    socket.getOutputStream()));
	//            writer.write(socketData.replace("\n", " ") + "\n");
	//            writer.flush();
	            /************************************************/
	        } catch (UnknownHostException e) {
	            e.printStackTrace();
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	}
	

//	方式二
	protected static void connectServerWithUDPSocket() {

	    DatagramSocket socket;
	    
        try {
            //创建DatagramSocket对象并指定一个端口号，注意，如果客户端需要接收服务器的返回数据,
            //还需要使用这个端口号来receive，所以一定要记住
            socket = new DatagramSocket(1985);
            //使用InetAddress(Inet4Address).getByName把IP地址转换为网络地址  
            InetAddress serverAddress = InetAddress.getByName("127.0.0.1");
            //Inet4Address serverAddress = (Inet4Address) Inet4Address.getByName("192.168.1.32");  
            String str = "[2143213;21343fjks;213]";//设置要发送的报文  
            byte data[] = str.getBytes();//把字符串str字符串转换为字节数组  
            //创建一个DatagramPacket对象，用于发送数据。  
            //参数一：要发送的数据  参数二：数据的长度  参数三：服务端的网络地址  参数四：服务器端端口号 
            DatagramPacket packet = new DatagramPacket(data, data.length ,serverAddress ,10025);  
            socket.send(packet);//把数据发送到服务端。  
//            socket.close();
            
          //实例化的端口号要和发送时的socket一致，否则收不到data
//            socket = new DatagramSocket(1985);
            byte data2[] = new byte[4 * 1024];
            //参数一:要接受的data 参数二：data的长度
            DatagramPacket packet2 = new DatagramPacket(data2, data2.length);
            socket.receive(packet2);
            //把接收到的data转换为String字符串
            String result = new String(packet2.getData(), packet2.getOffset(),
                    packet2.getLength());
//            socket.close();//不使用了记得要关闭
            int flag = 1;
            System.out.println("the number of reveived Socket is  :" + flag
                    + "udpData:" + result);
            
        } catch (SocketException e) {
            e.printStackTrace();
        } catch (UnknownHostException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }  
}
	//android端接收服务器返回的数据：
	public static void ReceiveServerSocketData() {
        DatagramSocket socket;
        try {
            //实例化的端口号要和发送时的socket一致，否则收不到data
            socket = new DatagramSocket(1985);
            byte data[] = new byte[4 * 1024];
            //参数一:要接受的data 参数二：data的长度
            DatagramPacket packet = new DatagramPacket(data, data.length);
            socket.receive(packet);
            //把接收到的data转换为String字符串
            String result = new String(packet.getData(), packet.getOffset(),
                    packet.getLength());
            socket.close();//不使用了记得要关闭
            int flag = 1;
            System.out.println("the number of reveived Socket is  :" + flag
                    + "udpData:" + result);
        } catch (SocketException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


	public static void main(String[] args) {
		// TODO Auto-generated method stub
		System.out.println("client start ...");
//		connectServerWithTCPSocket();
		connectServerWithUDPSocket();

		System.out.println("发送成功 ...");
		
//		ReceiveServerSocketData();
	}
	
}
