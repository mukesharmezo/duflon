<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import = "java.util.ResourceBundle" %>

<%
try
    {
	ResourceBundle resource = ResourceBundle.getBundle("application");
String baseServer = resource.getString("client.url");
	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="icon" type="image/x-icon" href="<%=baseServer%>img/iRecruit-favicon.ico"/>
<title>Trait</title>
<link href="../webjars/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">
<style type="text/css">
.table-wrap {
  height:400px;
  overflow-y: auto;
  background-color:#eee;
  border-radius:5px;
}
</style>

<style>
.flex-container {
  display: flex;
  align-items: stretch;
  background-color: #f1f1f1;
}

.flex-container>div {
  background-color: #527086;
  color: white; 
  margin: 1px;
  text-align: center; 
  padding:2px;
}</style>

<script>

function upload()
{ 
	var filename=document.uploadfile.file.value;
	if(filename=="")
	{
		alert("Please select a Filename to upload");
		document.uploadfile.file.focus();
		return false;
	}
	
	if(filename.substring((filename.length-5),filename.length)!=".xlsx")
	{
		alert("Please select only Excel files");
		document.uploadfile.file.focus();
		return false;
	}
	
		document.uploadfile.method="post";
		document.uploadfile.action="uploadCityPro";
		document.uploadfile.submit();			
}

</script>
</head>
<%
String msg  ="";
  if( request.getParameter("msgError") != null){
	  msg = request.getParameter("msgError");
  }
%>
<body>
	<div class="container">
 
		<br>
		<br>
		<form action="uploadCandidatePro" name="uploadfile" method="POST" enctype="multipart/form-data">
		<div class="form-group">
		    <label for="file">Choose file</label>
		
		<input type="file" class="form-control" name="file"> 
		
		</div>
		<div class="form-group">
		
		
		 <input type="button" value= "Upload" class="btn btn-success " onclick="upload()"> 
		</div>
		
		
		</form>
		
		<div class="table-wrap">

			<table class="table" align="center" border="1">
				<thead>
					<tr>
						<th>City Name</th>
						<th>City Code</th>
						
					</tr>
				</thead>
				 
				
				<tbody>
						
				<c:forEach items="${save_city}" var="city">
					<tr>
					    <td>${city.cityName }</td>
					    <td>${city.cityCode }</td>
						
					</tr>
				</c:forEach> 
				</tbody>
			</table>
			<span>Duplicate</span>
			<table class="table" align="center" border="1">
				<thead>
					<tr>
						<th>City Name</th>
						<th>City Code</th>
						
					</tr>
				</thead>
				 
				
				<tbody>
						
				<c:forEach items="${save_city}" var="city">
					<tr>
					    <td>${city.cityName }</td>
					    <td>${city.cityCode }</td>
						
					</tr>
				</c:forEach> 
				</tbody>
			</table>
		</div>
		 <%if(msg != ""){ %>
                
                        <div class="alert alert-danger">
							<strong>Invalid Login</strong>
						</div>
                
             <%} %>
		 
		<script src="webjars/jquery/1.9.1/jquery.min.js"></script>
		<script src="webjars/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	</div>
</body>
</html>
<%
 }catch(Exception e)
    {
    	 System.out.println("Errror....."+e);
    	  response.sendRedirect("login");
    }%>