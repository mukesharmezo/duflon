<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<script>
function a(){
	   window.location = "http://localhost:4005/updateTestStatus?accesskey=" + accesskey + "&testScore=" + testScore;
	   
	   <SCRIPT LANGUAGE="JavaScript">
	   console.log("TES........");
	   alert("Cal,,,,,,,,,");
	 		   window.location = "https://demo.armezosolutions.com:8443/irecruit/updateTestStatus?accesskey=" + accesskey + "&testScore=" + testScore;
	 		   </SCRIPT>
}

</script>
<body>
 <form>
 <input type="button" value= save onclick="a()">
 </form>
</body>
</html>