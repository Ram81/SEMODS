import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DBCon.*;
import com.mongodb.*;


@WebServlet("/DeleteFile")
public class DeleteFile extends HttpServlet {

	DBConnect mongo;
	DBCollection col;
	DBCursor cursor;	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String filePath=request.getServletContext().getInitParameter("filePath");
		response.setContentType("text/html");
		try
		{
			int uid=(Integer)request.getSession().getAttribute("U_Id");
			String uname=(String)request.getSession().getAttribute("U_Name");
			String fname=request.getParameter("F_Name").trim();
			int fid=Integer.parseInt(request.getParameter("F_Id").trim());
			float size=-1*Float.parseFloat(request.getParameter("F_Size").trim());			
			
			mongo=DBConnect.getInstance();
			col=mongo.getCollection("User");
			
			col.update(new BasicDBObject("_id",uid),new BasicDBObject("$pull",new BasicDBObject("Uploads",new BasicDBObject("_id",fid))).append("$inc",new BasicDBObject("Account_Used",size)));

			File F=new File(filePath+uname+File.separator+fname);
			
			if(F.exists())
				F.delete();			
			
			request.getSession().setAttribute("Delete_Files", "File Deleted");
			response.sendRedirect("DeleteFiles.jsp");
		}
		catch(Exception e)
		{
			request.getSession().setAttribute("Delete_Files", "File Deletion Failed"+e);
			response.sendRedirect("DeleteFiles.jsp");
		}
	}

}
