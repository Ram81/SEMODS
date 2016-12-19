package encp;
import java.io.*;
import java.util.*;
import java.security.*;
import javax.crypto.*;
import javax.crypto.interfaces.*;
import javax.crypto.spec.*;


public class Decryptor {
		private static final String ALGO="AES";
		private static final String TRANSFORM="AES";
		
		public static void encrypt(String Ecp_Key,String inputFile,String OutputFile,String fileName)throws Exception
		{
			doEncrypt(Cipher.ENCRYPT_MODE,Ecp_Key,inputFile,OutputFile,fileName);
		}
		public static void decrypt(String Ecp_Key,String inputFile,String OutputFile,String fileName)throws Exception
		{
			doEncrypt(Cipher.DECRYPT_MODE,Ecp_Key,inputFile,OutputFile,fileName);
		}
		public static void doEncrypt(int cipherMode,String Ecp_Key,String inputFile,String OutputFile,String fileName)throws Exception
		{
			String filePath="/home/rockstar/Downloads/";
			try
			{
				Key ecpkey=new SecretKeySpec(Ecp_Key.getBytes(),ALGO);
				Cipher cipher=Cipher.getInstance(TRANSFORM);
				cipher.init(cipherMode, ecpkey);
				
				FileInputStream inputfilestream=new FileInputStream(inputFile);
				FileOutputStream temp=new FileOutputStream(filePath+"temp"+File.separator+fileName);
				
				byte[] bytesread=new byte[1024];
				
				int i;
				
				while((i=inputfilestream.read(bytesread))>=0)
				{
					temp.write(cipher.update(bytesread, 0, i));
				}
				
				temp.write(cipher.doFinal());
				
				inputfilestream.close();
				temp.close();
				
				inputfilestream=new FileInputStream(filePath+"temp"+File.separator+fileName);

				FileOutputStream outputfilestream=new FileOutputStream(OutputFile);
				
				byte[] obytes=new byte[1024];
				
				while((i=inputfilestream.read(bytesread))>=0)
				{
					outputfilestream.write(bytesread, 0, i);
				}
				
				inputfilestream.close();
				outputfilestream.close();
				
				File f=new File(filePath+"temp"+File.separator+fileName);
				f.delete();
			}
			catch(Exception e)
			{
				System.out.println(e);
			}
		}
	}
