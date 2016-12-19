package encp;
import java.util.*;
import java.sql.*;

public class SEMODS_Decryptor {
	public static void main(String args[])throws Exception
	{
		Scanner sc=new Scanner(System.in);
		System.out.println("Enter File Path :");
		String path=sc.nextLine();

		System.out.println("Enter File Name :");
		String fname=sc.nextLine();
		
		System.out.println("Enter Encryption Key :");
		String ecp_key=sc.nextLine();
		
		Decryptor.decrypt(ecp_key,path,path,fname);
		System.out.println("File Decrypted");
	}
}
