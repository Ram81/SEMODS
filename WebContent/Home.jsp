<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.mongodb.*" %>
<%@ page import="DBCon.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.math.*"%>
<%!
	DBConnect mongo;
	DBCollection col;
	String uname;
	int uid;
	Double  d;
%>
<%
	try
	{
		mongo=DBConnect.getInstance();
		col=mongo.getCollection("User");
		uname=(String)request.getSession().getAttribute("U_Name");
		uid=(Integer)request.getSession().getAttribute("U_Id");
	}
	catch(Exception e)
	{
		out.println("e:"+e);
	}
%>
<%	
	request.getSession().setAttribute("G_Update","");
	request.getSession().setAttribute("message","");
	request.getSession().setAttribute("Add_Members","");
	request.getSession().setAttribute("Add_M","");
	request.getSession().setAttribute("G_Create","");
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
                <li class="active">
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
							<li class="active"><a href="#Home" data-toggle="tab" >Home</a></li>
							<li><a href="#Requests" data-toggle="tab" >Requests</a></li>
						</ul>

						<div class="tab-content">
							<div class="tab-pane fade in active" id="Home">
								<h3>Profile</h3>
								<div class="col-md-6">
									<div class="card">
									   <div id="piechart"></div>
	   								</div>
	   							</div>
								<div class="col-md-6">
<%
	try
	{
									BasicDBObject obj=new BasicDBObject();
									obj.put("U_Name",uname);
									DBCursor cursor=col.find(obj);
							
									if(cursor.hasNext())
									{
										DBObject obj1=cursor.next();
%>
						<div class="row">
							<div class="col-lg-2"></div>
							<div class="col-lg-4">
								User Name :
							</div>
							<div class="col-lg-4">
								<%out.println(obj1.get("U_Name"));%>
							</div>
						</div>
											
						<div class="row">
							<div class="col-lg-2"></div>
							<div class="col-lg-4">
								Email :
							</div>
							<div class="col-lg-4">
								<%out.println(obj1.get("Email"));%>
							</div>
						</div>					
						
						<div class="row">
							<div class="col-lg-2"></div>
							<div class="col-lg-4">
								Mobile Number :
							</div>
							<div class="col-lg-4">
								<%out.println(obj1.get("M_No"));%>
							</div>
						</div>
						
						<div class="row">
							<div class="col-lg-2"></div>
							<div class="col-lg-4">
								Account :
							</div>
							<div class="col-lg-4">
<%
							d=new BigDecimal((Double)obj1.get("Account_Used")).setScale(3,BigDecimal.ROUND_HALF_UP).doubleValue();
							out.println(d+"MB/2GB");
%>

							</div>
						</div>
<%										
									}
%>							
								</div>
							</div>
							
							<div class="tab-pane fade in" id="Requests">
								<h2>Requests</h2>
<%
	try
	{
		col=mongo.getCollection("User");
		obj.clear();
		cursor=col.find(new BasicDBObject("M_Requests",new BasicDBObject("$exists",true)).append("_id",uid));
	
		if(cursor.hasNext())
		{
			obj.put("_id",uid);
		
			cursor=col.find(obj);
			DBObject o=cursor.next();
		
			List<Integer> arr=(ArrayList<Integer>)o.get("M_Requests");
		
			obj.clear();
			obj.put("_id",new BasicDBObject("$in",arr));

			cursor=col.find(obj);
			if(cursor.hasNext() && arr!=null)
			{
				while(cursor.hasNext())
				{
					o=cursor.next();			
%>
								<form action="AcceptRequest" method="post">
									<div class="row">
										<div class="col-lg-2"></div>
										<div class="col-lg-4">
											<i class="pe-7s-add-user" style="font-size:36px"></i>
											<input type="text" name="UName" value="<%out.println(o.get("U_Name"));%>" style="background-color: transparent; border:none;"/>
										</div>
										<div class="col-lg-3">
											<button type="submit" class="btn" name="btn-sub" value="Accept">Accept</button>
										</div>
										<div class="col-lg-3">
											<button type="submit" class="btn" name="btn-sub" style="background:#ff3333;" value="Decline">Decline</button>
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
											No Requests Available
										</div>
									</div>
<%			
			}
		}
		else
		{
%>
								<div class="row">
									<div class="col-lg-2"></div>
									<div class="col-lg-4">
										No Requests Available
									</div>
								</div>
<%			
		}
	}
	catch(Exception e)
	{
		out.println("E:"+e);
	}

	}
	catch(Exception e)
	{
		out.println(e);
	}
%>								
		
							${A_Message}
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
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

    <!--   Core JS Files   -->
    <script src="js/jquery-1.10.2.js" type="text/javascript"></script>
	<script src="js/bootstrap.min.js" type="text/javascript"></script>
	<script src="js/bootstrap-checkbox-radio-switch.js"></script>
	<script src="js/chartist.min.js"></script>
    <script src="js/bootstrap-notify.js"></script>

    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?sensor=false"></script>

	<script src="js/Dashboard.js"></script>
	<script src="js/demo.js"></script>
	
	<script type="text/javascript">
		 google.charts.load('current', {'packages':['corechart']});
	     google.charts.setOnLoadCallback(drawChart);
	     function drawChart() {
	
	       var data = google.visualization.arrayToDataTable([
	         ['Size', 'Size Used'],
	         ['Free Space',    <%out.println(((double)2-(d/(double)1024)));%>],
	         ['Occupied Space',     <%out.println((d/(double)1024));%>]
	       ]);
	
	       var options = {
	         title: 'Account Used'
	       };
	
	       var chart = new google.visualization.PieChart(document.getElementById('piechart'));
	
	       chart.draw(data, options);
	     }
	</script>

</html>
