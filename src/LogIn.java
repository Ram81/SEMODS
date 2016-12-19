import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mongodb.*;
import DBCon.*;

@WebServlet("/LogIn")
public class LogIn extends HttpServlet {

	protected void doGet(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		HttpSession session=request.getSession();
		session.removeAttribute("U_Name");
		session.removeAttribute("U_Id");
		session.removeAttribute("G_Name");
		response.sendRedirect("LogIn.jsp");
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		
		try
		{
			DBConnect mongo=DBConnect.getInstance();
			DBCollection col=mongo.getCollection("User");
			
			String uname=request.getParameter("Uname");
			String pass=request.getParameter("Password");
			
			BasicDBObject obj=new BasicDBObject();			
			obj.put("Email",uname);
			obj.put("Password",pass);
			
			DBObject doc=col.findOne(obj);
			if(doc==null)
			{
				request.getSession().setAttribute("msg","Invalid LogIn Id or Password");
				response.sendRedirect("LogIn.jsp");	
			}
			else
			{
				HttpSession session=request.getSession();
				session.setAttribute("U_Name",(String)doc.get("U_Name"));
				session.setAttribute("U_Id", doc.get("_id"));
				response.sendRedirect("Home.jsp");
			}
		}
		catch(Exception e)
		{
			out.println(e);
		}
	}
}
