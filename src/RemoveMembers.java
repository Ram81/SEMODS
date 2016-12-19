import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DBCon.*;
import java.util.*;
import com.mongodb.*;

@WebServlet("/RemoveMembers")
public class RemoveMembers extends HttpServlet {
	
	int uid,gid;
	DBConnect mongo;
	DBCursor cursor;
	BasicDBObject obj;
	DBCollection col;
	String uname,gname;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		
		try
		{
			gname=(String)request.getSession().getAttribute("G_Name");			
			uname=(String)request.getParameter("UName");
			
			mongo=DBConnect.getInstance();
			col=mongo.getCollection("Groups");
			
			cursor=col.find(new BasicDBObject("G_Name",gname));
			obj=(BasicDBObject)cursor.next();
			
			gid=obj.getInt("_id");
			
			col=mongo.getCollection("User");
			
			cursor=col.find(new BasicDBObject("U_Name",uname));
			obj=(BasicDBObject)cursor.next();
			
			uid=obj.getInt("_id");
			
			col.update(new BasicDBObject("_id",uid),new BasicDBObject("$pull",new BasicDBObject("Groups",gid)));
			
			col=mongo.getCollection("Groups");
			
			col.update(new BasicDBObject("_id",gid), new BasicDBObject("$pull",new BasicDBObject("Admin",uid).append("Members",uid)));
			
			request.getSession().setAttribute("G_Name", "");
			request.getSession().setAttribute("Remove_Members", "User Removed");
			response.sendRedirect("AddMembers.jsp");
		}
		catch(Exception e)
		{
			out.println("Exception "+e);
		}
	}
}
