import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mongodb.*;
import java.util.*;
import DBCon.*;

@WebServlet("/AddAssociate")
public class AddAssociate extends HttpServlet {
	
	DBConnect mongo;
	DBCollection col;
	int uid;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		PrintWriter out=response.getWriter();
		response.setContentType("text/html");
		try
		{
			mongo=DBConnect.getInstance();
			col=mongo.getCollection("User");
			uid=(Integer)request.getSession().getAttribute("U_Id");
			String uname=request.getParameter("UName");

			DBCursor cursor=col.find(new BasicDBObject("U_Name",uname));
			int fid=(Integer)cursor.next().get("_id");
			
			out.println(fid);
			
			col.update(new BasicDBObject("_id",fid),new BasicDBObject("$push",new BasicDBObject("M_Requests",uid)));
			request.getSession().setAttribute("Add_M","Request Sent");
			response.sendRedirect("AddAssociate.jsp");
		}
		catch(Exception e)
		{
			out.println(e);
		}
	}

}
