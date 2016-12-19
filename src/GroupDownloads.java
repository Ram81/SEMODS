import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DBCon.*;
import java.util.*;
import com.mongodb.*;

@WebServlet("/GroupDownloads")
public class GroupDownloads extends HttpServlet {

	int uid;
	DBConnect mongo;
	DBCollection col;
	String fname,gname,filePath;	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		response.setContentType("text/html");
		try
		{
			fname=request.getParameter("file");
			filePath=(String)getServletContext().getInitParameter("filePath");
			gname=(String)request.getSession().getAttribute("G_Name");
			
			System.out.println(fname+" "+filePath+" "+gname);
			
			if(getServletContext().getMimeType(filePath+gname+"/"+fname)==null)
					response.setContentType("application/octet-stream");
			
			File f=new File(filePath+gname+"/"+fname);
			FileInputStream input=new FileInputStream(f);			
			
			response.setContentLength((int)f.length());
			response.setHeader("Content-Disposition", "attachment; filename=\""+fname+"\"");
			
			OutputStream out=response.getOutputStream();
			byte[] bytes=new byte[4096];
			int read=-1;
			
			while((read=input.read(bytes))!=-1)
				out.write(bytes,0,read);
			
			request.getSession().setAttribute("G_Name","");
			out.close();
			input.close();
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
	}

}
