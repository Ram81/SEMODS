<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.mongodb.*" %>
<%@ page import="DBCon.*"%>
<%@ page import="java.util.*"%>

<%!
	DBConnect mongo;
	DBCollection col;
	String uname;
	int uid;
%>
<%
	try
	{
		mongo=DBConnect.getInstance();
		uname=(String)session.getAttribute("U_Name");
		uid=(Integer)session.getAttribute("U_Id");
	}
	catch(Exception e)
	{
		out.println(e);
	}
%>
<%	
	request.getSession().setAttribute("G_Update","");
	request.getSession().setAttribute("message","");
	request.getSession().setAttribute("Add_M","");
	request.getSession().setAttribute("G_Create","");
	request.getSession().setAttribute("U_Upload","");
	request.getSession().setAttribute("G_Upload","");
	request.getSession().setAttribute("A_Message","");
%>
<!doctype html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<link rel="icon" type="image/png" href="assets/img/favicon.ico">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

	<title>Homepage</title>

	<meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
    <meta name="viewport" content="width=device-width" />

    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/animate.min.css" rel="stylesheet"/>
    <link href="css/Dashboard.css" rel="stylesheet"/>
    <link href="css/pe-icon-7-stroke.css" rel="stylesheet" />
    <link href="css/footer1.css" rel="stylesheet"/>
    <link href="css/elements.css" rel="stylesheet">
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,700,300' rel='stylesheet' type='text/css'>

</head>
<body>

<div class="wrapper">
    <div class="sidebar" data-color="blue" data-image="images/sidebar-4.jpg">

    	<div class="sidebar-wrapper">
            <div class="logo">
                <a href="" class="simple-text">
                    <i class="fa fa-cloud" style="margin:5px;"></i>SEMODS
                </a>
            </div>

            <ul class="nav">
                <li>
                    <a href="Home.jsp">
                        <i class="pe-7s-home"></i>
                        <p>Home</p>
                    </a>
                </li>
                <li>
                    <a href="Uploads.jsp">
                        <i class="pe-7s-cloud-upload"></i>
                        <p>Upload</p>
                    </a>
                </li>
                
                <li>
                    <a href="ManageGroups.jsp">
                        <i class="pe-7s-paperclip"></i>
                        <p>Add Groups</p>
                    </a>
                </li>
                
                <li class="active">
                    <a href="AddMembers.jsp">
                        <i class="pe-7s-users"></i>
                        <p>Manage Groups</p>
                    </a>
                </li>
                
                <li>
                    <a href="AddAssociate.jsp">
                        <i class="pe-7s-add-user"></i>
                        <p>Add Associates</p>
                    </a>
                </li>
                
                <li>
                    <a href="Downloads.jsp">
                        <i class="pe-7s-cloud-download"></i>
                        <p>Download</p>
                    </a>
                </li>
                
                <li>
                    <a href="LogIn">
                        <i class="pe-7s-right-arrow"></i>
                        <p>Log Out</p>
                    </a>
                </li>
            </ul>
    	</div>
    </div>

    <div class="main-panel">
        <nav class="navbar navbar-default navbar-fixed">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#">Home</a>
                </div>
                <div class="collapse navbar-collapse">
                    <ul class="nav navbar-nav navbar-left">
                        
                    </ul>

                    <ul class="nav navbar-nav navbar-right">
                        <li>
                           <a href="">
                        	<div style="font-size:24px;">
                        		<i class="pe-7s-user" style="font-size:32px;"></i>
                        		<%out.println(request.getSession().getAttribute("U_Name"));%>
                        	</div>
                           </a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>


        <div class="content">
            <div class="container-fluid">
                <div class="row">
						<ul class="nav nav-tabs">
							<li class="active"><a href="#Add" data-toggle="tab" >Add</a></li>
							<li><a href="#Remove" data-toggle="tab" >Remove</a></li>
						</ul>

						<div class="tab-content">
							
							<div class="tab-pane fade in active" id="Add">
								<h2>Add Members</h2>
	
