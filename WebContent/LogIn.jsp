<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<%
	session.setAttribute("A_Message","");
	session.setAttribute("Add_M","");
	session.setAttribute("G_Create","");
	session.setAttribute("Add_Members","");
	session.setAttribute("G_Upload","");
	session.setAttribute("Remove_Members","");
	session.setAttribute("G_Update","");
	session.setAttribute("U_Upload","");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
  <head>
    <title>Sign-Up/Login Form</title>
    <link href='http://fonts.googleapis.com/css?family=Titillium+Web:400,300,600' rel='stylesheet' type='text/css'>
	 <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">
	 <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
    <link href="css/style1.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="css/normalize.css">  
    <link rel="stylesheet" href="css/Login_style.css">       
  </head>

  <body>

    <div class="form">
      
      <ul class="tab-group">
        <li class="tab active"><a href="#signup">Sign Up</a></li>
        <li class="tab"><a href="#login">Log In</a></li>
      </ul>
      
      <div class="tab-content">
        <div id="signup">   
          <h1>Sign Up</h1>
          
          <form action="SignUp" method="POST" onSubmit="return validate()">
          
	          <div class="field-wrap">
	            <input type="text" id="txt_uname" name="txt_uname" placeholder="User Name*" required autocomplete="off"/>
	          </div>
	      
	          <div class="field-wrap">
	            <input type="email" id="txt_email" name="txt_email" placeholder="Email Address*" required autocomplete="off"/>
	          </div>
	          
	          <div class="field-wrap">
	            <input type="text" id="txt_mno" name="txt_mno" placeholder="Mobile Number*" required autocomplete="off"/>
	          </div>          
	          
	          <div class="field-wrap">
	            <input type="password" id="pass" name="pass" placeholder="Password*" required autocomplete="off"/>
	          </div>          
	
	          <div class="field-wrap">
	            <input type="password" id="pass1" name="pass1" placeholder="Confirm Password*" required autocomplete="off"/>
	          </div>
	                    
	          
	          <button type="submit" class="button button-block"/>Sign Up</button>
          
          </form>

		<h3>${msg}</h3>
        </div>
        
        <div id="login">   
          <h1>LogIn</h1>
          
          <form action="LogIn" method="post" onSubmit="return validateL()">
          
            <div class="field-wrap">
            	<input type="email" id="Uname" name="Uname" placeholder="Email Address*" required autocomplete="off"/>
          	</div>
          
          	<div class="field-wrap">
            	<input type="password" id="Password" name="Password" placeholder="Password*" required autocomplete="off"/>
          	</div>
          
          	<p class="forgot"><a href="#" data-target="#pwdModal" data-toggle="modal">Forgot Password?</a></p>
          
          	<button class="button button-block"/>Log In</button>
          
          </form>

        </div>
        
      </div><!-- tab-content -->
      
	</div> <!-- /form -->


	<!--Forgot Passoword Begins-->
	<div id="pwdModal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
	  <div class="modal-dialog">
	  <div class="modal-content">
	      <div class="modal-header" style="border: none;">
	          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	          <h1 class="text-center">What's My Password?</h1>
	      </div>
	      <div class="modal-body">
	          <div class="col-md-12">
	                <div class="panel panel-default" style="border: none;">
	                    <div class="panel-body">
	                        <div class="text-center">  
	                          <p>Forgot Your Password ! You Can Reset It Here.</p>
	                            <div class="panel-body">
	                                <fieldset  style="border: none;">
	                                <form action="SendEmail" method="POST">
	                                    <input name="email1" id="Email1" class="form-control input-lg" placeholder="E-mail Address" type="email">
	                                   
	                                    <input class="btn btn-lg btn-primary btn-block" value="Send My Password" type="submit">
	                                </form>
	                                </fieldset>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	            </div>
	      </div>
	      <div class="modal-footer">	      	  
	          <div class="col-lg-12">
	          <button class="btn btn-danger" data-dismiss="modal" aria-hidden="true">Cancel</button>
			  </div>	
	      </div>
	  </div>
	  </div>
	</div>	


	<!--Forgot Passoword Ends-->

	 <script src="https://code.jquery.com/jquery-2.2.4.js"></script>
	 <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
     <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
     <script src="js/index.js"></script>
	 <script type="text/javascript">
		function validate(){

			var uname=document.getElementById("txt_uname");
			var email=document.getElementById("txt_email");
			var mno=document.getElementById("txt_mno");
			var pass=document.getElementById("pass");
			var pass1=document.getElementById("pass1");
			
			if(uname.value=="" || email.value=="" || mno.value=="" || pass.value=="" || pass1.value=="")
			{
				alert(""+uname.value+pass1.value+email.value+mno.value+pass.value);
				return false;
			}
			else if(pass.value.length<8 || pass.value.length>25)
			{
				alert("Password must be upto 8-25 characters");
				return false;
			}
			else if(uname.value.length>25)
			{
				alert("Uname must be upto 25 characters (only special symbol '_' allowed)");
				return false;
			}
			else if(email.value.length>25)
			{
				alert("Email Id must be upto 25 characters");
				return false;
			}
			else if(mno.value.length!=10)
			{
				alert("Mobile Number must be of 10 digits");
				return false;
			}
			else if(pass.value!=pass1.value)
			{
				alert("Password Must Match");
				return false;
			}
			else if(/^\w+([\.-]?\ w+)*@\w+([\.-]?\ w+)*(\.\w{2,3})+$/.test(email.value)==false)
			{
				alert("Invalid Email Id");
				return false;
			}
			else
			{
				var str=mno.value;
				var i;
				for(i=0;i<str.length;i++)
				{
					if(str[i]>'9' || str[i]<'0')
					{
						alert("Mobile Number must contain digits only"+str[i]);
						return false;
					}
					return true;
					
				}
				
			}
			return true;
		}
	</script>
	
	<script type="text/javascript">
		var uname=document.getElementById("Uname");
		var pass=document.getElementById("Password");
		
		function validateL(){
			if(uname.value=="" || pass.value=="")
			{
				alert("Please Enter all fields");
				return false;
			}
			else if(/^\w+([\.-]?\ w+)*@\w+([\.-]?\ w+)*(\.\w{2,3})+$/.test(uname.value)==false)
			{
				alert("Invalid Email Id");
				return false;
			}
			return true;	
		}
		function modalData(){
			var email=document.getElementById("Email1");
			
		}
	</script>
    
    
    
  </body>
</html>
