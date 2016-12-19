import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.*;
import com.mongodb.*;
import DBCon.*;

@WebServlet("/AcceptRequest")
public class AcceptRequest extends HttpServlet {
	
	DBConnect mongo;
	DBCollection col;
	int uid;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		
		try
		{
			mongo=DBConnect.getInstance();
			col=mongo.getCollection("User");
			uid=(Integer)request.getSession().getAttribute("U_Id");
			String uname=request.getParameter("UName");
		
			String btn=request.getParameter("btn-sub");
			if(btn.equals("Accept"))
			{
				BasicDBObject obj=new BasicDBObject();
				obj.put("U_Name",uname);
				
				DBCursor cursor=col.find(obj);
				DBObject o=cursor.next();
				
				int fid=(Integer)o.get("_id");
				
				obj.clear();
				obj.put("$pull", new BasicDBObject("M_Requests",fid));
				col.update(new BasicDBObject("_id",uid),obj.append("$push",new BasicDBObject("Associates",fid)));
		
				obj.clear();
				obj.put("$push",new BasicDBObject("Associates",uid));
				col.update(new BasicDBObject("_id",fid),obj);
				
				request.getSession().setAttribute("A_Message","Request Accepted");		
			}
			else if(btn.equals("Decline"))
			{
				BasicDBObject obj=new BasicDBObject();
				obj.put("U_Name",uname);
				
				DBCursor cursor=col.find(obj);
				DBObject o=cursor.next();
				
				int fid=(Integer)o.get("_id");
				
				col.update(new BasicDBObject("_id",uid),new BasicDBObject("$pull",new BasicDBObject("M_Requests",fid)));
						
				request.getSession().setAttribute("A_Message","Request Declined");		
			}	
	
			response.sendRedirect("Home.jsp");
		}
		catch(Exception e)
		{
			out.println(e);
		}
		
	}
}