<%
	try
	{
		if(request.getParameter("GName")==null)
		{
			col=mongo.getCollection("Groups");
			DBCursor cursor=col.find(new BasicDBObject("Admin",uid));

			if(cursor.hasNext())
			{
				while(cursor.hasNext())
				{
					DBObject o=cursor.next();
%>
					<form action="AddMembers.jsp" method="POST">
						<div class="row">
							<div class="col-lg-2"></div>
							<div class="col-lg-4">
								<i class="pe-7s-users" style="font-size:36px;"></i>
								<input type="text" name="GName" value="<%out.println(o.get("G_Name"));%>" style="background: transparent; border: none; font-size:18px; padding-bottom:25px;" readonly="readonly"/>
							</div>
							<div class="col-lg-4">
								<input type="submit" class="btn" value="Select"/>
							</div>
						</div>
					</form>
<%				
				}
			}
			else
			{
%>
					<div class="row">
						<div class="col-lg-2"></div>
						<div class="col-lg-4">
							No Groups Available
						</div>
					</div>
<%			
			}
		}
		else
		{
			col=mongo.getCollection("Groups");

			session.setAttribute("G_Name",request.getParameter("GName"));
			
			DBCursor cursor=col.find(new BasicDBObject("G_Name",request.getParameter("GName")));
			
			if(cursor.hasNext())
			{
				DBObject o=cursor.next();

				List<Integer> arr=new ArrayList<Integer>();
				List<Integer> arr1=new ArrayList<Integer>();
				
				DBCursor c1=col.find(new BasicDBObject("G_Name",request.getParameter("GName")).append("Admin",new BasicDBObject("$exists",true)));
				
				if(c1.hasNext())
					arr=(ArrayList<Integer>)o.get("Admin");
				
				c1=col.find(new BasicDBObject("G_Name",request.getParameter("GName")).append("Members",new BasicDBObject("$exists",true)));
				
				if(c1.hasNext())
					arr1=(ArrayList<Integer>)o.get("Members");
				
				col=mongo.getCollection("User");
				
				cursor=col.find(new BasicDBObject("_id",uid));
				o=cursor.next();

				
				List<Integer> arr2=(ArrayList<Integer>)o.get("Associates");
				cursor=col.find(new BasicDBObject("_id",new BasicDBObject("$nin",arr).append("$nin",arr1).append("$in",arr2)));
				
				if(cursor.hasNext())
				{
					while(cursor.hasNext())
					{
						o=cursor.next();
%>
							<form action="AddMembers" method="POST">
								<div class="row">
									<div class="col-lg-2"></div>
									<div class="col-lg-4">
										<i class="pe-7s-add-user" style="font-size:36px;"></i>
										<input type="text" name="UName" value="<%out.println(o.get("U_Name"));%>" style="background: transparent; border: none; font-size:18px; padding-bottom:25px;" readonly="readonly"/>
									</div>
									<div class="col-lg-4">
										<input type="submit" class="btn btn-primary" value="Add"/>
									</div>
								</div>
							</form>
<%
					}
				}
				else
				{
%>
					<div class="row">
						<div class="col-lg-2"></div>
						<div class="col-lg-4">
							No Associates Available
						</div>
					</div>
<%			
					
				}
			}		
		}
	}
	catch(Exception e)
	{
		out.println("Exception: "+e);
	}
%>
								${Add_Members}
							</div>

							<div class="tab-pane fade in" id="Remove">
								<h2>Remove Members</h2>

