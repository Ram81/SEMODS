<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.mongodb.*" %>
<%@ page import="DBCon.*"%>
<%@ page import="java.util.*"%>
<%
	session.setAttribute("A_Message","");
	session.setAttribute("G_Create","");
	session.setAttribute("Add_Members","");
	session.setAttribute("G_Upload","");
	session.setAttribute("Remove_Members","");
	session.setAttribute("G_Update","");
	session.setAttribute("U_Upload","");
%>

<%!
	DBConnect mongo;
	DBCollection col;
	DBObject obj;
	String uname;
	int uid;
%>
<%
	try
	{
		mongo=DBConnect.getInstance();
		uname=(String)request.getSession().getAttribute("U_Name");
		uid=(Integer)request.getSession().getAttribute("U_Id");
	}
	catch(Exception e)
	{
		out.println(e);
	}
%>
<!doctype html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<link rel="icon" type="image/png" href="assets/img/favicon.ico">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

	<title>Manage Associates</title>

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
                
                <li>
                    <a href="AddMembers.jsp">
                        <i class="pe-7s-users"></i>
                        <p>Manage Groups</p>
                    </a>
                </li>
                
                <li  class="active">
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
							<li class="active"><a href="#AddAssociate" data-toggle="tab" >Associates</a></li>
						</ul>

						<div class="tab-content">
							<div class="tab-pane fade in active" id="AddAssociate">
								<h2>Add Associate</h2>
<%
	try
	{	
			col=mongo.getCollection("User");
			
			DBCursor cursor=col.find(new BasicDBObject("_id",uid).append("Associates",new BasicDBObject("$exists",true)));
			List<Integer> arr=new ArrayList<Integer>();
			
			if(cursor.hasNext())
			{
				cursor=col.find(new BasicDBObject("_id",uid));
				obj=cursor.next();
				
				arr=(List<Integer>)obj.get("Associates");
			}
				
				
			cursor=col.find(new BasicDBObject("_id",new BasicDBObject("$nin",arr).append("$ne",uid)));
			if(cursor.hasNext())
			{
				while(cursor.hasNext())
				{
					obj=cursor.next();
%>		
							<form action="AddAssociate" method="POST">
								<div class="row">
									<div class="col-lg-2"></div>
									<div class="col-lg-4">
										<i class="pe-7s-add-user" style="font-size:36px"></i>
										<input type="text" name="UName" value="<%out.println(obj.get("U_Name"));%>" style="background-color: transparent; border:none; font-size:18px; padding-bottom:25px;" readonly="readonly"/>
									</div>
									<div class="col-lg-4">
										<button type="submit" class="btn">Add</button>
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
									No User Available
								</div>
							</div>
<%
			}
	}
	catch(Exception e)
	{
		out.println(e);
	}
%>
						<div class="row">
							<div class="col-lg-2">
								${Add_M}
							</div>
						</div>
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
