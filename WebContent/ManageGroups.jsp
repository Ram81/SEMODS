<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.mongodb.*" %>
<%@ page import="DBCon.*"%>
<%@ page import="java.util.*" %>
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
	request.getSession().setAttribute("message","");
	request.getSession().setAttribute("Add_Members","");
	request.getSession().setAttribute("Add_M","");
	request.getSession().setAttribute("A_Message","");
	request.getSession().setAttribute("U_Upload","");
	request.getSession().setAttribute("G_Upload","");
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
                <li>
                    <a href="Uploads.jsp">
                        <i class="pe-7s-cloud-upload"></i>
                        <p>Upload</p>
                    </a>
                </li>
                
                <li class="active">
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
							<li class="active"><a href="#Groups" data-toggle="tab">Groups</a></li>
							<li><a href="#Update" data-toggle="tab">Update</a></li>
<%
		}
		else
		{
%>							
							<li><a href="#Groups" data-toggle="tab">Groups</a></li>
							<li class="active"><a href="#Update" data-toggle="tab">Update</a></li>
<%
		}
%>							
						</ul>

						<div class="tab-content">
<%
		if(request.getParameter("G_Name")==null)
		{
%>
					<div class="tab-pane fade in active" id="Groups">
<%
		}
		else
		{
%>							
					<div class="tab-pane fade in" id="Groups">
<%
		}
%>					
			<div style="padding:25px;">
				<button class="btn-circle" href="#" data-target="#Group_modal" data-toggle="modal">
					<i class="fa fa-plus"></i>
				</button>	
			</div>			

				<div id="GroupCreate">
						${G_Create}				
<%
	try
	{
		col=mongo.getCollection("Groups");
		DBCursor cursor=col.find(new BasicDBObject("$or",Arrays.asList(new BasicDBObject("Admin",uid),new BasicDBObject("Members",uid))));
		
		if(cursor.hasNext())
		{
%>
									<div class="table-responsive">
										<table class="table">
											<thead>
												<th>Sr No.</th>
												<th>Group Name</th>
												<th>Type</th>
											</thead>
											<tbody>
			
<%			
			int id=0;
			while(cursor.hasNext())
			{
				DBObject obj=cursor.next();
%>	
											<tr>
												<td><%out.println(++id);%></td>
												<td><%out.println(obj.get("G_Name"));%></td>
<%
				DBCursor c1=col.find(new BasicDBObject("G_Name",obj.get("G_Name")).append("Admin",uid));
				if(c1.hasNext())
				{
%>									
												<td><%out.println("Admin"); %></td>
<%				}
				else
				{
%>
												<td><%out.println("Member"); %></td>
<%
				}
%>
											</tr>
<%
			}
%>		
											</tbody>
										</table>
									</div>
<%			
		}
		else
		{
				out.println("No Groups Available");
		}
	}
	catch(Exception e)
	{
			out.println(e);
	}		
%>	
							</div>			
						</div>
<%
	if(request.getParameter("G_Name")==null)
	{
%>					
							<div class="tab-pane fade in" id="Update">
<%
	}
	else
	{
%>								
							<div class="tab-pane fade in active" id="Update">
<%
	}
%>						
								<h2>Update Groups</h2>
