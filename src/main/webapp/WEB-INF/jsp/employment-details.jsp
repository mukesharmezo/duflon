<%@page import="com.armezo.duflon.Entities.ParticipantRegistration"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page import = "java.util.ResourceBundle" %>
<%
try
    {
	ResourceBundle resource = ResourceBundle.getBundle("application");
String baseServer = resource.getString("client.url");String title = resource.getString("app.title");
String role="";
if(session.getAttribute("role") != null){
	role = session.getAttribute("role").toString().trim();

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
    
    <style>
       
	  ul li{margin: 0px !important;}
.form-btn{width: 100% !important;}

		#div_msg{width: 290px;height: 18px;font-weight: 300;font-size: 12px; font-family:Roboto, sans-serif;white-space: nowrap;cursor: pointer; text-overflow: ellipsis !important;overflow: hidden;}
		/* #div_msg:hover{overflow: visible; white-space: normal;height:auto;} */
		#div_msg:hover{position: absolute;width: auto;overflow: visible; white-space: normal;height:fit-content;display: inline-block;left: 0px;top:45px;padding: 5px;background-color: #D3D3D3;color: #000;}
   </style>

    <script src="./js/jquery-3.4.1.min.js"></script>
    <script src="./js/jquery.validate.js"></script>
    <script src="./js/empdetail.js"></script>
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
        <h1>Employment Details</h1>
        <div class="container-1100">
            <div class="profile-container">
             <%@include file="./header/profileMenu.jsp"%>

              <div class="profile-content">
                <form:form class="form" action="./saveEmploymentDetails"  method = "post" id = "testForm" modelAttribute="emp">
                  <div class="form-section">
					<input type = "hidden" name = "accessKey" id = "accessKey" value = "${emp.accessKey}" placeholder="Profile"/>
                    <div class="form-block">
                      <h5>Joining Date <span></span></h5>
                      <form:input type="text"  path="joiningDate" style=" background : #D3D3D3" readonly="true" placeholder="Joining Date" />
                    </div>
                    <div class="form-block">
                        <h5>Emp Salary (Per Month) <span>*</span></h5>
                        <form:input type="text" path="empSalary" maxlength="55"  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" placeholder="Emp Salary (Per Month) "/>
                    </div>
                    <div class="form-block">
                      <h5>Gender <span>*</span></h5>
                      <form:select  path="gender" style="color: black !important">
                       <form:option value = "" label="Select" />
                       <c:forEach items="${gender }" var="gender">
                         <c:choose>
                                   <c:when test="${gender  eq emp.gender}">
                                     <form:option value = "${gender.listCode}" label="${gender.listDesc}"  selected="selected"/>
                                   </c:when>
                                 <c:otherwise>
                                      <form:option value = "${gender.listCode}" label="${gender.listDesc}"/>
                                 </c:otherwise>
                       </c:choose>
                       </c:forEach>
                      </form:select>
                    </div>
                    <div class="form-block">
                        <h5>PF Number<span>*</span></h5>
                        <form:input type="text" path="pfNumber" maxlength="55"  placeholder="PF Number" />
                    </div>
                    <div class="form-block">
                        <h5>UAN<span>*</span></h5>
                        <form:input type="text" path="uan" maxlength="12"  placeholder="UAN" />
                    </div>
                    <div class="form-block">
                        <h5>EPFO<span>*</span></h5>
                        <form:input type="text" path="epfo" maxlength="25"  placeholder="EPFO" />
                    </div>
                    <div class="form-block">
      					<h5>Bank Name<span>*</span></h5>
      					<form:input path="bankName" id="bankName" list="bankSuggestions" placeholder="Bank Name" cssClass="form-control" />
      					<datalist id="bankSuggestions">
        					<option value="Axis Bank">
        					<option value="Bank of Baroda (BoB)">
        					<option value="Bank of India (BOI)">
        					<option value="Canara Bank">
        					<option value="HDFC Bank">
        					<option value="ICICI Bank">
        					<option value="IndusInd Bank">
        					<option value="Punjab National Bank (PNB)">
        					<option value="State Bank of India (SBI)">
        					<option value="Union Bank of India (UBI)">
      					</datalist>
    				</div>
							<div class="form-block">
                        <h5>IFSC Code<span>*</span></h5>
                        <form:input type="text" path="ifscCode" maxlength="11"  placeholder="IFSC Code" />
                    </div>
                    <div class="form-block">
                        <h5>Bank A/C Number<span>*</span></h5>
                        <form:input type="text" path="bankAccountNumber" maxlength="20" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"   placeholder="Bank A/C number" />
                    </div>
                     <%if(role.equalsIgnoreCase("HRE")) { %>
                  <div class="form-btn">
                     <c:if test="${(emp.hiredStatus != 'Y') && emp.status !='H'}">
					   <input class="btn blue-btn" type="button" value="Save" id="submitbtn"/>
<!-- 					   <input class="btn blue-btn" type="button" value="Save" id="submitbtn" onclick="saveEployment('Save')"/> -->
                         <input class="btn blue-btn" type="submit" value="Next" id="submitnext"/>
                     </c:if>
                  </div>
                  <%} %>
				 
                </div>
				 <input type="hidden" id="btn" value="" name="btnSave">
            </form:form>
                 </div>
                
            </div>
        </div>
        
    </div>
	<div class="blk-bg"></div>
     <input type="hidden" id="accesskey" value="${emp.accessKey}">
    <script>
      $(document).ready(function () {
	      joiningDate();
    	  <%if(role.equalsIgnoreCase("LM") || role.equalsIgnoreCase("SA") || role.equalsIgnoreCase("HOD")) { %>
    	  $('input').attr('disabled', 'disabled');
    	  $('select').attr('disabled', 'disabled');
    	  <%}%>
        $('#tabs').scrollTabs();
		
		var profile = document.getElementById("profile");
		var employment_details = document.getElementById("employment_details");
		
		profile.className -= 'tab-btn tab_selected scroll_tab_first';
        employment_details.className += 'tab-btn tab_selected scroll_tab_first';
      });
	   function saveEployment(save){
			$("#btn").val(save);
			document.forms[0].action="saveEmploymentDetails";
			document.forms[0].method="post";
			document.forms[0].submit();
		}

      function joiningDate(){
    	  var today = new Date().toISOString().split('T')[0];
    	  document.getElementsByName("joiningDate")[0].setAttribute('min', today);
      }
    </script>
  </body>
</html>

<%}else{
	 response.sendRedirect("login");
}

 }catch(Exception e)
    {
    	 System.out.println("Errror....."+e);
    	  response.sendRedirect("login");
    }%>

