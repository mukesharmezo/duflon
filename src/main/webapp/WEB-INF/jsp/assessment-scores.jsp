<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
	 <link rel="icon" type="image/x-icon" href="<%=baseServer%>img/DuflonFavicon.png"/> <title><%=title %></title>
    <link rel="stylesheet" type="text/css" href="./css/common.css" />
    <link rel="stylesheet" type="text/css" href="./css/profile.css" />
    <link rel="stylesheet" href="./css/scrolltabs.css">
   <!-- <style>
        .left-panel > ul > li:nth-child(2) > a, .left-panel > ul > li:nth-child(2) > ul > li:nth-child(2) > a{opacity: 1;}
        .left-panel > ul > li:nth-child(2) > ul > li:nth-child(2) > a::after{content: ''; position: absolute; right: 0; top: 50%; transform: translate(0, -50%); border-right: 6px solid #fff; border-top: 6px solid transparent; border-bottom: 6px solid transparent;}
        input[type="number"]{background: #e4e4e4 !important;opacity: 0.7;cursor: no-drop;}
    </style> -->

    <script src="./js/jquery-3.4.1.min.js"></script>
    <script src="./js/jquery.dataTables.min.js"></script>
    <script src="./js/jquery.scrolltabs.js"></script>
    <style>
      .form-btn {
    display: flex;
    justify-content: flex-end;
    /* align-items: center; */
    padding: 0px 0 20px;
    width: 100%;
    box-sizing: border-box;
}
    </style>
  </head>
  <body>
    <div class="left-panel-include">
	<%@include file="./header/left-panel.jsp"%> 
	</div>
    <div class="user-panel-include">
	<%@include file="./header/user-panel.jsp"%>
	</div>

    <div class="right-section">
        <h1 class="cen" style="text-align: center;">Assessment Scores</h1>
        <div class="container-1100">
            <div class="profile-container">
               <%@include file="./header/profileMenu.jsp"%>

              <div class="profile-content">
                <form action="saveAssessmentScore" class="form" method="post">
                  <div class="form-section">
                    <div class="form-block">
                    <input type="hidden" name="accessKey" id = "accessKey" value="${Assmntscore.accessKey }"/>
                      <h5>Aptitude Score</h5>
                                <input type="number" placeholder="Aptitude Score" value="${Assmntscore.aptitudeScore}" disabled  />
                      <c:choose>
                              <c:when test="${Assmntscore.designation eq 'Sales Support'}">
                              <input type="number" placeholder="NA" value="NA" disabled  />
                              </c:when>
                              <c:when test="${Assmntscore.designation eq 'Sales'}">
                              </c:when>
                      </c:choose>
                    </div>
                    <div class="break-section"></div>
                    <div class="form-block">
                      <h5>Attitude Score</h5>
                                <input type="number" placeholder="Attitude Score" value="${Assmntscore.attitudeScore}" disabled />
                      <c:choose>
                              <c:when test="${Assmntscore.designation eq 'Sales Support'}">
                              <input type="number" placeholder="NA" value="NA" disabled  />
                              </c:when>
                              <c:when test="${Assmntscore.designation eq 'Sales'}">
                              </c:when>
                      </c:choose>
                      
                    </div>
                    <div class="break-section"></div>
                    <div class="form-block">
                      <h5>Psychometric Score</h5>
                                <input type="number" placeholder="Psychometric Score" value="${Assmntscore.attitudeScore}" disabled />
                      <%-- <c:choose>
                              <c:when test="${Assmntscore.designation eq 'Sales Support'}">
                                <input type="number" placeholder="NA" value="NA" disabled  />
                              </c:when>
                              <c:when test="${Assmntscore.designation eq 'Sales'}">
                              </c:when>
                      </c:choose> --%>
                    </div>
                    <div class="break-section"></div>
                    <div class="form-block">
                      <h5>Interview Score</h5>
                      <input type="number" placeholder="Interview Score" value="${interviewScore}" disabled />
                    </div>
                    <div class="break-section"></div>

                  <div class="form-btn">
                    <!-- <a href="#" class="btn outline-btn">Save</a> -->
                      <!-- <a href="#" class="btn blue-btn">Next</a> -->
					   <%if(role.equalsIgnoreCase("HRE")) { %>
					  <c:if test="${(Assmntscore.documents_status != 'final') && Assmntscore.status !='H'}">
                       <input class="btn blue-btn" type = "button" value = "Next" onclick="openUploadDocoment()"/>
					   	</c:if>
						
					   <%}%>
                  </div>
                  </div>
                </form>
              </div>
    </div>
    </div>
    </div>
	<div class="blk-bg"></div>
 <input type="hidden" id="accesskey" value="${Assmntscore.accessKey}">
    <script>
      $(document).ready(function () {
		   $('#tabs').scrollTabs();
        var profile = document.getElementById("profile");
		var assessment_scores = document.getElementById("assessment_scores");
		
		profile.className -= 'tab-btn tab_selected scroll_tab_first';
        assessment_scores.className += 'tab-btn tab_selected scroll_tab_first';
       
        function autoClicked(){
            var tabsl = $('#tabs span').length;
            for(let i = 1; i <= tabsl; i++){
            if($('#tabs span:nth-child('+i+')').hasClass('tab_selected')){
                $('#tabs span:nth-child('+i+')').click();
            }
            }
        }
        autoClicked();
      });
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
