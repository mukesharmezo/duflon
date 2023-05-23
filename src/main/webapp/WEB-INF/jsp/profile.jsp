<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<%@ page import = "java.util.ResourceBundle" %>

<%
try
    {
	ResourceBundle resource = ResourceBundle.getBundle("application");
String baseServer = resource.getString("client.url");String title = resource.getString("app.title");
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
        <h1>Profile</h1>
        
        <form id = "formprofileId" action="/profiledetails" class="form"  method="get" >
        <div class="container-1100">
            <div class="profile-container">
                <%@include file="./header/profileMenu.jsp"%>
                
                <div class="profile-content">
                    <div class="profile-tab">
	               <input type = "hidden" name = "accessKey" id = "accessKey" value = "${profile.accessKey}"/>  
                        <div class="profile-img">
                        <%-- <img alt = "my image" src ="<c:url value = "C:/ParticipantUploadedFiles/kb.jpg"/>"> --%>
                       <!-- <img src="./img/user-img.png" /> -->
                            <img src="images/${profile.photograph}" /> 
                        </div>
                        <div class="profile-details">
                            <div class="profile-name">
                                <!-- Somnath Prasad -->
                                ${profile.firstName} ${profile.lastName}<br />
                                 <span class="profile-designation">${profile.designation}</span>
                            </div>
                            <div class="profile-details-section">
                                <div class="profile-details-block">
                                    <span>HRM</span>
                                   <h4>${hreName}</h4>
                                    <h4></h4>
                                </div>
                                <div class="profile-details-block">
                                    <span>Region</span>
                                    <!-- <h4>India</h4> -->
                                     <h4>${region}</h4>
                                </div>
                                <div class="profile-details-block">
                                    <span>State</span>
                                    <!-- <h4>Gujrat</h4> -->
                                    <h4>${state}</h4>
                                </div>
                                <div class="profile-details-block">
                                    <span>City</span>
                                    <!-- <h4>Gandhinagar</h4> -->
                                    <h4>${city}</h4>
                                </div>
                                <!-- <div class="profile-details-block">
                                    <span>Outlet</span>
                                  
                                    <h4>${outletName}</h4>
                                </div>
                                <div class="profile-details-block">
                                    <span>Outlet Code</span>
                                    <h4>${outletCode}</h4>
                                </div> -->
                            </div>
                        </div>
                    </div>
                </div>
                <div class="profile-content seprate">
                    <div class="profile-tab">
                        <div class="profile-details">
                            <div class="profile-details-section">
                                <div class="profile-details-block">
                                    <span>Assessment Date</span>
                                    <!-- <h4>23 May, 2019</h4> -->
                                    <h4>${Accessment_date}</h4>
                                </div>
                                <div class="profile-details-block">
                                    <span>Interview Date</span>
                                    <!-- <h4>23 May, 2018</h4> -->
                                <h4>${interviewDate}</h4>
                                </div>
                                <div class="profile-details-block">
                                    <span>Approval Date</span>
                                    <h4>${hiredDate}</h4>
                                </div>
                                <div class="profile-details-block">
                                    <span>Joining Date</span>
                                    <!-- <h4>23 May, 2018</h4> -->
                                    <h4>${joiningDate}</h4>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </form>
    </div>
 <input type="hidden" id="accesskey" value="${profile.accessKey}">
    <div class="blk-bg"></div>
    <script>
      $(document).ready(function () {
       // $(".left-panel-include").load("./includes/left-panel/left-panel.html");
       // $(".user-panel-include").load("./includes/user-panel/user-panel.html");
        $('#tabs').scrollTabs();
      });
    </script>
  </body>
</html>
<%
 }catch(Exception e)
    {
    	 System.out.println("Errror....."+e);
    	  response.sendRedirect("login");
    }%>