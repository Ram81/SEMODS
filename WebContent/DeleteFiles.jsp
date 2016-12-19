<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="DBCon.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.mongodb.*" %>

<%!
	DBConnect mongo;
	DBCollection col;
	String uname;
	int uid,gid;
%>
<%
	try
	{
		mongo=DBConnect.getInstance();
		col=mongo.getCollection("User");
		uname=(String)request.getSession().getAttribute("U_Name");
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
	request.getSession().setAttribute("Add_Members","");
	request.getSession().setAttribute("Add_M","");
	request.getSession().setAttribute("G_Create","");
	request.getSession().setAttribute("A_Message","");
	request.getSession().setAttribute("Remove_Members","");
%>

<!doctype html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<link rel="icon" type="image/png" href="assets/img/favicon.ico">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

	<title>Light Bootstrap Dashboard by Creative Tim</title>

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
                <li class="active">
                    <a href="#">
                        <i class="pe-7s-cloud-upload"></i>
                        <p>Delete</p>
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
<%
		if(request.getParameter("G_Name")==null)
		{
%>
							<li class="active"><a href="#Uploads" data-toggle="tab">User</a></li>
							<li><a href="#Upload" data-toggle="tab">Groups</a></li>
<%
		}
		else
		{
%>							
							<li><a href="#Uploads" data-toggle="tab">User</a></li>
							<li class="active"><a href="#Upload" data-toggle="tab">Groups</a></li>
<%
		}
%>							
						</ul>

						<div class="tab-content">
<%
		if(request.getParameter("G_Name")==null)
		{
%>
					<div class="tab-pane fade in active" id="Uploads">
<%
		}
		else
		{
%>							
					<div class="tab-pane fade in" id="Uploads">
<%
		}
%>		
				<div id="Uploaded">
					<h3>File Deletion</h3>
<%
	try
	{
		col=mongo.getCollection("User");
		DBCursor cursor=col.find(new BasicDBObject("Uploads",new BasicDBObject("$exists",true)).append("_id",uid));
		
		if(cursor.hasNext())
		{
%>
									<div class="table-responsive">
										<table class="table">
											<thead>
												<th>Sr No.</th>
												<th>File Name</th>
												<th>Date Uploaded</th>
												<th>Size</th>
											</thead>
											<tbody>
			
<%			
			DBObject obj=cursor.next();
			List<DBObject> list=(ArrayList<DBObject>)obj.get("Uploads");
			
			Iterator<DBObject> it=list.iterator();
			int id=0;
			while(it.hasNext())
			{
				obj=it.next();
%>
											<tr>
												<td><%out.println(++id);%></td>
												<td><%out.println(obj.get("F_Name"));%></td>
												<td><%out.println(obj.get("Date_Uploaded")); %></td>
												<td><%out.println(obj.get("F_Size"));%></td>
												<td>
												<form action="DeleteFile" method="POST">
														<div style="padding:15px;">
															<button class="btn-circle" type="submit" style="background:#ff3333;">
																<i class="fa fa-times"></i>
															</button>	
														</div>	
														<input type="hidden" name="F_Id" value="<%out.println(obj.get("_id"));%>">
														<input type="hidden" name="F_Name" value="<%out.println(obj.get("F_Name"));%>">
														<input type="hidden" name="F_Size" value="<%out.println(obj.get("F_Size"));%>">
												</form>
												</td>
											</tr>
<%			}%>
		
											</tbody>
										</table>
									</div>
<%			
		}
		else
		{
				out.println("No Uploads");
		}
	}
	catch(Exception e)
	{
			
	}		
%>	

							</div>			
						</div>
			
<%
	if(request.getParameter("G_Name")==null)
	{
%>					
							<div class="tab-pane fade in" id="Upload">
<%
	}
	else
	{
%>								
							<div class="tab-pane fade in active" id="Upload">
<%
	}
%>						
								<h3>Upload to Groups</h3>
<%
	if(request.getParameter("G_Name")!=null)
	{
			request.getSession().setAttribute("G_Name",request.getParameter("G_Name"));
%>
			<div id="G_Uploaded">
				<h3>File Deletion</h3>
<%
	try
	{
		col=mongo.getCollection("Groups");
		DBCursor cursor=col.find(new BasicDBObject("Group_Uploads",new BasicDBObject("$exists",true)).append("G_Name",request.getParameter("G_Name")));
		
		if(cursor.hasNext())
		{
%>
									<div class="table-responsive">
										<table class="table">
											<thead>
												<th>Sr No.</th>
												<th>File Name</th>
												<th>Date Uploaded</th>
												<th>Size</th>
											</thead>
											<tbody>
			
<%			
			DBObject obj=cursor.next();
			List<DBObject> list=(ArrayList<DBObject>)obj.get("Group_Uploads");
			
			Iterator<DBObject> it=list.iterator();
			int id=0;
			while(it.hasNext())
			{
				obj=it.next();
%>
											<tr>
												<td><%out.println(++id);%></td>
												<td><%out.println(obj.get("F_Name"));%></td>
												<td><%out.println(obj.get("Date_Uploaded")); %></td>
												<td><%out.println(obj.get("F_Size"));%></td>
												<td>
												<form action="DeleteFile_G" method="POST">
														<div style="padding:15px;">
															<button class="btn-circle" type="submit" style="background:#ff3333;">
																<i class="fa fa-times"></i>
															</button>	
														</div>	
														<input type="hidden" name="F_Id" value="<%out.println(obj.get("_id"));%>">
														<input type="hidden" name="F_Name" value="<%out.println(obj.get("F_Name"));%>">
														<input type="hidden" name="F_Size" value="<%out.println(obj.get("F_Size"));%>">
												</form>
												</td>
											</tr>
<%			}%>
		
											</tbody>
										</table>
									</div>
<%			
		}
		else
		{
				out.println("No Uploads");
		}
	}
	catch(Exception e)
	{
			
	}		
%>	
			</div>
<%			
	}
	else
	{
		col=mongo.getCollection("Groups");
		
		DBCursor cursor=col.find(new BasicDBObject("$or",Arrays.asList(new BasicDBObject("Admin",uid),new BasicDBObject("Members",uid)))).sort(new BasicDBObject("_id",1));
		
		if(cursor.hasNext())
		{
			while(cursor.hasNext())
			{
				DBObject o=cursor.next();
				String gn=(String)o.get("G_Name");
%>
						<form action="DeleteFiles.jsp" method="POST">
								<div class="row">
									<div class="col-lg-2"></div>
									<div class="col-lg-4">
										<i class="pe-7s-users" style="font-size:36px;"></i>
										<input type="text" name="G_Name" id="G_Name" value="<%out.println(gn);%>" style="background-color: transparent; border:none; font-size:18px; padding-bottom:25px;" readonly="readonly"/>
									</div>
									
									<div class="col-lg-3">
										<button type="submit" class="btn">Select</button>
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
									<div clas="col-lg-4">
										No Groups Available
									</div>
								</div>
<%		
		}
	}
%>	
							</div>
						</div>
						
                </div>
            </div>
					${Delete_Files}
					<a href="Uploads.jsp">Upload Files</a>
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
    <!--   Core JS Files   -->
    <script src="js/jquery-1.10.2.js" type="text/javascript"></script>
	<script src="js/bootstrap.min.js" type="text/javascript"></script>
	<script src="js/bootstrap-checkbox-radio-switch.js"></script>
	<script src="js/chartist.min.js"></script>
    <script src="js/bootstrap-notify.js"></script>

	<script src="js/Dashboard.js"></script>
	<script src="js/demo.js"></script>			
</body>
</html>
