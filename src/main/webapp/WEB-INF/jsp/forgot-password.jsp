<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page import = "java.util.ResourceBundle" %>

<%
try
    {
	ResourceBundle resource = ResourceBundle.getBundle("application");
String baseServer = resource.getString("client.url");
String title = resource.getString("app.title");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" type="image/x-icon" href="<%=baseServer%>img/DuflonFavicon.png"/>
<title><%=title %></title>
<link rel="stylesheet" type="text/css" href="./css/login.css" />
	<link rel="stylesheet" type="text/css" href="./css/sweetalert.css"/>
    <script type="text/javascript" src="./js/sweetalert.min.js"></script>
	<link rel="stylesheet" type="text/css" href="./includes/left-panel/left-panel.css" />
	<script src="./js/jquery-3.4.1.min.js"></script>
</head>
<body>
<div class="left-panel">
	<div class="menu-left"></div>
 <div class="logo">
        <h1 class="LOGO" style="color: #fff;"><b>duRecruit</b></h1>
        <!-- <a href="#"
          ><img src="./img/iRecruit-logo.svg" alt=""
        /> -->
	<span style="color:white; font-size:14px">Talent Acquisition Portal</span>
		
      </div>
      <ul>
      <li class="open">
          <a href="./login" class="active"
            ><img src="./img/icn04.svg" alt="" /> Admin Login</a
          >
        </li>
        <li>
          <a href="candidateLogin"
            ><img src="./img/icn03.svg" alt="" /> Candidate Login</a
          >
        </li>
      </ul>
	  
    </div>
	<div class="right-panel"> 
      <p style="font-size:40px; font-weight:700;margin-top:90px;">Welcome</p>
        <div class="form">

<form action="passwordForgotEmail" method="post">
    <div class="form__block">
                    <input type="text"  placeholder="Email" id="email" name="email"   maxlength="55" />
                </div>
                <div class="form__block">
                    <input type="submit" class="form__button form__button--submit"  id="loginButton"/>
                </div>   
                <div class="form__block">
                	<c:if test="${not empty msg}">
    					<p><b>${msg}</b></p>
					</c:if>
                </div>   
</form>
</div>
</div>
</body>
<script type="text/javascript">
$(document).ready(function () {
	   

    $('.menu-left').click(function() {
		
        $(this).toggleClass('left-moved');
        $('.left-panel').toggleClass('left-moved');
        $('.right-section').toggleClass('left-moved');
	
    });
	if($(window).innerWidth() < 768) {
		
        $('.left-panel, .menu-left').addClass('left-moved');
		$('.left-panel').show();
    }
  
	$('#password').keyup(function(event){
if(event.keyCode === 13 ){
$('#loginButton').click();
} 
});
});
</script>
</html>

<%
 }catch(Exception e)
    {
    	 System.out.println("Errror....."+e);
    	  response.sendRedirect("login");
    }%>