<%
	if(request.getParameter("G_Name")!=null)
	{
		col=mongo.getCollection("Groups");
		
		BasicDBObject obj=new BasicDBObject();
		obj.put("G_Name",request.getParameter("G_Name"));
		obj.put("Admin",uid);
		request.getSession().setAttribute("G_Name",request.getParameter("G_Name"));
		
		DBCursor cursor=col.find(obj);
		if(cursor.hasNext())
		{
			DBObject o=cursor.next();
%>								
				<form action="UpdateGroups" method="POST" id="Update_Groups"  onSubmit="return validateL()">
								<div class="row">
									<div class="col-lg-2"></div>
									<div class="col-lg-4">
										<input type="text" value="Group Name :" style="background-color: transparent; border:none;" readonly="readonly"/>
									</div>
									<div class="col-lg-4">
										<input type="text" name="GName" id="U_Gname" value="<%out.println(o.get("G_Name"));%>"/>
									</div>
								</div>
								
								<div class="row">
									<div class="col-lg-2"></div>
									<div class="col-lg-4">
										<input type="text" value="Encryption Key :" style="background-color: transparent; border:none;" disabled="true">
									</div>
									<div class="col-lg-4">
										<input type="password" name="Ecp_Key" id="U_ecp_key" value="<%out.println(o.get("Ecp_Key"));%>"/>
									</div>
								</div>
								<div class="row">
									<div class="col-lg-4"></div>
									<div class="col-lg-3">
										<button type="submit" class="btn">Update</button>
									</div>
								</div>
				</form>
<%
		}
	}
	else
	{
		col=mongo.getCollection("Groups");
		BasicDBObject obj=new BasicDBObject();
		obj.put("Admin",uid);
		
		DBCursor cursor=col.find(obj);
		if(cursor.hasNext())
		{
			while(cursor.hasNext())
			{
				DBObject o=cursor.next();
%>
						<form action="ManageGroups.jsp" method="POST">
								<div class="row">
									<div class="col-lg-2"></div>
									<div class="col-lg-4">
										<i class="pe-7s-users" style="font-size:36px;"></i>
										<input type="text" name="G_Name" id="G_Name" value="<%out.println(o.get("G_Name"));%>" style="background-color: transparent; border:none; font-size:18px; padding-bottom:25px;" readonly="readonly"/>
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
										You Don't Have any Access to Modify Groups.
									</div>
								</div>

<%			
		}
	}
%>							
								${G_Update}	
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

<div class="modal fade" tabindex="-1" role="dialog" id="Group_modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					<h3 align="center">Create Groups</h3>
				</div>			
				<div class="modal-body">
									<form action="AddGroups" method="POST" id="Create_Group" onSubmit="return validate()">
										<div class="row">
											<div class="col-lg-1"></div>
											<div class="col-lg-4">
												<input type="text"  value="Group Name :" style="background-color: transparent; border:none;" readonly="readonly"/>
											</div>
											
											<div class="col-lg-4">
												<input type="text" name="G_Name" id="G_Name" placeholder="Group Name"/>
											</div>
										</div>
										
										<div class="row">
											<div class="col-lg-1"></div>
											<div class="col-lg-4">
												<input type="text" value="Encryption Key :" style="background-color: transparent; border:none;" readonly="readonly"/>
											</div>
											
											<div class="col-lg-4">
												<input type="password" name="Ecp_Key" id="Ecp_Key" placeholder="Encryption Key"/>
											</div>
										</div>
										
										<div class="row">
											<div class="col-lg-1"></div>
											<div class="col-lg-4">
												<input type="text" value="Confirm Encryption Key :" style="background-color: transparent; border:none;" readonly="readonly"/>
											</div>
											
											<div class="col-lg-4">
												<input type="password" name="Ecp_Key1" id="Ecp_Key1" placeholder="Confirm Encryption Key"/>
											</div>
										</div>
										
										<div class="row">
											<div class="col-lg-4"></div>
											<div class="col-lg-3">
												<button type="submit" class="btn">Create Groups</button>
											</div>
											
										</div>
									</form>
								</div>
			</div>
		</div>
	</div>
	
</body>
	
	
    <!--   Core JS Files   -->
    <script src="js/jquery-1.10.2.js" type="text/javascript"></script>
	<script src="js/bootstrap.min.js" type="text/javascript"></script>
	<script src="js/bootstrap-checkbox-radio-switch.js"></script>
	<script src="js/chartist.min.js"></script>
    <script src="js/bootstrap-notify.js"></script>

	<script src="js/Dashboard.js"></script>
	<script src="js/demo.js"></script>
	<script type="text/javascript">
		function validate(){

			var gname=document.getElementById("G_Name");
			var ecp_key=document.getElementById("Ecp_Key");
			var ecp_key1=document.getElementById("Ecp_Key1");
			
			if(ecp_key.value.trim()=="" || ecp_key1.value.trim()=="" || gname.value=="")
			{
				alert("Missing Fields");
				return false;
			}
			else if(ecp_key.value.length!=16)
			{
				alert("Encryption Key must be 16 of characters");
				return false;
			}
			else if(ecp_key.value!=ecp_key1.value)
			{
				alert("Encryption Keys must match");
				return false;
			}
			return true;
		}
		
		function validateL(){
			var gname=document.getElementById("U_Gname");
			var ecp_key=document.getElementById("U_ecp_key");
			
			if(gname.value=="" || ecp_key.value=="")
			{
				alert("Missing Fields");
				return false;	
			}
			else if(ecp_key.value.length!=16)
			{
				alert("Encryption Key must be of 16 characters");
				return false;
			}
			return true;
		}
		
	</script>
</html>
