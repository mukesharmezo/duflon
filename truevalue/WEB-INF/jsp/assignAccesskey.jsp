<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import = "java.util.ResourceBundle" %>

<%
try
    {
	ResourceBundle resource = ResourceBundle.getBundle("application");
String baseServer = resource.getString("client.url");
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="icon" type="image/x-icon" href="<%=baseServer%>img/iRecruit-favicon.ico"/>
<title>Insert title here</title>
<link href="/assets/css/bootstrap.min.css" rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link
	href="http://netdna.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.css"
	rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
	<style type="text/css">
body {
	background-color: FFF;
}

.signup-form {
	width: 400px;
	margin: 0 auto;
	padding: 30px 0;
}

.signup-form h4 {
	color: #0b4072;
	margin: 0 0 15px;
	position: relative;
	text-align: center;
}

.signup-form h4:before, .signup-form h4:after {
	content: "";
	height: 1px;
	width: 15%;
	background: #1657a2;
	position: absolute;
	top: 50%;
	z-index: 2;
}

.signup-form h4:before {
	left: 0;
}

.signup-form h4:after {
	right: 0;
}

.signup-form form {
	border-radius: 3px;
	background: #e4e4e4;
	padding: 30px;
	background-image: linear-gradient(#ffffff, #01509e);
	border-bottom-left-radius: 100% 20%;
	border-bottom-right-radius: 100% 20%;
	box-shadow: 0 21px 24px -16px #000;
}

input.btn-sign-up {
	padding: 6px 10px;
	border-radius: 4px;
	border: 0px solid;
	box-shadow: 0px 3px 3px #000;
}

.modal-header {
	padding: 70px 15px;
	height: 210px;
}

.modal-dialog.modal-report {
	margin: 200px auto;
}

.modal {
  display: none; /* Hidden by default */
  position: fixed; /* Stay in place */
  z-index: 1; /* Sit on top */
  padding-top: 100px; /* Location of the box */
  left: 0;
  top: 0;
  width: 100%; /* Full width */
  height: 100%; /* Full height */
  overflow: auto; /* Enable scroll if needed */
  background-color: rgb(0,0,0); /* Fallback color */
  background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}

/* Modal Content */
.modal-content {
  background-color: #fefefe;
  margin: auto;
  padding: 20px;
  border: 1px solid #888;
  width: 80%;
}

/* The Close Button */
.close {
  color: #aaaaaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: #000;
  text-decoration: none;
  cursor: pointer;
}
</style>
<script type="text/javascript">
		function fncRegisterAndSendEmail()
		{
			
			
			
			 var accesskey = $('#accesskey').val();
			var fName = $('#fName').val();
			var  mName =  $('#mName').val();
			var lName = $('#lName').val();
			
			var email = $('#email').val();
			var mobile = $('#mobile').val();
			var designation = $('#designation').val(); 
			
			var midName = ""; 
			
                     if(status == "B"){
                    	 alet("This candidate  is blocked");
                    	 return;
                     }
					if(fName=="")
						{  
							alert("Please enter the first name.");
							fName.focus();
							return;
						}
						
						
						if(email=="")
						{
							alert("Please enter the email.");
							email.focus();
							return;
						}
						
						 if (!validateEmail(email)) {
							 alert("Please enter a valid email address");
					            return false;
					        }
						 
						 var tempcc = email.split(",");
						 
						 if(tempcc.length>1)
							{
							 alert("Please enter only one email.");
							}
						
						if( mobile.length>0){
						if(mobile=="" || mobile.length<10)
						{
							alert("Please Enter Valid Mobile No.");
							mobile.focus();
							return;
						}
		                }
						var modal = document.getElementById("myModal");
		          
								   document.forms[0].sendmail.value = "Please wait...";					
							    	document.forms[0].sendmail.disabled = true;
							    	document.forms[0].close.disabled = true;
									$.ajax({
									         url: 'assignAccesskeyPro',
									         type:'post',
									         data:'accesskey='+accesskey+'&firstName='+fName+'&lastName='+lName+'&email='+email+'&mobile='+mobile+'&designation='+designation+"&middleName="+mName,
									         success:function(res){
									        	  
									        	/// $('#tempAccesskey').val(res); 
									        		// $("#p1").append("<br><br>"+res);
									        		
									        	// modal.style.display = "block";
									        	 alert(res);
									        	 window.opener.location.reload();  
													window.close();
									    	  },
									          error:function(ress){
									        	  alert(ress);
									        		 window.opener.location.reload();  
														window.close();
									    	  }
								  			}); 
	
		}
		function fncNum()
		{
			
			if((window.event.keyCode<47 || window.event.keyCode >57))
			{
			 window.event.keyCode = "0";
			}
		}
		
		 function validateEmail(email) 
		 {
		     var re = /\S+@\S+\.\S+/;
		     return re.test(email);
		 }

		 function sendEmail(){
			 
			 var tempAccesskey = $('#tempAccesskey').val();
			 $.ajax({
		         url: 'assignOldAccesskey',
		         type:'post',
		         data:'accesskey='+tempAccesskey,
		         success:function(res){
		        		 alert(res); 
		    	  },
		          error:function(ress){
		        	  alert(ress);
		        		 window.opener.location.reload();  
							window.close();
		    	  }
	  			}); 
		 }
	</script>
</head>
<body>
<div class="signup-form">
		<form class="login100-form validate-form">
			<h4>REGISTER CANDIDATE</h4>
			<div class="form-group">
				<div class="alert alert-info">
					
						<input type="hidden" name="accesskey" value="${accesskey }" id="accesskey">
				</div>
			</div>

			<div class="form-group">
				<input type="text" class="form-control" name="fName" placeholder="First Name" value="" required="required" id="fName">
			</div>
			<div class="form-group">
				<input type="text" class="form-control" name="mName" placeholder="Middle Name" value="" required="required" id="mName">
			</div>
			<div class="form-group">
				<input type="text" class="form-control" name="lName" placeholder="Last Name" value="" required="required" id="lName">
			</div>
			<div class="form-group">
				<input type="text" class="form-control" name="email" id="email" value="${candidate.email}" placeholder="E-Mail Id" required="required">
			</div>
			<div class="form-group">
				<input type="text" class="form-control" name="mobile" placeholder="Mobile Number"  value="${candidate.mobile}"maxlength="10" onkeypress="fncNum();" required="required" id="mobile">
			</div>
			
			<div class="form-group">
			   <select id="designation">
			   <option value="">Select Designation</option>
			   <c:forEach items="${designationList}" var="designation">
			   <option value="${designation.designationName}">${designation.designationName}</option>
			   </c:forEach>
			   </select>
			</div>

			<div class="row">
				<div class="col-sm-12 text-center">
					
					
					<input type="button" class="btn-primary btn-sign-up " name="sendmail" value="Submit" onclick="fncRegisterAndSendEmail()" data-toggle="modal" data-target="#confirm"> 
					<input type="button" class="btn-danger btn-sign-up" name="close" value=" Cancel " onclick="window.close();">

               
				</div>

				<div class="col-sm-12 text-center" style="color: #fff">
					<br>
					
				</div>
			</div>

		</form>
	</div>
	
	<div id="myModal" class="modal">

  <!-- Modal content -->
  <div class="modal-content">
    <input type="hidden" name="accesskey" value="" id="tempAccesskey">
    <p id="p1">The candidate has already part of recruitment process. His previous access key</p>
    <span onclick="sendEmail()">Yes</span>   <span>Now</span>
  </div>

</div>
</body>
</html>
<%
 }catch(Exception e)
    {
    	 System.out.println("Errror....."+e);
    	  response.sendRedirect("login");
    }%>