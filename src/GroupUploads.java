import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import DBCon.*;
import java.util.*;
import com.mongodb.*;
import org.apache.tomcat.util.http.fileupload.*;

@WebServlet("/GroupUploads")
@MultipartConfig
public class GroupUploads extends HttpServlet {
	
	int uid,gid,fid;
	DBConnect mongo;
	DBCollection col;
	DBCursor cursor;
	DBObject obj;
	float fileSize;
	String gname,uname,fileName,filePath;
	
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
	
	private void upload(Part filePart)
	{
		try
		{
			OutputStream otp=new FileOutputStream(new File(filePath+gname+File.separator+fileName));
			InputStream in=filePart.getInputStream();
			
			int read=-1;
			byte[] bytes=new byte[1024];
			while((read=in.read(bytes))!=-1)
				otp.write(bytes, 0 , read);
		}
		catch(FileNotFoundException e)
		{
		}
		catch(Exception e)
		{
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
			response.setContentType("text/html");
			PrintWriter out=response.getWriter();
			
			filePath=(String)request.getServletContext().getInitParameter("filePath");
			
			try
			{			
				mongo=DBConnect.getInstance();
			
				col=mongo.getCollection("Groups");
				
				Part filePart=request.getPart("file");
				fileName=getFileName(filePart);
				fileSize=(filePart.getSize()/(float)(1024*1024))*100/100;
				
				gname=(String)request.getSession().getAttribute("G_Name");
				
				cursor=col.find(new BasicDBObject("G_Name",gname));
				obj=cursor.next();
				gid=(Integer)obj.get("_id");
				String ecp_key=(String)obj.get("Ecp_Key");
				
				AggregationOutput aggregate=col.aggregate(new BasicDBObject("$match",new BasicDBObject("G_Name",gname)),new BasicDBObject("$unwind","$Group_Uploads"),new BasicDBObject("$group",new BasicDBObject("_id","$_id").append("F_Id",new BasicDBObject("$max","$Group_Uploads._id"))));
				for(DBObject o:aggregate.results())
					fid=(Integer)o.get("F_Id");
				
				col.update(new BasicDBObject("_id",gid),new BasicDBObject("$push",new BasicDBObject("Group_Uploads",new BasicDBObject("_id",fid+1).append("F_Name", fileName).append("Ecp_Key",ecp_key).append("F_Size",fileSize).append("Date_Uploaded",new Date()))).append("$inc",new BasicDBObject("Account_Used",fileSize)));
				
				File F=new File(filePath+gname);
				if(F.exists()==false)
					F.mkdir();
				
				upload(filePart);
				
				Encryptor.encrypt(ecp_key, filePath+gname+File.separator+fileName, filePath+gname+File.separator+fileName, fileName);
				
				request.getSession().setAttribute("G_Upload","File Uploaded to group");
				response.sendRedirect("Uploads.jsp");
			}
			catch(Exception e)
			{
				out.println(gname);
				out.println("Exception "+e);
			}
	}	

}
