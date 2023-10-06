<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" type="image/x-icon" href="<%=baseServer%>img/DuflonFavicon.png"/>
<title><%=title %></title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>
<body>
	
	
	<div class="container">
		<div class="row">
			<div class="col-md-12 text-center mt-5">
				<h1>Form not submitted</h1>
				<p>You are trying to reapply same job.</p>
			</div>
		</div>
	</div>
	
	<script>
        // Function to reload the previous page (registration page) when the user clicks the back button
        function reloadPreviousPage() {
            window.location.replace("/formPage"); // Redirect to the registration page (form page)
        }

        // Listen for the popstate event (when the user navigates back or forward)
        window.addEventListener('popstate', reloadPreviousPage);
    </script>
</body>
</html>
<%
 }catch(Exception e)
    {
    	 System.out.println("Errror....."+e);
    	  response.sendRedirect("login");
    }%>