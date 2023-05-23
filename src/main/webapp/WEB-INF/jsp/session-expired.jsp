<%@ page language="java" import=" java.net.*, java.io.*,java.util.*"%>
<%@ page import = "java.util.ResourceBundle" %>

<%
try
    {
	ResourceBundle resource = ResourceBundle.getBundle("application");
String baseServer = resource.getString("client.url");String title = resource.getString("app.title");
String msg ="";  
if(session.getAttribute("msg") != null){
	  msg = (String)session.getAttribute("msg");
	  session.removeAttribute("msg");
}
 
session.invalidate();
 
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
	 <link rel="icon" type="image/x-icon" href="<%=baseServer%>img/DuflonFavicon.png"/>  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title><%=title %></title> 
	<link rel="stylesheet" type="text/css" href="./css/sweetalert.css"/>
    <script type="text/javascript" src="./js/sweetalert.min.js"></script>
	<link rel="stylesheet" type="text/css" href="./includes/left-panel/left-panel.css" />
    <style>
	body {
		/* background-color:#DC3545; */
	}
    .form {
    margin: 80px auto 25px;
    max-width: 450px;
    width: 100%;
    background-color: #fff;
    box-shadow: 0px 3px 10px rgba(0,0,0,0.1);
    border-radius: 10px;
    padding: 29px;
    box-sizing: border-box;
  }

  .form p {
    font-size:22px;
    line-height: 36px;
    color: #000;
    text-align: center;
  }

  .form__block {
    display: flex;
    flex-wrap: wrap;
    margin-bottom: 12px;
  }

  .form__block input[type="text"],
  .form__block input[type="number"],
  .form__block input[type="password"],
  .form__block input[type="email"] {
    padding: 15px 40px 15px 24px;
    box-sizing: border-box;
    border: 2px solid #EFEFEF;
    border-radius: 10px;
    width: 100%;
    font-size: 15px;
    line-height: 2px;
    font-weight: 400;
    outline: none;
  }

  .form__block--half input[type="text"],
  .form__block--half input[type="number"],
  .form__block--half input[type="password"],
  .form__block--half input[type="email"] {
    width: 50%;
    border-radius: 0 10px 10px 0;
  }

  .form__text{width: 50%; background-color: #EBEBEB; display: flex; justify-content: center; align-items: center; border-radius: 10px 0 0 10px;}
  .form__button--submit{background-color: #DC3545; border-radius: 10px; width: 100%; padding: 15px; font-size: 16px; line-height: 20px; font-weight: 700; text-align: center; box-sizing: border-box; border: none; color: #fff; display: flex; justify-content: center; align-items: center; margin-top: 20px;}
  .form__button--submit:hover{cursor: pointer !important;}
  .form__button--submit img{margin-right: 10px;}

    </style>
<style type="text/css">
        .showSweetAlert{margin:0px!important; left: 45% !important;top: 43% !important;} 
				input::-ms-clear, input::-ms-reveal {display: none;} 
        .terms-section li::after{width: 0px; height: 0px;}
        @media (max-width: 600px){
.showSweetAlert {
    margin: 0px!important;
    left: 50% !important;
    top: 50% !important;
    width: 75%;
    max-width: 600px !important;
    transform: translateX(-50%);
    animation: none !important;
}}
</style>
    <script src="./js/jquery-3.4.1.min.js"></script>
    
    <script language="javascript" type="text/javascript">
 
$(document).ready(function () {
   

            
        });
</script>
  </head>
  <body topmargin="0"> 
    

    <div class="mx-auto  p-3"  > 
      
        <div class="form"  style="text-align:center;width: 100%;padding: 24px 14px;background-color: #f4f4f4;">
            <form class="form__section" action="./login" method="post">
	 
              <p>Your session has expired due to inactivity.<br>Please <a href="./login">click here</a> to relogin</p>
                <!-- <h1 style="font-size: 25px !important;color:brown">Your session is expired due to inactivity.<br>Please <a href="./login">click here</a> to relogin</h1> -->
                
                <div class="form__block">
                     
                </div>
               
            </form>
        </div>
		<div class="terms-section">
         
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
