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
		    if(msg == "DN"){
		    	  msg="MSPIN not present";
		    }
		    
		    if(msg == "SN"){
		    	  msg="State not present";
		    }
		    if(msg == "CN"){
		    	  msg="City not present";
		    }
		    if(msg == "RN"){
		    	  msg="Region not present";
		    }
		    if(msg == "PN"){
		    	  msg="Parent dealer not present";
		    }
		    if(msg == "OP"){
		    	  msg="Dealer already maped other MSPIN";
		    }
		    
		    if(msg == "S"){
		    	  msg="Dealer added successfully";
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

function showMSG(msg){
	 swal({   
			title: msg,     
			showCancelButton: false,
			confirmButtonColor: "#2d3393",   
			confirmButtonText: "OK",   
			closeOnConfirm: true },
			function(isConfirm){
				 return false;
			});	
}

  function save() {   
	  var new_mspin   =  $("#new_mspin").val();
	  var outlet_name =  $("#outlet_name").val();
	  var outlet_code =  $("#outlet_code").val();
	  var region      =  $("#region").val();
	  var state       =  $("#state").val();
	  var city        =  $("#city").val();
	  
	  var location    =  $("#location").val();
	  var parent_dealer = $("#parent_dealer").val();
	  var map_code    =  $("#map_code").val();
	  
	  if(new_mspin == ""){
			showMSG("Enter MSPIN");    	
	          return false;	
		}
		if (outlet_name == "") {
			showMSG("Enter outlet name ") ;    
	          return false;
	      }
		if (outlet_code == "") {
			showMSG("Enter outlet code");	
	          return false;
	      }

               if (parent_dealer == "") {
			showMSG("Select parent dealer");    	
	          return false;
	      }

		if (region == "") {
			showMSG("Select region");    	
	          return false;
	      }
		
		
		if (state == "") {
			showMSG("Select state");    	
	          return false;
	      }
		if (city == "") {
			showMSG("Select city");    	
	          return false;
	      }
		if (location == "") {
			showMSG("Enter location");    	
	          return false;
	      }
		
		if (map_code == "") {
			showMSG("Enter dealer map code");    	
	          return false;
	      }
		
		document.forms[0].action="addOutletPro";
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
		<h1>Add Dealer/Outlet</h1>
		<div class="container-1100">
			<div class="profile-container">
				<div class="profile-content">
					<form class="form">
						<div class="form-section">
						
						
						<div class="form-block">
								<h5>MSPIN</h5>
								<input type="text" name="mspin" id="new_mspin" placeholder="Enter MSPIN" />
							</div>
							<div class="form-block">
								<h5>Dealer Name</h5>
								<input type="text" name="outletName" id="outlet_name"
									placeholder="Enter Dealer Name" />
							</div>
							
							<div class="form-block">
								<h5>Outlet Code</h5>
								<input type="text" name="outletCode" id="outlet_code" placeholder="Enter Outlet Code" />
							</div>							
							
							<div class="form-block">
								<h5>Parent Dealer </h5>
								<select name="parentDealerCode" id="parent_dealer">
								<option value="">Select</option>
								<c:forEach items="${parent_dealer}" var="parent_dealer">
								<option value="${parent_dealer.parentDealerCode }">${parent_dealer.parentDealerCode}</option>
								</c:forEach>
								</select>
							</div>
							
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
								<select name="State" id="state" onchange="getCity()">
								<option value="">Select</option>
								</select>
							</div>
							
							<div class="form-block">
								<h5>City</h5>
								<select name="cityName" id="city">
								<option value="">Select</option>
								</select>
							</div>
								<div class="form-block">
								<h5>Location</h5>
								<input type="text" name="location" id="location" placeholder="Enter Location" />
							</div>
							<div class="form-block">
								<h5>Map Code</h5>
								<input type="text" name="mapCode" id="map_code" placeholder="Enter Map Code" />
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

<script>

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

  function getCity(){
	  var stateCode=$("#state").val();
		$.ajax({
	         url: 'city',
	         type: 'POST',
	         data: 'stateCode='+stateCode,
	         success:function(res){
	        	 console.log(res);
	        	 $('#city')
	        	 .find('option')
	     	    .remove()
	     	    .end()
	     	    .append(res);
	    	  },
	          error:function(ress){
	    	  }
				}); 
  }
</script>
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

