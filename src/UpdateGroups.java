import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mongodb.*;
import DBCon.*;

@WebServlet("/UpdateGroups")
public class UpdateGroups extends HttpServlet {
	
	DBConnect mongo;
	DBCollection col;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		try
		{
			mongo=DBConnect.getInstance();
			col=mongo.getCollection("Groups");
			
			String gname=(String)request.getSession().getAttribute("G_Name");
			String ecpkey=(String)request.getParameter("Ecp_Key");
			
			DBCursor cursor=col.find(new BasicDBObject("G_Name",gname));
			DBObject obj=cursor.next();
			
			int gid=(Integer)obj.get("_id");
			
			cursor=col.find(new BasicDBObject("G_Name",request.getParameter("GName")).append("_id",new BasicDBObject("$ne",gid)));
			
			if(cursor.hasNext())
			{
				request.getSession().setAttribute("G_Update","Group Already Exists");
				request.getSession().setAttribute("G_Name","");
				response.sendRedirect("ManageGroups.jsp");
			}
			else
			{
				col.update(new BasicDBObject("G_Name",gname),new BasicDBObject("$set",new BasicDBObject("G_Name",request.getParameter("GName")).append("Ecp_Key",ecpkey)));
				request.getSession().setAttribute("G_Update","Group Details Updated Successfully");
				request.getSession().setAttribute("G_Name","");				
				response.sendRedirect("ManageGroups.jsp");
			}
		}
		catch(Exception e)
		{
			out.println("Exception "+e);
		}
	}

}