<%
	try
	{
		if(request.getParameter("GName")==null)
		{
			col=mongo.getCollection("Groups");
			DBCursor cursor=col.find(new BasicDBObject("Admin",uid));

			if(cursor.hasNext())
			{
				while(cursor.hasNext())
				{
					DBObject o=cursor.next();
%>
					<form action="AddMembers.jsp" method="POST">
						<div class="row">
							<div class="col-lg-2"></div>
							<div class="col-lg-4">
								<i class="pe-7s-users" style="font-size:36px;"></i>
								<input type="text" name="GName" value="<%out.println(o.get("G_Name"));%>" style="background: transparent; border: none; font-size:18px; padding-bottom:25px;" readonly="readonly"/>
							</div>
							<div class="col-lg-4">
								<input type="submit" class="btn" value="Select"/>
							</div>
						</div>
					</form>
<%				
				}
			}
			else
			{
%>
				<div class="row">
					<div class="col-lg-2"></div>
					<div class="col-lg-4">
						No Groups Available
					</div>
				</div>
<%						
			}
		}
		else
		{
			col=mongo.getCollection("Groups");
			
			session.setAttribute("G_Name",request.getParameter("GName"));

			DBCursor cursor=col.find(new BasicDBObject("G_Name",request.getParameter("GName")));
			
			if(cursor.hasNext())
			{
				DBObject o=cursor.next();
								
				List<Integer> arr=new ArrayList<Integer>();
				List<Integer> arr1=new ArrayList<Integer>();
				
				DBCursor c1=col.find(new BasicDBObject("G_Name",request.getParameter("GName")).append("Admin",new BasicDBObject("$exists",true)));
				
				if(c1.hasNext())
					arr=(ArrayList<Integer>)o.get("Admin");
				
				c1=col.find(new BasicDBObject("G_Name",request.getParameter("GName")).append("Members",new BasicDBObject("$exists",true)));
				
				if(c1.hasNext())
					arr1=(ArrayList<Integer>)o.get("Members");
				
				col=mongo.getCollection("User");
				
				cursor=col.find(new BasicDBObject("_id",uid));
				o=cursor.next();
				

				cursor=col.find(new BasicDBObject("$or",Arrays.asList(new BasicDBObject("_id",new BasicDBObject("$in",arr)),new BasicDBObject("_id",new BasicDBObject("$in",arr1)))));
				
				if(cursor.hasNext())
				{
				
					while(cursor.hasNext())
					{
						o=cursor.next();
%>
							<form action="RemoveMembers" method="POST">
								<div class="row">
									<div class="col-lg-2"></div>
									<div class="col-lg-4">
										<i class="pe-7s-delete-user" style="font-size:36px;"></i>
										<input type="text" name="UName" value="<%out.println(o.get("U_Name"));%>" style="background: transparent; border: none; font-size:18px; padding-bottom:25px;" readonly="readonly"/>
									</div>
									<div class="col-lg-4">
										<input type="submit" class="btn btn-danger" value="Remove"/>
									</div>
								</div>
							</form>
<%
					}
				}
			}
			else
			{
%>
				<div class="row">
					<div class="col-lg-2"></div>
					<div class="col-lg-4">
						No Users Available
					</div>
				</div>
<%			
				
			}			
		}
	}
	catch(Exception e)
	{
		out.println("Exception "+e);
	}
%>

					${Remove_Members}

							</div>
							
						</div>
                </div>
            </div>
        </div>


 <footer class="footer">
            
	<div class="footer">

			<div class="footer-left">

				<h3>SEMODS <span><i class="fa fa-cloud"></i></span></h3>

				<p class="footer-links">
					<a href="#">Home</a>
					.
					<a href="#">Blog</a>
					.
					<a href="#">About</a>
					.
					<a href="#">FAQ</a>
					.
					<a href="#">Contact</a>
				</p>

				<p class="footer-company-name">SEMODS &copy; 2016</p>
			</div>

			<div class="footer-center">

				<div>
					<i class="fa fa-map-marker"></i>
					<p><span>Pune Institute of Computer Technology </span> Pune, India</p>
				</div>

				<div>
					<i class="fa fa-phone"></i>
					<p>+91 9158592292</p>
				</div>

				<div>
					<i class="fa fa-envelope"></i>
					<p><a href="mailto:support@semods.com">support@semods.com</a></p>
				</div>

			</div>

			<div class="footer-right">

				<p class="footer-company-about">
					<span>About Us</span>
						We at SEMODS are here to provide you with our platform for managing your data & sharing it with the associates & provide you with security of your data.
				</p>

				<div class="footer-icons">

					<a href="#"><i class="fa fa-facebook"></i></a>
					<a href="#"><i class="fa fa-twitter"></i></a>
					<a href="#"><i class="fa fa-linkedin"></i></a>
					<a href="#"><i class="fa fa-github"></i></a>

				</div>

			</div>

		</div>
  </footer>

    </div>
</div>


</body>

    <!--   Core JS Files   -->
    <script src="js/jquery-1.10.2.js" type="text/javascript"></script>
	<script src="js/bootstrap.min.js" type="text/javascript"></script>
	<script src="js/bootstrap-checkbox-radio-switch.js"></script>
	<script src="js/chartist.min.js"></script>
    <script src="js/bootstrap-notify.js"></script>

    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?sensor=false"></script>

	<script src="js/Dashboard.js"></script>
	<script src="js/demo.js"></script>


</html>
