<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	 <link rel="icon" type="image/x-icon" href="<%=baseServer%>img/iRecruit-favicon.ico"/>  <title>Upload Documents</title>
    <link rel="stylesheet" type="text/css" href="./css/style.css" />
</head>
<body>
    <div class="header">
        <div class="logo"><img src="./img//iRecruit-logo.svg" alt="" /></div>
    </div>
    <div class="container">
        <h1 class="margin-bottom-60">Upload Documents</h1>
        <h3>Instructions</h3>
        <form action="	" class="form" method = "get">
        <ol type="1">
            <li>To add respondents under a certain category, please click on the button and type in the name of the respondent and choose from the list. </li>
            <li>Click against any  respondent - if you have added the same by mistake </li>
            <li>You are eligible to receive a report only if there are a minimum 5 respondents in all. So choose minimum 5 respondents </li>
            <li>We recommend to keep a maximum of 7 - 10 names to get a balanced view.</li>
            <li>Please review/update the list in one go, the list is auto-saved every 2 minutes</li>
            <li>In case of any technical queries please write to <a href="mailto:support@Armezo.com">support@Armezo.com</a></li>
        </ol>
       <div class="action-section"><a href="/jsp/upload-registrations.jsp" class="btn blue-btn">Next</a></div>
          </form>
    </div>
</body>
</html>
<%
 }catch(Exception e)
    {
    	 System.out.println("Errror....."+e);
    	  response.sendRedirect("login");
    }%>