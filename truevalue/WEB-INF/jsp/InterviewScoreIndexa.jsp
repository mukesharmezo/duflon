<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="com.msil.irecruit.Entities.ParticipantRegistration"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import = "java.util.ResourceBundle" %>

<%
try
    {
	ResourceBundle resource = ResourceBundle.getBundle("application");
String baseServer = resource.getString("client.url");
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
 <link rel="icon" type="image/x-icon" href="<%=baseServer%>img/iRecruit-favicon.ico"/>
 <title>Show_ score Data</title>

</head>
<body>
                                             <h4>Intervive_Score</h4>

 <table align="center" border="1" cellpadding="5" cellspacing="0" width="50%" class="tblreport" id="tableShow">
 <thead>
                            <tr class="headerrow" height="30">
            <td>ID</td>
            <td>Inter_Viewer</td>
            <td>Clarity_Of_Communication</td>
            <td>presentability</td>
            <td>Attitude_Of_Confidence</td>
            <td>Relevant_Experience</td>
            <td>Situation_Handling_Skills</td>
              <td>Total_Marks</td>
              <td>Interview_Date</td>
        </tr>
      </thead>
      <tbody>
       <c:forEach var="InterScore" items="${score}" varStatus="tester">
            <tr>
                <td>${InterScore.id}</td>
                <td>${InterScore.interViewer}</td>
                <td>${InterScore.clarityOfCommunication}</td>
                <td>${InterScore.presentability}</td>
                <td>${InterScore.attitudeOfConfidence}</td>
                <td>${InterScore.relevantExperience}</td>
                <td>${InterScore.situationHandlingSkills}</td>
                <td>${InterScore.totalMarks}</td>
                <td>${InterScore.interviewDate}</td>
            </tr>
        </c:forEach>
      </tbody>
  </table>
</body>
</html>
<%
 }catch(Exception e)
    {
    	 System.out.println("Errror....."+e);
    	  response.sendRedirect("login");
    }%>