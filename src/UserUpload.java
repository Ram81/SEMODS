import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import DBCon.*;
import java.util.*;
import com.mongodb.*;
import org.apache.tomcat.util.http.fileupload.*;

@WebServlet("/UserUpload")
@MultipartConfig
public class UserUpload extends HttpServlet {

	int uid,fid;
	DBConnect mongo;
	DBCursor cursor;
	DBCollection col;
	BasicDBObject obj;
	String filePath,uname;
	
	private String getFileName(final Part part) {
	    final String partHeader = part.getHeader("content-disposition");

	    for (String content : part.getHeader("content-disposition").split(";")) {
	        if (content.trim().startsWith("filename")) {
	            return content.substring(
	                    content.indexOf('=') + 1).trim().replace("\"", "");
	        }
	    }
	    return null;
	}
	
	private void upload(String fname,Part filePart,PrintWriter out)
	{
		try
		{
			OutputStream otp=new FileOutputStream(new File(filePath+uname+File.separator+fname));
			InputStream in=filePart.getInputStream();
			
			int read=0;
			byte[] bytes=new byte[1024];
			while((read=in.read(bytes))!=-1)
				otp.write(bytes, 0 , read);
		}
		catch(FileNotFoundException e)
		{
			out.println("File Not Found :"+e);
		}
		catch(Exception e)
		{
			out.println("Exception :"+e);
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		
		fid=0;
		
		filePath=(String)request.getServletContext().getInitParameter("filePath");
		uname=(String)request.getSession().getAttribute("U_Name");
		try
		{
			mongo=DBConnect.getInstance();
			col=mongo.getCollection("User");
			
			String ecp_key=request.getParameter("Ecp_Key");
			Part filePart=request.getPart("file");
			String fname=getFileName(filePart);
			
			uid=(Integer)request.getSession().getAttribute("U_Id");

			float fsize=((filePart.getSize()/(float)(1024*1024))*100)/100;
			Date d=new Date();
			
			AggregationOutput aggregate=col.aggregate(new BasicDBObject("$unwind","$Uploads"),new BasicDBObject("$match",new BasicDBObject("_id",uid)),new BasicDBObject("$group",new BasicDBObject("_id","$_id").append("F_Id",new BasicDBObject("$max","$Uploads._id"))));
			
			for(DBObject o:aggregate.results())
				fid=(Integer)o.get("F_Id");
			
			col.update(new BasicDBObject("_id",uid),new BasicDBObject("$push",new BasicDBObject("Uploads",new BasicDBObject("_id",fid+1).append("F_Name",fname).append("F_Size",fsize).append("Ecp_Key",ecp_key).append("Date_Uploaded",new Date()))).append("$inc",new BasicDBObject("Account_Used",fsize)));
			
			File f=new File(filePath+uname);
			if(!f.exists())
				f.mkdir();
			
			upload(fname,filePart,out);
			
			Encryptor.encrypt(ecp_key,filePath+uname+File.separator+fname,filePath+uname+File.separator+fname, fname);
			
			request.getSession().setAttribute("U_Upload","File Uploaded");
			response.sendRedirect("Uploads.jsp");
		}
		catch(Exception e)
		{
			out.println(e);
		}
	}

}
