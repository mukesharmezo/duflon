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
	String baseServer = resource.getString("client.url");
	String title = resource.getString("app.title");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="icon" type="image/x-icon" href="<%=baseServer%>img/DuflonFavicon.png"/>
	<title><%=title %></title>
<link rel="stylesheet" type="text/css" href="./css/registration/durecruit-common.css" />
<link rel="stylesheet" type="text/css" href="./css/registration/durecruit-profile.css" />
<link rel="stylesheet" type="text/css" href="./css/registration/durecruit-scrolltabs.css" />

<script src="./js/jquery-3.4.1.min.js"></script>
<script src="./js/jquery.scrolltabs.js"></script>
</head>

	<div class="right-section left-moved">
		<h1>Personal Details</h1>
		<div class="container-1100">
			<div class="profile-container">
				<%@include file="./header/profileMenuPart.jsp"%>

				<div class="profile-content">
					<form:form class="form" action="./savePersonalDetails"
						method="post" id="testForm" modelAttribute="personal">
						<form:input type="hidden" path="accessKey" />
						<form:input type="hidden" path="userType" value="Part"/>
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
									Gender <span>*</span>
								</h5>
								<form:select path="gender" style="color: black !important">
									<form:option value="" label="Select" />
									<c:forEach items="${gender }" var="gender">
										<c:choose>
											<c:when test="${gender  eq emp.gender}">
												<form:option value="${gender.listCode}"
													label="${gender.listDesc}" selected="selected" />
											</c:when>
											<c:otherwise>
												<form:option value="${gender.listCode}"
													label="${gender.listDesc}" />
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</form:select>
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
									style="color: black !important">
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
									placeholder="Date of Birth" style="color: black !important" />
							</div>
							<div class="form-block">
								<h5>
									Mobile <span>*</span>
								</h5>
								<form:input type="text" maxlength="15" placeholder="Mobile" 	path="mobile" />
							</div>

							<div class="form-block">
								<h5>
									Alternate/Personal Contact Number <span>*</span>
								</h5>
								<form:input type="text" id="alt_co_no" maxlength="15"
									placeholder="Alternate/Personal Contact Number"
									oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
									path="alternateContactNumber" />
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
								
								<div class="form-btn">
									<input class="btn blue-btn" type="button" value="Save" id="submitbtn" />
									<input class="btn blue-btn" type="submit" value="Next" id="submitnext" />
									<input type="hidden" value="" id="btn_next" name="btnValue" />
								</div>
								
							</c:if>
						</div>
					</form:form>
				</div>
			</div>
			<form>
				<input type="hidden" name="" id="accesskey"
					value="${personal.accessKey}"> <input type="hidden"
					id="designation_selse" value="${personal.designation}"> <input
					type="hidden" id="mobile2" value="${personal.mobile}"> <input
					type="hidden" id="locationCode" value="${locationCode}"> <input
					type="hidden" id="tehshil1" value="${personal.tehsil}"> <input
					type="hidden" id=hreId value="${personal.hreId}">

			</form>
			<div class="blk-bg"></div>
			<script src="./js/jquery.validate.js"></script>
			<script type="text/javascript" src="./js/personal.js"></script>
			<script>
      $(document).ready(function () {
    	  
    	  $('#firstName, #middleName, #lastName').keydown(function(e) {
      		var keyCode = e.keyCode || e.which;
      		if (keyCode === 32) { 
        			e.preventDefault(); 
        			$(this).closest('.form-block').next().find('input').focus(); //Move focus to the next fields box
      		}
      		if (keyCode === 8) {
                return;
            }
      		if (keyCode >= 96 && keyCode <= 105) {
                e.preventDefault();
            }
            var pattern = /[a-zA-Z\s]/;
            if (!pattern.test(String.fromCharCode(keyCode))) {
                e.preventDefault();
            }
    		});
    	  
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
		   
	    
        $('#tabs').scrollTabs();
		
		
      });
	   
	   $(function(){
    	    var dtToday = new Date();
    	    var month = dtToday.getMonth()+1;
    	    var day = dtToday.getDate();
    	    var year = dtToday.getFullYear()-18;
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
			</script>
		</div>
	</div>
</body>
</html>
<%
System.out.println("msg............." + msg);
} catch (Exception e) {
System.out.println("Errror....." + e);
response.sendRedirect("login");
}
%>
