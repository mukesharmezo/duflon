<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import = "java.util.ResourceBundle" %>

<%
try
    {
	ResourceBundle resource = ResourceBundle.getBundle("application");
String baseServer = resource.getString("client.url");String title = resource.getString("app.title");
	
    String msg="";
    if(session.getAttribute("msg") != null){
  	  msg = (String)session.getAttribute("msg");
  	  session.removeAttribute("msg");
  }
    if(msg.equals("I")){
    	msg="Invalid Access Key";
    }
    if(msg.equals("E")){
    	msg="Access Key Expired";
    }
    
    if(msg.equals("C")){
    	msg="You have completed the registration/assessment";
    }
    if(msg.equals("B")){
    	msg="Access Key Block";
    }
	
	 if(msg.equals("D")){
    	msg="Documents Uploaded";
    }
	if(msg.equals("N")){
    	msg="Your Access Key is not active. Please contact your HRE POC/Recruiter";
    }
	
	if(msg.equals("IN")){
    	msg="Access key Inactive";
    }
    
    %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<link rel="icon" type="image/x-icon" href="<%=baseServer%>img/DuflonFavicon.png"/>  <title><%=title %></title>
    <link rel="stylesheet" type="text/css" href="./css/login.css" />
	<link rel="stylesheet" type="text/css" href="./includes/left-panel/left-panel.css" />
		<link rel="stylesheet" type="text/css" href="./css/sweetalert.css"/>
    <script type="text/javascript" src="./js/sweetalert.min.js"></script>
    <style>
      .showSweetAlert{margin:0px!important; left: 45% !important;top: 43% !important;}
      .terms-section li::after{width:0px !important;height: 0px !important;}
      @media (max-width: 540px){
  .mob-logo{display: block;}
  .mob-cal .form__text{width: 40% !important;}
  .mob-cal .mob-result{width: 60% !important;padding: 15px 10px 15px 10px !important;}
  .showSweetAlert {
    margin: 0px!important;
    left: 50% !important;
    top: 50% !important;
    width: 75%;
    max-width: 355px !important;
    transform: translateX(-50%);
    animation: none !important;
  }
}


    /* .left-panel > ul > li:nth-child(1) a::after{content: ''; position: absolute; right: 0; top: 50%; transform: translate(0, -50%); border-right: 6px solid #fff; border-top: 6px solid transparent; border-bottom: 6px solid transparent;} */
    </style>

    <script src="./js/jquery-3.4.1.min.js"></script>
    <script>
    
	function validateForm()
	{
		
		var txtAkey=$("#accesskey").val();
		//txtAkey = txtAkey.replace(/^\s*|\s*$/g,"");

		var result=$("#result").val();
		//result = studResult.replace(/^\s*|\s*$/g,"");
		
		var temp = $("#temp").val();
		
		 
		if(txtAkey==""){
			swal("Please enter the access key");
			document.forms[0].txtAkey.focus();
			return false;
		}

		if(result==""){
			swal("Please enter calculation result");
			document.forms[0].txtstudentresult.focus();
			return false;
		}
		if (result != temp) 
		  {
		    swal("Invalid result. Please enter correct value.");
		    return false;
		  }
		 
			document.frmLogin.action="candidateLoginPro";
			document.frmLogin.method="post";
			document.frmLogin.submit();
		 
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
        $('#result').keyup(function(event){
       if(event.keyCode === 13 ){
        console.log("Hello Clicked");
        $('#loginButton').click();
       } 
      });
        });
    </script>
  </head>
  <body>
    <div class="left-panel">
	<div class="menu-left"></div>
      <div class="logo">
        <h1 class="LOGO" style="color: #fff;"><b>DuRecruit</b></h1>
        <!-- <a href="#"
          ><img src="./img/iRecruit-logo.svg" alt=""
        /></a> -->
		<span style="color:white; font-size:14px;">Talent Acquisition Portal</span></a>.
      </div>
      <ul>
        <li>
          <a href="candidateLogin" class="active"
            ><img src="./img/icn03.svg" alt="" /> Candidate Login</a
          >
        </li>
        <li class="open">
          <a href="login"
            ><img src="./img/icn04.svg" alt="" /> Admin Login</a
          >
        </li>
      </ul>
	   <!-- <p style="font-style: italic;">An Intelligent <span>Recruitment System</span></p> -->
    </div>

    <div class="right-panel">
      <!-- <div class="logo mob-logo">
        <h1 class="LOGO" style="color: #DC3545 !important;"><b>iRecruit</b></h1> -->
        <!-- <a href="#"
          ><img src="./img/iRecruit-logo.svg" alt=""
        /></a> -->
		<!-- <span style="color: #DC3545;text-align: left !important;display: block; font-size:14px">An Intelligent Recruitment System</span></a>. -->
      <!-- </div> -->
      <p  style="font-size:40px; font-weight:700;margin-top:90px;">Welcome</p>

	 <!-- <h1>Welcome</h1> -->
        <div class="form">
            <form class="frmLogin"   name="frmLogin" action="/candidateLoginPro" method="post">
             <span style="color: red">
             <font size="2" color="red"><%=msg %></font>
             </span>
                <h1  style="font-size: 25px !important;">Candidate Login</h1>
                <div class="form__block">
                    <input type="text" name="txtAkey" placeholder="Access Key" id="accesskey">
                </div>
                <div class="form__block form__block--half mob-cal">
                    <div class="form__text"><span>${r1}&nbsp;${r2}&nbsp;${r3}&nbsp;</span> =</div>
                    <input type="text" name="textresult" class="mob-result" placeholder="Enter Result" id="result" oninput="this.value=this.value.replace(/[^0-9]/g,'');">
                     <input type="hidden" name="calculationresult" value="${r4}" id="temp" id=""/>	
                </div>
                <div class="form__block"  id="loginButton"  onclick="validateForm();">
                    <span class="form__button form__button--submit"><img src="./img/login-icn.svg"  /> Login</span>
                </div>
            </form>
        </div>
		<!-- <div class="terms-section">
          <ul>
            <li><a href="./termsCondition" target="_blank">Terms & Conditions</a></li>
            <li  style="color:#999;">|</a></li>
            <li><a href="./privacy" target="_blank">Privacy Policy</a></li>
          </ul>
        </div> -->
    </div>

  </body>
</html>
<%
 }catch(Exception e)
    {
    	 System.out.println("Errror....."+e);
    	  response.sendRedirect("login");
    }%>
