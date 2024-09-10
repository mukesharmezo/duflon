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
		 String color="";
		    if(session.getAttribute("msg") != null){
		  	  msg = (String)session.getAttribute("msg");
		  	  session.removeAttribute("msg");
		  
		    }
		    if(msg == "1"){
		    	  msg="City already exists.";
		    		color="red";
		    	}
		    
		    if(msg == "0"){
		    	  msg="City added successfully.";
		    	  color="green";
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
function getState(){
	var region=$("#region").val();
	$.ajax({
         url: 'state',
         type: 'POST',
         data: 'region='+region,
         success:function(res){
        	 console.log(res);
        	 $('#state')
        	 .find('option')
     	    .remove()
     	    .end()
     	    .append(res);
    	  },
          error:function(ress){
        	  alert(ress);
    	  }
			}); 
}

function save() {   
	  var state       =  $("#state").val();
	  var city        =  $("#city").val();	  
	  var region      =  $("#region").val();
	  
		if (region == "") {
			showMSG("Enter region");    	
	          return false;
	      }
		if (state == "") {
			showMSG("Enter state");    	
	          return false;
	      }
		if (city == "") {
			showMSG("Enter city");    	
	          return false;
	      }
		
		document.forms[0].action="addCityPro";
		document.forms[0].method="post";
		document.forms[0].submit(); 
	 
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
		<h1>Add HR</h1>
		<div class="container-1100">
			<div class="profile-container">
				<div class="profile-content">
					<form class="form">
						<div class="form-section">
							<div class="form-block">
								<h5>Region</h5>
								<select name="regionCode" id="region" onchange="getState()">
								<option value="">Select</option>
								<c:forEach items="${region}" var="region">
								<option value="${region.regionCode }">${region.regionCode}</option>
								</c:forEach>
								</select>
							</div>
							<div class="form-block">
								<h5>State</h5>
								<select name="stateCode" id="state" onchange="getCity()">
								<option value="">Select</option>
								</select>
							</div>
							<div class="form-block">
								<h5>City</h5>
								<input type="text" name="cityName" id="city"
									maxlength="50"  placeholder="City Name" />
							</div>
							
						</div>
						<div class="form-btn">
							<input class="btn blue-btn" type="button" value="Submit"
								onclick="save()" />
						</div>


					</form>
					 <span style="color:<%=color%>;">
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

