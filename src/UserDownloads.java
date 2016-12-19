import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DBCon.*;
import java.util.*;
import com.mongodb.*;

@WebServlet("/UserDownloads")
public class UserDownloads extends HttpServlet {
	
	int uid;
	DBConnect mongo;
	DBCollection col;
	String fname,filePath,uname;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		response.setContentType("text/html");		
		try
		{
			mongo=DBConnect.getInstance();
			col=mongo.getCollection("User");
			
			fname=request.getParameter("file");
			filePath=(String)getServletContext().getInitParameter("filePath");
			uname=(String)request.getSession().getAttribute("U_Name");			
			
			if((getServletContext().getMimeType(filePath+uname+"/"+fname))==null)
				response.setContentType("application/octet-stream");
			
			File f=new File(filePath+uname+"/"+fname);
			FileInputStream finput=new FileInputStream(f);
			
			response.setContentLength((int)f.length());
			response.setHeader("Content-Disposition","attachment; filename=\"" + fname + "\"");
			
			OutputStream fout=response.getOutputStream();
			byte[] fread=new byte[4096];
			int i=-1; 
			
			while((i=finput.read(fread))!=-1)
			{
				fout.write(fread,0,i);
			}
				
			finput.close();
			fout.close();
		}
		catch(Exception e)
		{
		}
	}

}
