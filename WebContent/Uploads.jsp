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
			<div style="padding:25px;">
				<button class="btn-circle" href="#" data-target="#uploader" data-toggle="modal">
					<i class="fa fa-plus"></i>
				</button>	
			</div>			
				<div id="Uploaded">
						${U_Upload}				
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
			<div style="padding:25px;">
				<button class="btn-circle" href="#" data-target="#G_uploader" data-toggle="modal">
					<i class="fa fa-plus"></i>
				</button>	
			</div>			
		
			<div id="G_Uploaded">
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
						<form action="Uploads.jsp" method="POST">
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
						${G_Upload}
							</div>
						</div>
						
                </div>
            </div>
            
			<a href="DeleteFiles.jsp">Delete Files</a>
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

		<div id="uploader" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
				<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
				          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				          <h4 class="text-center">Upload</h4>
					</div>
					<div class="modal-body">
						<form action="UserUpload" method="POST" enctype="multipart/form-data" onSubmit="return validate()"> 
								<div class="row">
									<div class="col-lg-6">
										<i class="pe-7s-unlock" style="font-size:36px;"></i>
										<input type="text" value="Encryption Key" style="border:none; background:transparent; font-size:18px; padding-bottom:25px;" readonly="readonly"/>
									</div>
									<div class="col-lg-4">
										<input type="password" id="Ecp_Key" name="Ecp_Key" value="" placeholder="Encryption Key">
									</div>
								</div>
									
								<div class="row">
									<div class="col-lg-6">
										<i class="pe-7s-unlock" style="font-size:36px;"></i>
										<input type="text" value="Confirm Key" style="border:none; background:transparent; font-size:18px; padding-bottom:25px;" readonly="readonly"/>
									</div>
									<div class="col-lg-4">
										<input type="password" id="Ecp_Key1" name="Ecp_Key1" value="" placeholder="Confirm Encryption Key">
									</div>
								</div>
									
								<div class="row">
									<div class="col-lg-6">
										<i class="pe-7s-cloud-upload" style="font-size:36px;"></i>
										<input type="text" value="Choose File :" style="border:none; background:transparent; font-size:18px; padding-bottom:25px;" readonly="readonly"/>
									</div>
									<div class="col-lg-3">
										<input type="text" name="fname" id="file_u_c" value="" placeholder="Choose File" readonly="readonly">
									</div>
									<div class="col-lg-3 fileUpload btn btn-primary">
										<span>Select</span>
										<input class="upload" type="file" name="file" id="file_u">
									</div>
								</div>
									
								<div class="row">
									<div class="col-lg-3"></div>
									<div class="col-lg-4">
										<button type="submit" class="btn">Upload</button>
									</div>
								</div>
									
						</form>
					</div>
			</div>
			</div>
		</div>			
		
		<div id="G_uploader" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
			<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
				          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				          <h4 class="text-center">Group Upload</h4>
				</div>
				<div class="modal-body">
								<form action="GroupUploads" method="POST" enctype="multipart/form-data" onSubmit="return validateL()"> 
									<div class="row">
										<div class="col-lg-6">
											<i class="pe-7s-cloud-upload" style="font-size:36px;"></i>
											<input type="text" value="Choose File :" style="border:none; background:transparent; font-size:18px; padding-bottom:25px;" readonly="readonly"/>
										</div>
										<div class="col-lg-3">
											<input type="text" name="fname" value="" placeholder="Choose File" readonly="readonly" id="file_g_c">
										</div>
										<div class="col-lg-3 fileUpload btn btn-primary">
											<span>Select</span>
											<input class="upload" type="file" name="file" id="file_g">
										</div>
									</div>
									
									<div class="row">
										<div class="col-lg-4"></div>
										<div class="col-lg-4">
											<button type="submit" class="btn"><i class="fa fa-upload"></i>Upload</button>
										</div>
									</div>
									
								</form>
					
				</div>
			</div>
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
	<script type="text/javascript">
		var file=document.getElementById("file_u").onchange=function(){
			document.getElementById("file_u_c").value=this.value;			
		};
		document.getElementById("file_g").onchange=function(){
			document.getElementById("file_g_c").value=this.value;			
		};
		
		function validate(){
			var ecp_key=document.getElementById("Ecp_Key");
			var ecp_key1=document.getElementById("Ecp_Key1");
			var f=document.getElementById("file_u_c");
			if(ecp_key.value.trim()=="" || ecp_key1.value.trim()=="")
			{
				alert("Missing Fields");
				return false;
			}
			else if(ecp_key.value.length!=16)
			{
				alert("Encryption Key must be 16 chracter long");
				return false;
			}
			else if(ecp_key.value!=ecp_key1.value)
			{
				alert("Encryption Keys must match");
				return false;
			}
			else if(f.value=="")
			{
				alert("Please Select File");
				return false;
			}
			return true;
		}
		function validateL(){
			var f2=document.getElementById("file_g_c");
			if(f2.value=="")
			{
				alert("Please Select File");
				return false;
			}
			return true;
		}
	</script>			
</body>
</html>
