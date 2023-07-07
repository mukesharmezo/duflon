<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="com.armezo.duflon.Entities.ParticipantRegistration"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page import="java.util.ResourceBundle"%>

<%
try {
	String msg = "";
	ResourceBundle resource = ResourceBundle.getBundle("application");
	String baseServer = resource.getString("client.url");String title = resource.getString("app.title");
	String role = "";
	if (session.getAttribute("role") != null) {
		role = session.getAttribute("role").toString().trim();

		if (session.getAttribute("emp_msg") != null) {
	msg = session.getAttribute("emp_msg").toString();
		}
		session.removeAttribute("emp_msg");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="icon" type="image/x-icon" href="<%=baseServer%>img/DuflonFavicon.png"/>
	<title><%=title %></title>
<link rel="stylesheet" type="text/css" href="./css/common.css" />
<link rel="stylesheet" type="text/css" href="./css/profile.css" />
<link rel="stylesheet" href="./css/scrolltabs.css">
<link rel="stylesheet" type="text/css" href="./css/style.css" />
<link rel="stylesheet" type="text/css" href="./css/sweetalert.css" />
<script type="text/javascript" src="./js/sweetalert.min.js"></script>
<style>
ul li {
	margin: 0 !important;
}

.form-btn {
	width: 100% !important;
}

#div_emp {
	color: #f00;
	width: 290px;
	height: 18px;
	font-weight: 300;
	font-size: 12px;
	font-family: Roboto, sans-serif;
	white-space: pointer;
	text-overflow: ellipsis !important;
	overflow: hidden;
}
</style>
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
		<h1>Personal Details</h1>
		<div class="container-1100">
			<div class="profile-container">
				<%@include file="./header/profileMenu.jsp"%>

				<div class="profile-content">
					<form:form class="form" action="./savePersonalDetails"
						method="post" id="testForm" modelAttribute="personal">
						<form:input type="hidden" path="accessKey"
							placeholder="Dealer Code" />
						<div class="form-section">
							<div class="form-block">
								<h5>
									Title <span>*</span>
								</h5>
								<form:select path="title" style="color: black !important">
									<form:option value="" label="Select" />
									<c:forEach items="${title }" var="title">
										<c:choose>
											<c:when test="${title.listCode  eq personal.title } ">
												<form:option value="${title.listCode}"
													label="${title.listDesc}" selected="selected" />
											</c:when>
											<c:otherwise>
												<form:option value="${title.listCode}"
													label="${title.listDesc}" />
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</form:select>
							</div>
							<div class="form-block">
								<h5>
									First Name <span>*</span>
								</h5>
								<form:input type="text" path="firstName"
									placeholder="First Name" />
							</div>
							<div class="form-block">
								<h5>Middle Name</h5>
								<form:input type="text" path="middleName"
									placeholder="Middle Name" />
							</div>
							<div class="form-block">
								<h5>
									Last Name <span>*</span>
								</h5>
								<form:input type="text" path="lastName" placeholder="Last Name" />
							</div>
							<div class="form-block">
								<h5>
									Pin Code <span>*</span>
								</h5>
								<form:input type="text" path="pin" list="pincodeList"
									placeholder="Pin Code" maxlength="6" id="pincode"
									oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" />
							</div>
							<div class="form-block">
								<h5>
									Address <span>*</span>
								</h5>
								<form:input type="text" path="address" placeholder="Address" />
							</div>
							<div class="form-block">
								<h5>
									State <span>*</span>
								</h5>
								<form:input type="text" path="state" placeholder="State" />
							</div>
							<div class="form-block">
								<h5>
									City <span>*</span>
								</h5>
								<form:input type="text" path="city" placeholder="City" />
							</div>
						
							<div class="form-block">
								<h5>
									ID Proof <span>*</span>
								</h5>
								<form:select path="idProof" id="idProof"
									style="color: black !important" onchange="getDL()">
									<form:option value="" label="Select" />
									<c:forEach items="${ID}" var="id">
										<c:choose>
											<c:when test="${id.listCode  eq personal.idProof } ">
												<form:option value="${id.listCode}" label="${id.listDesc}"
													selected="selected" />
											</c:when>
											<c:otherwise>
												<form:option value="${id.listCode}" label="${id.listDesc}" />
											</c:otherwise>
										</c:choose>

									</c:forEach>
								</form:select>
							</div>
							<div class="form-block">
								<h5>
									Date of Birth<span>*</span>
								</h5>
								<form:input type="date" id="date" path="birthDate"
									placeholder="Date of Birth" />
							</div>
							<div class="form-block">
								<h5>
									Mobile <span>*</span>
								</h5>
								<form:input type="text" maxlength="10" placeholder="Mobile"
									oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
									path="mobile" />
							</div>

							<div class="form-block">
								<h5>
									Alternate/Personal Contact Number <span>*</span>
								</h5>
								<form:input type="text" id="alt_co_no" maxlength="10"
									placeholder="Alternate/Personal Contact Number"
									onkeyup="alternateCo()"
									oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
									path="alternateContactNumber" />
								<!-- <br><span id="alt_no" style="display:none;color: #f00; margin-top: 5px;bottom: -20px;font-weight: 500;
                                font-size: 12px">Please enter your alternateContactNumber</span> -->
							</div>
							<div class="form-block">
								<h5>
									Email <span>*</span>
								</h5>
								<form:input type="email" path="email" placeholder="Email" />
							</div>
							<div class="form-block">
								<h5>
									UID/Aadhaar Number <span>*</span>
								</h5>
								<form:input type="text" maxlength="12"
									placeholder="UID/Aadhaar Number"
									oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
									path="adharNumber" />
							</div>
							<div class="form-block">
								<h5>
									Highest Qualification <span>*</span>
								</h5>
								<form:select path="highestQualification" id="ql"
									style="color: black !important">
									<form:option value="" label="Select" />
									<c:forEach items="${educations}" var="education">
											<option value="${education}"
												${education == personal.highestQualification ? 'selected' : '' }>${education}</option>
									</c:forEach>
								</form:select>
							</div>
							<div class="form-block">
								<h5>
									Primary Language <span>*</span>
								</h5>
								<form:select path="primaryLanguage" id="primery_lg"
									style="color: black !important">
									<form:option value="" label="Select" />
									<c:forEach items="${language}" var="language">
										<c:choose>
											<c:when test="${language  eq personal.primaryLanguage}">
												<form:option value="${language.listCode}"
													label="${language.listDesc}" selected="selected" />
											</c:when>
											<c:otherwise>
												<form:option value="${language.listCode}"
													label="${language.listDesc}" />
											</c:otherwise>
										</c:choose>

									</c:forEach>
								</form:select>
							</div>
							<div class="form-block">
								<h5>
									Secondary Language <span>*</span>
								</h5>
								<form:select path="secondaryLanguage" id="secondary_lg"
									style="color: black !important">
									<form:option value="" label="Select" />
									<c:forEach items="${language}" var="language">
										<c:choose>
											<c:when
												test="${language.listCode  eq personal.secondaryLanguage}">
												<form:option value="${language.listCode }"
													label="${language.listDesc}" selected="selected" />
											</c:when>
											<c:otherwise>
												<form:option value="${language.listCode}"
													label="${language.listDesc}" />
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</form:select>
							</div>
							<c:if
								test="${(personal.hiredStatus != 'Y') && personal.status !='H'}">
								<%
								if (role.equalsIgnoreCase("HRE")) {
								%>
								<div class="form-btn">
									<input class="btn blue-btn" type="button" value="Save"
										id="submitbtn" onclick="savePersonal('save')" /> <input
										class="btn blue-btn" type="submit" value="Next"
										id="submitnext" onclick="save('next')" /> <input
										type="hidden" value="" id="btn_next" name="btnValue" />
								</div>
								<%
								}
								%>
							</c:if>
						</div>
					</form:form>
				</div>
			</div>
			<form>
				<input type="hidden" name="" id="accesskey"
					value="${personal.accessKey}"> <input type="hidden"
					id="designation_selse" value="${personal.designation}"> <input
					type="hidden" id="mobile" value="${personal.mobile}"> <input
					type="hidden" id="locationCode" value="${locationCode}"> <input
					type="hidden" id="tehshil1" value="${personal.tehsil}"> <input
					type="hidden" id=hreId value="${personal.hreId}">

			</form>
			<div class="blk-bg"></div>
			<script
				src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/jquery.validate.min.js"></script>
			<script type="text/javascript" src="./js/personalDetail.js"></script>
			<script>
      $(document).ready(function () {
    	  $('#div_emp').hide();
		   $('#pincode').on('input', function() {
	            var pincode = $(this).val();
	            
	            if (pincode.length === 6) {
	                $.ajax({
	                    url: 'pincode/' + pincode,
	                    type: 'POST',
	                    success: function(response) {
	                        // Update state field
	                        $('#state').val(response.state);

	                        // Update district field
	                        $('#city').val(response.district);
	                    },
	                    error: function() {
	                        console.log('Wrong pincode.');
	                    }
	                });
	            }
	        });
		   
		   
		   //validityOfLicence();
		   
	     
    	  <%if (role.equalsIgnoreCase("LM") || role.equalsIgnoreCase("SA") || role.equalsIgnoreCase("HOD")) {%>
    	  $('input').attr('disabled', 'disabled');
    	  $('select').attr('disabled', 'disabled');
    	  <%}%>
        $('#tabs').scrollTabs();
		
		
		var profile = document.getElementById("profile");
		var personal_details = document.getElementById("personal_details");
		
	    profile.className -= 'tab-btn tab_selected scroll_tab_first';
        personal_details.className += 'tab-btn tab_selected scroll_tab_first';
		
		
      });
	   function alternateCo(){
		 var altCo=   $("#alt_co_no").val();
		 var mobile = $("#mobile").val();
		 if(altCo == mobile){
			showMSG("Alternate number cannot be same as primary number") ;
			$("#alt_co_no").val("");
		 }
		
	   }
	   
	   function showMSG(msg){
		 
		  swal({   
				  title: msg,     
				  showCancelButton: false,
				  confirmButtonColor: "#DC3545",   
				  confirmButtonText: "OK",   
				  closeOnConfirm: true },
				  function(isConfirm){			  
					  return false; 
				}); 
	 }
	   $(function(){
    	    var dtToday = new Date();
    	    
    	    var month = dtToday.getMonth()+1;
    	    var day = dtToday.getDate();
    	    var year = dtToday.getFullYear()-18;
    	    console.log('Month value :: '+month);
    	    if(month < 10)
    	        month = '0' + month.toString();
    	    if(day < 10)
    	        day = '0' + day.toString();
    	    if(month ==0)
    	    month = '01';
    	    var maxDate = year + '-' + month + '-' + day;
    	    // or instead:
    	    // var maxDate = dtToday.toISOString().substr(0, 10);
    	    $('#date').attr('max', maxDate);
    	    
    	    
    	});
		 function save(next){
       $("#btn_next").val(next);
      }
	  
		
		function savePersonal(next)
		{
						
			 $("#btn_next").val(next);
			document.forms[0].action="savePersonalDetails";
			document.forms[0].method="post";
			document.forms[0].submit();
		}
		
		<%if (msg.length() > 0) {%>
		$('#div_emp').show();
		$('#div_emp').text('');
		$('#div_emp').append('<%=msg%>
				');
			<%}%>
				
			</script>
		</div>
	</div>
</body>
</html>
<%
System.out.println("msg............." + msg);
} else {
response.sendRedirect("login");
}
} catch (Exception e) {
System.out.println("Errror....." + e);
response.sendRedirect("login");
}
%>
