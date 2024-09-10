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
String baseServer = resource.getString("client.url");
	%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<link rel="icon" type="image/x-icon" href="<%=baseServer%>img/iRecruit-favicon.ico"/>  <title>iRecruit</title>
    <link rel="stylesheet" type="text/css" href="./css/common.css" />
    <link rel="stylesheet" type="text/css" href="./css/profile.css" />
    <link rel="stylesheet" href="./css/scrolltabs.css">
   <!-- <style>
        .left-panel > ul > li:nth-child(2) > a, .left-panel > ul > li:nth-child(2) > ul > li:nth-child(2) > a{opacity: 1;}
        .left-panel > ul > li:nth-child(2) > ul > li:nth-child(2) > a::after{content: ''; position: absolute; right: 0; top: 50%; transform: translate(0, -50%); border-right: 6px solid #fff; border-top: 6px solid transparent; border-bottom: 6px solid transparent;}
    </style> -->

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
                                    <span>Joining Date</span>
                                    <!-- <h4>23 May, 2019</h4> -->
                                   <h4>${profile.joiningDate}</h4>
                                </div>
                              
                                <div class="profile-details-block">
                                    <span>FSDM</span>
                                   <h4>${fsdm}</h4>
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
                                <div class="profile-details-block">
                                    <span>Dealer</span>
                                   <!--  <h4>Bajaj</h4> -->
                                   <h4>${dealerName}</h4>
                                </div>
                                <div class="profile-details-block">
                                    <span>Outlet</span>
                                    <!-- <h4>Bagga Link Motor LTD.</h4> -->
                                    <h4>${outletName}</h4>
                                </div>
                                <div class="profile-details-block">
                                    <span>Outlet Code</span>
                                    <!-- <h4>190354</h4> -->
                                    <h4>${outletCode}</h4>
                                </div>
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
                                    <span>Induction Date</span>
                                    <h4>${praarambhDate}</h4>
                                </div>
                                <div class="profile-details-block">
                                    <span>FSDM Approval Date</span>
                                    <h4>${fsdmmApprovalDate}</h4>
                                </div>
                                <div class="profile-details-block">
                                    <span>Joining Date</span>
                                    <!-- <h4>23 May, 2018</h4> -->
                                    <h4>${profile.joiningDate}</h4>
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