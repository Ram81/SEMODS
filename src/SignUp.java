import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

import com.mongodb.*;
import DBCon.*;

@WebServlet("/SignUp")
public class SignUp extends HttpServlet {
	int uid;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		try
		{
			String uname=request.getParameter("txt_uname");
			String email=request.getParameter("txt_email");
			String mno=request.getParameter("txt_mno");
			String pass=request.getParameter("pass");
			
			DBConnect mongo=DBConnect.getInstance();
			DBCollection col=mongo.getCollection("User");
			DBObject sortQ=new BasicDBObject();
			sortQ.put("_id",-1);
			
			DBCursor cursor=col.find().sort(sortQ).limit(1);
			while(cursor.hasNext())
			{
				DBObject temp=cursor.next();
				uid=(Integer)temp.get("_id");
				out.println(uid);
			}
			
			BasicDBObject obj=new BasicDBObject();
			obj.put("_id",uid+1);
			obj.put("U_Name", uname);
			obj.put("Email",email);
			obj.put("M_No", mno);
			obj.put("Password",pass);
			obj.put("Account_Used", 0.0);
			
			col.insert(obj);
			HttpSession session=request.getSession();
			session.setAttribute("U_Name",uname);
			session.setAttribute("U_Id",uid+1);
			response.sendRedirect("Home.jsp");
		}
		catch(Exception e)
		{
			out.println(e);
		}
	}

}
