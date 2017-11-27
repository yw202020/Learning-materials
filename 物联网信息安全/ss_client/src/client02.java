import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.net.PasswordAuthentication;
import java.net.Socket;
import java.util.Scanner;

public class client02 {
	public static void main(String[] args) {
        while (true) {
            try {
                Socket socket = new Socket("127.0.0.1", 9050);
                System.out.println("please input username and password(换行输入):");
                Scanner scanner = new Scanner(System.in);
                Scanner scanner2 = new Scanner(System.in);
                String p1 = scanner.nextLine();
                String p2 = scanner.nextLine();
                String p = p1 + " " + p2;

                // 发送给服务器的数据
                DataOutputStream out = new DataOutputStream(socket.getOutputStream());
                out.writeUTF(p);
                // 接收服务器的返回数据
                DataInputStream in = new DataInputStream(socket.getInputStream());
                String sResult = in.readUTF();
                System.out.println("hserver------------------" + sResult +"\n");
                if(!sResult.equals("success")){
                    System.out.println("error!!!!\n");
                }
                socket.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
