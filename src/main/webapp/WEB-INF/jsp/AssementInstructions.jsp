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
String baseServer = resource.getString("client.url");String title = resource.getString("app.title");
	%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="icon" type="image/x-icon" href="<%=baseServer%>img/DuflonFavicon.png"/>
<title>Assessment_Instructions</title>
<link href="/ckbasiceditor/samples/sample.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link href="../css/global.css" rel="stylesheet" type="text/css">
<link href="../css/base.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css"
	href="../datetimepicker-master/jquery.datetimepicker.css" />
<script src="../datetimepicker-master/jquery.js"></script>
<script
	src="../datetimepicker-master/build/jquery.datetimepicker.full.min.js"></script>
<link href="/ckbasiceditor/samples/sample.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link href="../css/global.css" rel="stylesheet" type="text/css">
<meta charset="ISO-8859-1">
<script type="text/javascript">



</script>
</head>
<body>
<h2 style= "text-align: center;" >Instructions of Assessment</h2>
<form action ="/instructions" method="post">

<h5>
<h4>
Greetings Participant<br/><br/>
Welcome to IRECRUIT Selection Process.<br/><br/>
Please read the instructions carefully,
Register Your Details,
Upload Your Photograph and attempt the Online Assessment.<br/><br/></h4>

<h4>WHAT YOU NEED</h4>
1. 	A Mobile Device or Computer/Laptop with Microsoft Windows version 10 or Microsoft Windows version 11<br/>
2. 	Internet Connection with speed 512 kbps internet speed, a higher speed is preferred<br/>
3. 	Internet Browser; i.e. Google Chrome, Mozilla Firefox, Microsoft Edge<br/>
4. 	Kindly attempt is alone without any disturbance/distractions.<br/>

<h4>WHAT TO DO</h4>
1. 	Please close all applications/programs/windows on your mobile device / computer before starting this assessment.<br/>
2. 	Click on the below link and it will open your device web-browser (Google Chrome or Microsoft Edge) and enter your access key.<br/>
3. 	Please complete this assessment in one-go however if you get disconnected; you need to use the same link and same access key to easily resume the assessment.<br/>
4. 	Once you have completed the assessment, you will see Thank You Page; please close the window/browser.<br/>
5. 	Your Dealership HR person will get in touch with you shortly.<br/>
6. 	In case, you are facing any technical issue, please reach to us at IRECRUIT HelpDesk Support [mobile number or email id] <br/><br/><br/>

Registration/Assessment Link: XXXXXXXX<br/>
Your Access Key: XXXXXXXX<br/><br/><br/>

Wishing you all the best.<br/><br/><br/>

IRECRUIT HelpDesk & Support Team
</h5><br/><br/>

<input type="submit" name="submit" value="Next" />

</form>
</body>
</html>
<%
 }catch(Exception e)
    {
    	 System.out.println("Errror....."+e);
    	  response.sendRedirect("login");
    }%>