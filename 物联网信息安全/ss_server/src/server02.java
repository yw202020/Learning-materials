import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;

public class server02 implements Runnable {
    public int port;

    public server02(int port) {
        this.port = port;
    }

    public void run() {
        try {
            ServerSocket server = new ServerSocket(port);
            while (true) {
                //等待client的请求
                System.out.println("waiting...");
                Socket socket = server.accept();
            	// 接收客户端的数据
                DataInputStream in = new DataInputStream(socket.getInputStream());
                String string = in.readUTF();
                String[] string2 = string.split(" ");
                String username = string2[0];
                String password = string2[1];
                
                System.out.println("client:" + string);
                // 发送给客户端数据
                DataOutputStream out = new DataOutputStream(socket.getOutputStream());
                String flag = "error";
                if(username.equals("storm") && password.equals("123456")){
                	flag = "success";
                }
                out.writeUTF(flag);
                socket.close();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
    	server02 serverApp = new server02(9050);
        serverApp.run();
    }
}