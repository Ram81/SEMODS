<%@ page import="com.mongodb.*" %>
<%@ page import="DBCon.*" %>
<%@ page import="java.util.*" %>
<%!
	DBConnect mongo;
	DBCollection col;
	DBCursor cursor;
%>
<%	
	request.getSession().setAttribute("G_Update","");
	request.getSession().setAttribute("message","");
	request.getSession().setAttribute("Add_Members","");
	request.getSession().setAttribute("Add_M","");
	request.getSession().setAttribute("G_Create","");
	request.getSession().setAttribute("U_Upload","");
	request.getSession().setAttribute("G_Upload","");
	request.getSession().setAttribute("A_Message","");
	
	try
	{
		mongo=DBConnect.getInstance();
		col=mongo.getCollection("User");
	}
	catch(Exception e)
	{
		out.println(e);
	}
%>
<html>
<head>
		<title>Homepage</title>
		
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">
		<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
		<link href='https://fonts.googleapis.com/css?family=Open+Sans:600' rel='stylesheet' type='text/css'>
		<link href='https://fonts.googleapis.com/css?family=Nunito:300' rel='stylesheet' type='text/css'>
		<link href="css/cssStyle.css" rel="stylesheet" type="text/css">
		
</head>
<body data-spy="scroll" data-target="#my-nav">
	
	<!--Preloader Begins-->
	<div id="loader-wrapper">
		<div id="loader"></div>	
		
		<div class="loader-section section-left"></div>
		<div class="loader-section section-right"></div>	
	</div>
	<!--Preloader Ends-->	
	
		
	<!--Header Begins-->
	
	<div class="topp">
		<h2>Secure Multi-Owner Data Sharing System for Dynamic Groups in Cloud</h2>
	</div>
	
	<div class="navbar" data-spy="affix" data-offset-top="200">

		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#my-nav">
				<span class="icon-bar" style="background-color:white;"></span>
				<span class="icon-bar" style="background-color:white;"></span>
				<span class="icon-bar" style="background-color:white;"></span>			
			</button>
			<a class="navbar-brand" href="#website">
			<i class="fa fa-cloud"></i>
			</a>
		</div>

		<div class="collapse navbar-collapse "  id="my-nav">
			<ul class="nav navbar-nav navbar-right">
				<li><a class="active" href="index.jsp">Home</a></li>	
				<li><a href="LogIn.jsp" >Sign Up / Log In</a></li>
			</ul>
		</div>
	</div>	

	<!--Header Ends-->
	
	<!--Carousel Begins-->
	<div class="parallax">
		<div class="content">	
			<div class="content-a">
				<a href="#Home" ><span></span></a>
			</div>
		
		</div>
	</div>
	
	<!--Home Begins-->
	
	<div class="container-fluid" id="Home">

		<div class="row">
			<div class="col-lg-12" align="center">
					<h2>WHAT IS SEMODS ?</h2>
			</div>
		</div>
		<div class="row">
			<div class="col-lg-12">
						<p>With  the  character  of  low  maintenance,  cloud  computing  provides  an  economical  and  efficient  solution  for 
							sharing  group  resource  among  cloud  users.  Unfortunately,  sharing  data  in  a  multi-owner  manner  while 
							preserving  data  and  identity  privacy  from  an  untrusted  cloud  is  still  a  challenging  issue,  due  to  the  
							frequent change of the  membership. On our Platform, we propose a secure  multi owner data sharing scheme, named Mona/SEMODS, 
							for dynamic groups in the cloud. By leveraging group signature and dynamic broadcast encryption techniques, any  cloud  user  
							can  anonymously  share  data  with  others.  Meanwhile,  the  storage  overhead  and  encryption computation cost of our 
							scheme are independent with the number of revoked users. In addition, we analyze the security of our scheme with rigorous proofs, 
							and demonstrate the efficiency of our scheme in experiments</p>
			</div>			
			<!--Column Ends-->						
		</div>
				 	
		<h2>Features</h2>
		
		<div class="row features" style="padding-top: 25px;"> 		
			<div class="col-lg-4" align="center">
				<div class="ico"><i class="fa fa-folder-o"></i></span></div>
				<div class="ico-content">File Management</div>
			</div>
			
			<div class="col-lg-4"  align="center">
				<div class="ico"><i class="fa fa-lock"></i></span></div>
				<div class="ico-content">Security</div>
			</div>
			
			<div class="col-lg-4"  align="center">
				<div class="ico"><i class="fa fa-share-alt"></i></span></div>
				<div class="ico-content">Data Sharing</div>
			</div>
		</div>
		<div class="row features">		
			<div class="col-lg-4" align="center" >
				<div class="ico"><i class="fa fa-compress"></i></span></div>
				<div class="ico-content">Faster Access</div>
			</div>
			
			<div class="col-lg-4"  align="center">
				<div class="ico"><i class="fa fa-upload"></i></span></div>
				<div class="ico-content">Upload</div>
			</div>
			
			<div class="col-lg-4"  align="center">
				<div class="ico"><i class="fa fa-download"></i></span></div>
				<div class="ico-content">Download</div>
			</div>
		</div>				
	</div>
	
	<!--Home Ends-->
      
	<!--Gallery Begins-->

	<div class="container-fluid" id="Description">
			
		<div class="row">
			<div class="col-lg-6">
				<div class="det-content">
				<h2>Take Your Docs Anywhere</h2>
						Store your files on SEMODS and Access them anywhere in the world. 
				</div>
			</div>
			<div class="col-lg-6" align="center">
				<img class="img-responsive" src="images/anytimeaccess.png">
			</div>
		</div>
		
		<div class="row">
						
			<div class="col-lg-6" align="center">
				<img class="img-responsive" src="images/safe.png">
			</div>
			
			<div class="col-lg-6">
				<div class="det-content">
				<h2>Keep Your Data Safe</h2>
						Only authorized access to a file only with its encryption key. 
				</div>
			</div>
			
		</div>
		
		
		<div class="row">			
			<div class="col-lg-6"> 
				<div class="det-content">
				<h2>Want to Share a File</h2>
						Want to send or share some files to associate just login to SEMODS & share your files. 
				</div>
			</div>
			<div class="col-lg-6"  align="center">
				<img class="img-responsive" src="images/nolose.png">
			</div>
			
		</div>
		
		<div class="row">
			<div class="col-lg-12">
			<div class="det-content" style="padding:10px">
				<h3>Upload Rate Chart</h3>
			</div>
			
  				<div id="chart_div" style="width:100%;"></div>
			</div>
		</div>	
		
	</div>
	<!--Gallery Ends-->
	
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

  	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	<script src="https://code.jquery.com/jquery-2.2.4.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	<script src="css/script1.js"></script>
	<script type="text/javascript">
		google.charts.load('current', {packages: ['corechart', 'line']});
		google.charts.setOnLoadCallback(drawBasic);
	
		function drawBasic() {
	
		      var data = new google.visualization.DataTable();
		      data.addColumn('date', 'Day');
		      data.addColumn('number', 'Uploads');
<%
			BasicDBObject t=new BasicDBObject("year",new BasicDBObject("$year","$Uploads.Date_Uploaded")).append("month",new BasicDBObject("$month","$Uploads.Date_Uploaded")).append("day",new BasicDBObject("$dayOfMonth","$Uploads.Date_Uploaded"));
		  	AggregationOutput aggregate=col.aggregate(new BasicDBObject("$unwind","$Uploads"),new BasicDBObject("$sort",new BasicDBObject("Uploads.Date_Uploaded",1)),new BasicDBObject("$group",new BasicDBObject("_id",t).append("Data",new BasicDBObject("$sum","$Uploads.F_Size"))));
		  	for(DBObject obj:aggregate.results())
		  	{
				DBObject temp=(DBObject)obj.get("_id");
		
				int y=(Integer)temp.get("year");
				int m=(Integer)temp.get("month")-1;
				int d=(Integer)temp.get("day");
				double val=(Double)obj.get("Data");
				val=Math.round(val*100.0)/100.0;
				out.println("data.addRow([new Date("+y+","+m+","+d+"),"+val+"]);");
		  	}
%>
		      var options = {
		        hAxis: {
		          title: 'Days'
		        },
		        vAxis: {
		          title: 'Cloud Space (in MB\'s)',
		          maxValue: 20
		        }
		      };
	
		      var chart = new google.visualization.LineChart(document.getElementById('chart_div'));
	
		      chart.draw(data, options);
		    }
	</script>	
</body>
</html>
