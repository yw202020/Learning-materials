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
    
//	��ʽһ
	protected static void connectServerWithTCPSocket() {
	        Socket socket;
	        try {// ����һ��Socket���󣬲�ָ������˵�IP���˿ں�
	            socket = new Socket("127.0.0.1", 1989);
	            // ����һ��InputStream�û���ȡҪ���͵��ļ���
	            InputStream inputStream = new FileInputStream("d://message.txt");
	            // ��ȡSocket��OutputStream�������ڷ������ݡ�
	            OutputStream outputStream = socket.getOutputStream();
	            // ����һ��byte���͵�buffer�ֽ����飬���ڴ�Ŷ�ȡ�ı����ļ�
	            byte buffer[] = new byte[4 * 1024];
	            int temp = 0;
	            // ѭ����ȡ�ļ�
	            while ((temp = inputStream.read(buffer)) != -1) {
	                // ������д�뵽OuputStream������
	                outputStream.write(buffer, 0, temp);
	            }
	            // ���Ͷ�ȡ�����ݵ������
	            outputStream.flush();
	       /** �򴴽�һ�����ģ�ʹ��BufferedWriterд��,��������� **/
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
	

//	��ʽ��
	protected static void connectServerWithUDPSocket() {

	    DatagramSocket socket;
	    
        try {
            //����DatagramSocket����ָ��һ���˿ںţ�ע�⣬����ͻ�����Ҫ���շ������ķ�������,
            //����Ҫʹ������˿ں���receive������һ��Ҫ��ס
            socket = new DatagramSocket(1985);
            //ʹ��InetAddress(Inet4Address).getByName��IP��ַת��Ϊ�����ַ  
            InetAddress serverAddress = InetAddress.getByName("127.0.0.1");
            //Inet4Address serverAddress = (Inet4Address) Inet4Address.getByName("192.168.1.32");  
            String str = "[2143213;21343fjks;213]";//����Ҫ���͵ı���  
            byte data[] = str.getBytes();//���ַ���str�ַ���ת��Ϊ�ֽ�����  
            //����һ��DatagramPacket�������ڷ������ݡ�  
            //����һ��Ҫ���͵�����  �����������ݵĳ���  ������������˵������ַ  �����ģ��������˶˿ں� 
            DatagramPacket packet = new DatagramPacket(data, data.length ,serverAddress ,10025);  
            socket.send(packet);//�����ݷ��͵�����ˡ�  
//            socket.close();
            
          //ʵ�����Ķ˿ں�Ҫ�ͷ���ʱ��socketһ�£������ղ���data
//            socket = new DatagramSocket(1985);
            byte data2[] = new byte[4 * 1024];
            //����һ:Ҫ���ܵ�data ��������data�ĳ���
            DatagramPacket packet2 = new DatagramPacket(data2, data2.length);
            socket.receive(packet2);
            //�ѽ��յ���dataת��ΪString�ַ���
            String result = new String(packet2.getData(), packet2.getOffset(),
                    packet2.getLength());
//            socket.close();//��ʹ���˼ǵ�Ҫ�ر�
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
	//android�˽��շ��������ص����ݣ�
	public static void ReceiveServerSocketData() {
        DatagramSocket socket;
        try {
            //ʵ�����Ķ˿ں�Ҫ�ͷ���ʱ��socketһ�£������ղ���data
            socket = new DatagramSocket(1985);
            byte data[] = new byte[4 * 1024];
            //����һ:Ҫ���ܵ�data ��������data�ĳ���
            DatagramPacket packet = new DatagramPacket(data, data.length);
            socket.receive(packet);
            //�ѽ��յ���dataת��ΪString�ַ���
            String result = new String(packet.getData(), packet.getOffset(),
                    packet.getLength());
            socket.close();//��ʹ���˼ǵ�Ҫ�ر�
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

		System.out.println("���ͳɹ� ...");
		
//		ReceiveServerSocketData();
	}
	
}
