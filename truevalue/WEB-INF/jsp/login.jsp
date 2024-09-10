<%@ page language="java" import=" java.net.*, java.io.*,java.util.*"%>
<%@ page import = "java.util.ResourceBundle" %>

<%
try
    {
	ResourceBundle resource = ResourceBundle.getBundle("application");
String baseServer = resource.getString("client.url");
String msg ="";  
if(session.getAttribute("msg") != null){
	  msg = (String)session.getAttribute("msg");
	  session.removeAttribute("msg");
}
if(msg == "D"){
  msg="Invalid Login";
}
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
	 <link rel="icon" type="image/x-icon" href="<%=baseServer%>img/iRecruit-favicon.ico"/>  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>iRecruit</title>
    <link rel="stylesheet" type="text/css" href="./css/login.css" />
	<link rel="stylesheet" type="text/css" href="./css/sweetalert.css"/>
    <script type="text/javascript" src="./js/sweetalert.min.js"></script>
	<link rel="stylesheet" type="text/css" href="./includes/left-panel/left-panel.css" />
    <style>
      /* .left-panel > ul > li:nth-child(2) a::after{content: ''; position: absolute; right: 0; top: 50%; transform: translate(0, -50%); border-right: 6px solid #fff; border-top: 6px solid transparent; border-bottom: 6px solid transparent;} */
    </style>
<style type="text/css">
        .showSweetAlert{margin:0px!important; left: 45% !important;top: 43% !important;} 
				input::-ms-clear, input::-ms-reveal {display: none;} 
        .terms-section li::after{width: 0px; height: 0px;}
        @media (max-width: 540px){
.showSweetAlert {
    margin: 0px!important;
    left: 50% !important;
    top: 50% !important;
    width: 75%;
    max-width: 355px !important;
    transform: translateX(-50%);
    animation: none !important;
}}
</style>
    <script src="./js/jquery-3.4.1.min.js"></script>
    
    <script language="javascript" type="text/javascript">


function userLogin()
{
	   var emial_1 =  $("#email").val().trim();
	   var password =  $("#password").val().trim();
	   
	     if(email =="")
		 {
		 swal({   
				  title: "Please enter correct login details",     
				  showCancelButton: false,
				  confirmButtonColor: "#2D3392",   
				  confirmButtonText: "Ok",   
				  closeOnConfirm: true },
				  function(isConfirm){			  
					  return false; 
				}); 	
		 
		 return false;
		 }
	     
	     if(password =="")
		 {
	     swal({   
				  title: "Please enter correct login details",     
				  showCancelButton: false,
				  confirmButtonColor: "#2D3392",   
				  confirmButtonText: "Ok",   
				  closeOnConfirm: true },
				  function(isConfirm){			  
					  return false; 
				}); 	
		 
		 return false;
		 } 
		  localStorage.setItem("windows",0);
	        document.forms[0].method="post";
			document.forms[0].action="./loginPro";
			document.forms[0].submit()
			
	
} 

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
		
		$(function() {

    if (localStorage.chkbx && localStorage.chkbx != '') {
        $('#remember_me').attr('checked', 'checked');
        $('#email').val(localStorage.email);
        $('#password').val(localStorage.password);
    } else {
        $('#remember_me').removeAttr('checked');
        $('#email').val('');
        $('#password').val('');
    }

    $('#remember_me').click(function() {

        if ($('#remember_me').is(':checked')) {
            // save username and password
            localStorage.email = $('#email').val();
            localStorage.password = $('#password').val();
            localStorage.chkbx = $('#remember_me').val();
        } else {
            localStorage.email = '';
            localStorage.password = '';
            localStorage.chkbx = '';
        }
    });
});
</script>
  </head>
  <body>
    <div class="left-panel">
	<div class="menu-left"></div>
 <div class="logo">
        <h1 class="LOGO" style="color: #fff;"><b>iRecruit</b></h1>
        <!-- <a href="#"
          ><img src="./img/iRecruit-logo.svg" alt=""
        /> -->
	<span style="color:white; font-size:14px"> An Intelligent Recruitment System</span>
		
      </div>
      <ul>
        <li>
          <a href="candidateLogin"
            ><img src="./img/icn03.svg" alt="" /> Candidate Login</a
          >
        </li>
        <li class="open">
          <a href="./login" class="active"
            ><img src="./img/icn04.svg" alt="" /> Admin Login</a
          >
        </li>
      </ul>
	  
    </div>

    <div class="right-panel"> 
      <p style="font-size:40px; font-weight:700;margin-top:90px;">Welcome</p>
        <div class="form">
            <form class="form__section" action="./loginPro" method="post">
	
            
                <span style="color:red;">
						       	<strong><%=msg %></strong>							
						</span>
                  <h1 style="font-size: 25px !important;">Admin Login</h1>
                <div class="form__block">
                    <input type="text"  placeholder="MSPIN / Staff ID" id="email" name="user"   maxlength="55" />
                </div>
                <div class="form__block">
                    <input type="password"  placeholder="Password" id="password" name="password"  />
                </div>
				
                <div class="form__block">
				<!--<h1 style="font-size: 25px !important;">The website is under maintenance. We'll be back soon.</h1>-->
                    <span class="form__button form__button--submit"  id="loginButton" onclick="userLogin()"><img src="./img/login-icn.svg"  /> Login</span>
                </div>
                  <input type="checkbox" value="remember-me" id="remember_me"> Remember Me
            </form>
        </div>
		<div class="terms-section">
          <ul>
            <li><a href="./termsCondition" target="_blank">Terms & Conditions</a></li>
            <li style="color:#999;">|</a></li>
            <li><a href="./privacy" target="_blank">Privacy Policy</a></li>
          </ul>
        </div>
    </div>

  </body>
</html>
<%
 }catch(Exception e)
    {
    	 System.out.println("Errror....."+e);
    	  response.sendRedirect("login");
    }%>
