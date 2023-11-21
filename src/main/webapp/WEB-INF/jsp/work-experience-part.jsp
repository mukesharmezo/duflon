<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="com.armezo.duflon.Entities.ParticipantRegistration"%>	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page import = "java.util.ResourceBundle" %>
<%
try
    {
	ResourceBundle resource = ResourceBundle.getBundle("application");
String baseServer = resource.getString("client.url");String title = resource.getString("app.title");
String temp = request.getParameter("param"); 
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
	<link rel="stylesheet" type="text/css" href="./css/registration/durecruit-work-experience.css" />
  <!--  <style>
        .left-panel > ul > li:nth-child(2) > a, .left-panel > ul > li:nth-child(2) > ul > li:nth-child(2) > a{opacity: 1;}
        .left-panel > ul > li:nth-child(2) > ul > li:nth-child(2) > a::after{content: ''; position: absolute; right: 0; top: 50%; transform: translate(0, -50%); border-right: 6px solid #fff; border-top: 6px solid transparent; border-bottom: 6px solid transparent;}
    </style> -->
<style>
.form-btn{width: 100% !important;}
  
</style>
    <script src="./js/jquery-3.4.1.min.js"></script>
    <script src="./js/jquery.dataTables.min.js"></script>
    <script src="./js/jquery.scrolltabs.js"></script>
  </head>
  <body>

    <div class="right-section left-moved">
        <h1>Work Experience</h1>
        <div class="container-1100">
            <div class="profile-container">
                  <%@include file="./header/profileMenuPart.jsp"%>

              <div class="profile-content">
                <form action="/saveWorkExperience" class="form" method = "post">
                  <div class="form-section">
                    <div class="form-block">
                    
                      <h5>Work Experience</h5>
                      <input type="radio" name="experience" id="fresher" value = "fresher"><label for="fresher">Fresher</label>
                      <input type="radio" name="experience" id="experience" value = "experience" onclick="changeExperiance()"><label for="experience">Experience</label>
                    </div>
					<c:if test="${(workexperience.documents_status != 'final') && workexperience.status !='H'}">
                  <div class="form-btn">
                     <!-- <a href="#" class="cancel-btn">Edit</a> -->
                      <a href="#" class="btn outline-btn" onclick="save()">Add</a>
                      <!-- <a href="#" class="btn blue-btn">Next</a> -->
                      <input class="btn blue-btn" type = "button" value = "Next" onclick="openFamilyMemberDetails()"/>
                  </div>
				  </c:if>
                  </div>
                </form>
              </div>
    </div>
    </div>
    </div>
 <input type="hidden" id="accesskey" value="${workexperience.accessKey}">
 
 <input type="hidden" id="temp_experience" value="${workexperience.experience}">
 <input type="hidden" id="temp_fresher" value="${workexperience.fresher}">
 <input type="hidden" name="userType" id="userType" value="Part"/>
 <input type="hidden" id="work" value="">
    <script>
      $(document).ready(function () {
		 var temp = $("#temp").val();
		  var temp1 = $("#temp_experience").val();
		  var temp2 = $("#temp_fresher").val();
		if(temp2 == 'fresher'){ 
           $("#fresher:checked").val();
           $("#fresher").prop('checked',true);
		   $("#work").val("fresher");
		}
		
		if(temp1 =="experience"){
		  $("#experience:checked").val();
          $("#experience").prop('checked',true);	
		   var key= $("#accesskey").val();
		   <%if(temp == ""  ){%>
           window.location.href="getWorkExperienceExpPart?accesskey="+key;
		   <%}%>
		}
		
        $('#tabs').scrollTabs();
		
		var profile = document.getElementById("profile");
		var work_experience = document.getElementById("work_experience");
			
		profile.className -= 'tab-btn tab_selected scroll_tab_first';
        work_experience.className += 'tab-btn tab_selected scroll_tab_first';
        
        $("#experience").change(function(){
			
            var accesskey= $("#accesskey").val();
        	window.location.href="getWorkExperienceExpPart?accesskey="+accesskey;
        	var val = $("#experience:checked").val();
        	$("#work").val(val);
        });
		
		
        
        $("#fresher").change(function(){
        	var val = $("#fresher:checked").val();
        	$("#work").val(val);
        });
      });
	  
	  function changeExperiance(){
		  var accesskey= $("#accesskey").val();
        	window.location.href="getWorkExperienceExpPart?accesskey="+accesskey;
        	var val = $("#experience:checked").val();
        	$("#work").val(val);	
			
		}
      function save(){
      	var accesskey= $("#accesskey").val();	
      	var work= $("#work").val();	
      	var userType= $("#userType").val();	
      	//window.location.href="saveWorkExperience?accesskey="+accesskey+"&status="+work;
           document.forms[0].action="saveWorkExperience?accessKey="+accesskey+"&status="+work+"&userType="+userType+"&btnStatus=Next";
		   document.forms[0].method="post";
		   document.forms[0].submit();
      }
    </script>
  </body>
</html>
<%
 }catch(Exception e)
    {
    	 System.out.println("Errror....."+e);
    	  response.sendRedirect("login");
    }%>

