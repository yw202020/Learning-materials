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

//	��ʽһ
	public static void ServerReceviedByTcp() {
        // ����һ��ServerSocket����
        ServerSocket serverSocket = null;
        try {
            // ����һ��ServerSocket���󣬲������Socket��1989�˿ڼ���
            serverSocket = new ServerSocket(1989);
            // ����ServerSocket��accept()���������ܿͻ��������͵�����
            // ����ͻ���û�з������ݣ���ô���߳̾�ͣ�Ͳ�����
            Socket socket = serverSocket.accept();
            // ��Socket���еõ�InputStream����
            InputStream inputStream = socket.getInputStream();
            byte buffer[] = new byte[1024 * 4];
            int temp = 0;
            // ��InputStream���ж�ȡ�ͻ��������͵�����
            while ((temp = inputStream.read(buffer)) != -1) {
                System.out.println(new String(buffer, 0, temp));
            }
            serverSocket.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    	
    }


//	��ʽ��
	public static void ServerReceviedByUdp(){
        //����һ��DatagramSocket���󣬲�ָ�������˿ڡ���UDPʹ��DatagramSocket��  
        DatagramSocket socket;
        try {
            socket = new DatagramSocket(10025);
            //����һ��byte���͵����飬���ڴ�Ž��յ�������  
            byte data[] = new byte[4*1024];  
            //����һ��DatagramPacket���󣬲�ָ��DatagramPacket����Ĵ�С  
            DatagramPacket packet = new DatagramPacket(data,data.length);  
            //��ȡ���յ�������  
            while(true){
            socket.receive(packet);  
            //�ѿͻ��˷��͵�����ת��Ϊ�ַ�����  
            //ʹ������������String����������һ�����ݰ� ����������ʼλ�� �����������ݰ���  
            String result = new String(packet.getData(),packet.getOffset() ,packet.getLength());  
            System.out.println("result:"+result);
            

            byte data2[] = new byte[4*1024];  
            //����һ��DatagramPacket���󣬲�ָ��DatagramPacket����Ĵ�С  
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
		    thread.sleep(1500);//��ͣ1.5���������ִ��
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
