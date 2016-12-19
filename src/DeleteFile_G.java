import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DBCon.*;
import com.mongodb.*;

@WebServlet("/DeleteFile_G")
public class DeleteFile_G extends HttpServlet {

	DBConnect mongo;
	DBCollection col;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		response.setContentType("text/html");
		String filePath=(String)request.getServletContext().getInitParameter("filePath");
		try
		{
			mongo=DBConnect.getInstance();
			col=mongo.getCollection("Groups");
			
			int fid=Integer.parseInt(request.getParameter("F_Id").trim());
			String gname=(String)request.getSession().getAttribute("G_Name");
			String fname=request.getParameter("F_Name").trim();
			float size=-1*Float.parseFloat(request.getParameter("F_Size").trim());
			
			col.update(new BasicDBObject("G_Name",gname),new BasicDBObject("$pull",new BasicDBObject("Group_Uploads",new BasicDBObject("_id",fid))).append("$inc",new BasicDBObject("Account_Used",size)));
			
			File F=new File(filePath+gname+File.separator+fname);
			
			if(F.exists())
				F.delete();
			
			request.getSession().setAttribute("Delete_Files","File Deleted Successfully");
			request.getSession().setAttribute("G_Name","");
			response.sendRedirect("DeleteFiles.jsp");
		}
		catch(Exception e)
		{
			request.getSession().setAttribute("Delete_Files","Deletion Failed");
			request.getSession().setAttribute("G_Name","");
			response.sendRedirect("DeleteFiles.jsp");
		}
	}

}
