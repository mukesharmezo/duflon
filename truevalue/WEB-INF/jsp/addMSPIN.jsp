<%@page import="com.msil.irecruit.Entities.ParticipantRegistration"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page import="java.util.ResourceBundle"%>
<%
	try {
		ResourceBundle resource = ResourceBundle.getBundle("application");
		String baseServer = resource.getString("client.url");
		String role = "";
		 String msg ="";  
		    if(session.getAttribute("msg") != null){
		  	  msg = (String)session.getAttribute("msg");
		  	  session.removeAttribute("msg");
		    }
		    if(msg == "D"){
		    	  msg="MSPIN already exists.";
		    	}
		    
		    if(msg == "S"){
		    	  msg="HRM added successfully.";
		    	}
			
		//if(session.getAttribute("role") != null){
		//role = session.getAttribute("role").toString().trim();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="icon" type="image/x-icon"
	href="<%=baseServer%>img/iRecruit-favicon.ico" />
<title>iRecruit</title>
<link rel="stylesheet" type="text/css" href="./css/common.css" />
<link rel="stylesheet" type="text/css" href="./css/profile.css" />
<link rel="stylesheet" href="./css/scrolltabs.css">
<link rel="stylesheet" type="text/css" href="./css/style.css" />
<style>
ul li {
	margin: 0px !important;
}

.form-btn {
	width: 100% !important;
}

#div_msg {
	width: 290px;
	height: 18px;
	font-weight: 300;
	font-size: 12px;
	font-family: Roboto, sans-serif;
	white-space: nowrap;
	cursor: pointer;
	text-overflow: ellipsis !important;
	overflow: hidden;
}
/* #div_msg:hover{overflow: visible; white-space: normal;height:auto;} */
#div_msg:hover {
	position: absolute;
	width: auto;
	overflow: visible;
	white-space: normal;
	height: fit-content;
	display: inline-block;
	left: 0px;
	top: 45px;
	padding: 5px;
	background-color: #D3D3D3;
	color: #000;
}
</style>
<script type="text/javascript">
  function save() {
	  var name     =  $("#name").val();
	  var mobile     =  $("#mobile").val();
	  var mspin     =  $("#new_mspin").val();
	  var email     =  $("#email").val();
		if (name == "") {
			 swal({   
					title: "Enter HRM Name name ",     
					showCancelButton: false,
					confirmButtonColor: "#2d3393",   
					confirmButtonText: "OK",   
					closeOnConfirm: true },
					function(isConfirm){
						 return false;
					});	
	          return false;
	      }
		if (mobile == "") {
			 swal({   
					title: "Enter mobile  number",     
					showCancelButton: false,
					confirmButtonColor: "#2d3393",   
					confirmButtonText: "OK",   
					closeOnConfirm: true },
					function(isConfirm){
						 return false;
					});	
	          return false;
	      }
		
		

		if (mspin == "") {
			 swal({   
					title: "Enter MSPIN",     
					showCancelButton: false,
					confirmButtonColor: "#2d3393",   
					confirmButtonText: "OK",   
					closeOnConfirm: true },
					function(isConfirm){
						 return false;
					});	
	          return false;
	      }
		document.forms[0].action="addDealerPro";
		document.forms[0].method="post";
		document.forms[0].submit(); 
	 
	} 
  function validateEmail(email) 
	 {
	     var re = /\S+@\S+\.\S+/;
	     return re.test(email);
	 }
 </script>
<script src="./js/jquery-3.4.1.min.js"></script>
<script src="./js/jquery.dataTables.min.js"></script>
<script src="./js/jquery.scrolltabs.js"></script>
</head>
<body>
	<div class="left-panel-include">
		<%@include file="./header/left-panel.jsp"%>
	</div>
	<div class="user-panel-include">
		<%@include file="./header/user-panel.jsp"%>
	</div>

	<div class="right-section">
		<h1>Add MSPIN</h1>
		<div class="container-1100">
			<div class="profile-container">
				<div class="profile-content">
					<form class="form">
						<div class="form-section">
							<div class="form-block">
								<h5>HR Name</h5>
								<input type="text" name="name" id="name"
									placeholder="HRM Name" />
							</div>
							<div class="form-block">
								<h5>Mobile No</h5>
								<input type="text" name="mobile" id="mobile"
									maxlength="10" 
							oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" placeholder="Mobile No" />
							</div>
							<div class="form-block">
								<h5>Email ID</h5>
								<input type="text" name="email" id="email"
									maxlength="50"  placeholder="Email ID" />
							</div>
							<div class="form-block">
								<h5>MSPIN</h5>
								<input type="text" name="mspin" id="new_mspin" placeholder="MSPIN" 
								 maxlength="10" 
							     oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/>
							</div>
						</div>
						<div class="form-btn">
							<input class="btn blue-btn" type="button" value="Submit"
								onclick="save()" />
						</div>


					</form>
					 <span style="color:green;">
						       	<strong><%=msg %></strong>							
						</span>
				</div>

			</div>
		</div>

	</div>
	<div class="blk-bg"></div>


</body>
</html>

<%
	//}else{
		// response.sendRedirect("login");
		//}

	} catch (Exception e) {
		System.out.println("Errror....." + e);
		response.sendRedirect("login");
	}
%>

