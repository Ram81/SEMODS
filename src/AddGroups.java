import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mongodb.*;
import DBCon.*;
import java.util.*;

@WebServlet("/AddGroups")
public class AddGroups extends HttpServlet {
	DBConnect mongo;
	BasicDBObject obj;
	DBCollection col;
	int uid,gid;
	String uname;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		try
		{

			String gname=request.getParameter("G_Name");
			String ecpkey=request.getParameter("Ecp_Key");
			uid=(Integer)request.getSession().getAttribute("U_Id");
			uname=(String)request.getSession().getAttribute("U_Name");
			
			mongo=DBConnect.getInstance();
			col=mongo.getCollection("Groups");
				
		    obj=new BasicDBObject();
			obj.put("_id",-1);
		    
			DBCursor cursor=col.find().sort(obj).limit(1);
			gid=0;
			if(cursor.hasNext())
			{
				DBObject o=cursor.next();
				gid=(Integer)o.get("_id");
			}
			
			obj.clear();
			
		    obj.put("G_Name",gname);
				
		    cursor=col.find(obj);
			if(cursor.hasNext())
			{
				DBObject o=cursor.next();
				if(o.get("G_Name").equals(gname))
				{
					out.println(o.get("G_Name"));
					request.getSession().setAttribute("G_Create","Group Already Exists");
					response.sendRedirect("ManageGroups.jsp");
				}
			}
			else
			{			
				cursor.close();
				obj.clear();
			
				List<Integer> arr=new ArrayList<Integer>();
				arr.add(uid);
				obj.put("_id",++gid);
				obj.put("G_Name",gname);
				obj.put("Ecp_Key",ecpkey);
				obj.put("Admin",arr);
				col.insert(obj);
				
				col=mongo.getCollection("User");
				obj.clear();
				obj.put("$push",new BasicDBObject("Groups",gid));
				
				BasicDBObject search=new BasicDBObject();
				search.put("U_Name",uname);
				col.update(search,obj);

				request.getSession().setAttribute("G_Create","Group Created Successfully");
				response.sendRedirect("ManageGroups.jsp");
			}
		}
		catch(Exception e)
		{
			out.println("Exception :"+e);
		}
	}
}
