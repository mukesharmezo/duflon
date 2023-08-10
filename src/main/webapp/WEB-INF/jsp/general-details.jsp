<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>   
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
	<link rel="icon" type="image/x-icon" href="<%=baseServer%>img/DuflonFavicon.png"/>  <title><%=title %></title>
    <link rel="stylesheet" type="text/css" href="./css/common.css" />
    <link rel="stylesheet" type="text/css" href="./css/profile.css" />
    <link rel="stylesheet" href="./css/scrolltabs.css">
    <link rel="stylesheet" type="text/css" href="./css/style.css" />
    <style>
       ul li {margin: 0 !important;}
.form-btn{width: 100% !important;}

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
        <h1>General Details</h1>
        <div class="container-1100">
            <div class="profile-container">
              <%@include file="./header/profileMenu.jsp"%>

              <div class="profile-content">
      
                <form  class="form" action="/saveGeneralDetails" method = "post" id = "testForm" modelAttribute="general">
                  <div class="form-section">
                    <div class="form-block">
                     <input type = "hidden" name = "accessKey" id = "accessKey" value = "${general.accessKey}" placeholder="Marital Status"/>
                      <h5>Marital Status</h5>
                      <select id="martialStatus"  onchange="showDate()">
                        <option value = ""  >Select</option>
                         <c:forEach items="${martialStatus}" var="status">
						 <option value="${status }" ${status == general.martialStatus ? 'selected="selected"' : ''}>${status }</option>
						 </c:forEach>
                         <option value = "Widowed"  >Widowed</option>
                      </select>
                    </div>
                    <div class="form-block" id="inv_date" style="display:none">
					 <h5>Marriage Date</h5> 
                      <input type="date" value = "${general.anniversaryDate }" id="date" placeholder="Anniversary Date" />
                    </div>
                    <div class="form-block">
                      <h5>Blood Group</h5>
                      <select  id="blodgroup">
                        <option value = ""  >Select</option>
                         <c:forEach items="${blodgroup}" var="group">
						 <option value="${group.listCode }" ${group.listCode == general.bloodGroup ? 'selected="selected"' : ''}>${group.listDesc }</option>
						 </c:forEach>
                      </select>
                    </div>
	                 <c:if test="${(general.hiredStatus != 'Y') && general.status !='H'}">
                     <%if(role.equalsIgnoreCase("HRE")) { %>
                  <div class="form-btn">
                     
                      <a href="#" class="btn outline-btn" id="submitbtn">Save</a>
                      <input class="btn blue-btn" type = "button" value = "Next" id="submitnext"/>
                      </div>
                      <%} %>
                    </c:if>
                  </div>
                </form>
              </div>
    </div>
    </div>
    </div>
	<div class="blk-bg"></div>
      <input type="hidden" id="accesskey" value="${general.accessKey}">
			<script src="./js/jquery.validate.js"></script>
			<script type="text/javascript" src="./js/generalDetail.js"></script>
    <script>
      $(document).ready(function () {
    	  <%if(role.equalsIgnoreCase("LM") || role.equalsIgnoreCase("SA") || role.equalsIgnoreCase("HOD")) { %>
    	  $('input').attr('disabled', 'disabled');
    	  $('select').attr('disabled', 'disabled');
    	  <%}%>
		  
		  
        $('#tabs').scrollTabs();
		var profile = document.getElementById("profile");
		var general_details = document.getElementById("general_details");
		
		profile.className -= 'tab-btn tab_selected scroll_tab_first';
        general_details.className += 'tab-btn tab_selected scroll_tab_first';
      });
      
      
      function save() {
    	var accesskey = $("#accessKey").val();
    	var martialStatus  = $("#martialStatus").val();
    	var anniversary_date = $("#date").val();
    	var blodgroup = $("#blodgroup").val();
		 var fd = new FormData();
		  fd.append('accesskey',accesskey);
          fd.append('martialStatus',martialStatus);
          fd.append('anniversary_date',anniversary_date);
          fd.append('blodgroup',blodgroup);
          fd.append('btnStatus','S');
    	  
		   $.ajax({
           type: "POST",
           enctype: 'multipart/form-data',
           url: "saveGeneralDetails",
           data: fd,
           processData: false,
           contentType: false,
           cache: false,
           timeout: 600000,
           success: function (data) {
          	window.location.reload();	 
     
           },
           
       });
  		/*$.ajax({
	 			  type: "POST",
	 			  url:  "saveGeneralDetails",
	 			  data: "accesskey="+accesskey+"&martialStatus="+martialStatus+"&anniversary_date="+anniversary_date+"&blodgroup="+blodgroup+"&btnStatus=S",
	 			  success: function(data){
	 				 window.location.reload();
	 			  },
	 			  error: function(errorThrown){
	 			  }
	 		  }); */
  	    $('.delete-popup, .blk-bg').hide();
  	}
	
	function next() {
      	
      	var accesskey = $("#accessKey").val();
      	var martialStatus  = $("#martialStatus").val();
      	var anniversary_date = $("#date").val();
		var blodgroup = $("#blodgroup").val();
      	/*var blodgroup = $("#blodgroup").val();
  	 		     document.forms[0].action="saveGeneralDetails?accesskey="+accesskey+"&martialStatus="+martialStatus+"&anniversary_date="+anniversary_date+"&blodgroup="+blodgroup+"&btnStatus=N";
  	 			document.forms[0].method="post";
  	 			document.forms[0].submit(); */
				
				var fd = new FormData();
		  fd.append('accesskey',accesskey);
          fd.append('martialStatus',martialStatus);
          fd.append('anniversary_date',anniversary_date);
          fd.append('blodgroup',blodgroup);
          fd.append('btnStatus','N');
				 $.ajax({
           type: "POST",
           enctype: 'multipart/form-data',
           url: "saveGeneralDetails",
           data: fd,
           processData: false,
           contentType: false,
           cache: false,
           timeout: 600000,
           success: function (data) {
              window.location.href="getWorkExperience?accesskey="+accesskey+"&param";
           },
           
       });
    	}
	
	function showDate(){
		var marital_status  = $("#martialStatus").val();
		var inv_date = document.getElementById("inv_date");
		if(marital_status == "Married"){
        inv_date.style.display = 'block'; 
		}else{
			inv_date.style.display = 'none';
		}
	}
    </script>
	
	 <c:if test="${general.martialStatus eq'Married' }">
	  <script>
		   var invi_date = document.getElementById("inv_date");
		    invi_date.style.display = 'block'; 
			 </script>
		   </c:if>
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

