import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DBCon.*;
import java.util.*;
import com.mongodb.*;

@WebServlet("/AddMembers")
public class AddMembers extends HttpServlet {
	
	DBConnect mongo;
	DBCollection col;
	int uid,gid;
	DBCursor cursor;
	DBObject obj;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		
		try
		{
			uid=(Integer)request.getSession().getAttribute("U_Id");
			String gname=(String)request.getSession().getAttribute("G_Name");
			
			String uname=request.getParameter("UName");
			
			mongo=DBConnect.getInstance();

			col=mongo.getCollection("Groups");
			cursor=col.find(new BasicDBObject("G_Name",gname));
			obj=cursor.next();
			
			gid=(Integer)obj.get("_id");
			
			col=mongo.getCollection("User");
			
			cursor=col.find(new BasicDBObject("U_Name",uname));
			obj=cursor.next();
			
			int fid=(Integer)obj.get("_id");
			
			col.update(new BasicDBObject("_id",fid),new BasicDBObject("$push",new BasicDBObject("Groups",gid)));
			
			col=mongo.getCollection("Groups");

			col.update(new BasicDBObject("_id",gid),new BasicDBObject("$push",new BasicDBObject("Members",fid)));
			
			request.getSession().setAttribute("G_Name","");
			request.getSession().setAttribute("Add_Members","User Added to Group");
			response.sendRedirect("AddMembers.jsp");
		}
		catch(Exception e)
		{
			out.println(e);
		}
	}
}
