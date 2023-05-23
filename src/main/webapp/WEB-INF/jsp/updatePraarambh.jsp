<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ page import = "java.util.ResourceBundle" %>

<%
try
{
String msg="";
if(session.getAttribute("error_msg") != null){
	msg = session.getAttribute("error_msg").toString().trim();
}
session.removeAttribute("error_msg");
System.out.println("cal............"+msg);
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<link rel="shortcut icon" type="image/svg" href="http://staging.irecruit.org.in:8080/irecruit/img/iRecruit-favicon.ico"/>
    <link rel="stylesheet" type="text/css" href="./css/common.css" />
    <title><%=title %></title>
  <!--   <link rel="stylesheet" type="text/css" href="./css/login.css" /> -->
    <link rel="stylesheet" type="text/css" href="./css/sweetalert.css"/>
    <script type="text/javascript" src="./js/sweetalert.min.js"></script>
    <style>
      .left-panel > ul > li:nth-child(1) a::after{content: ''; position: absolute; right: 0; top: 50%; transform: translate(0, -50%); border-right: 6px solid #fff; border-top: 6px solid transparent; border-bottom: 6px solid transparent;}
    
    .error-chage-email{
	margin: 20px 0;
color: #f00;
text-align: centre;
font-size: 14px;
line-height: 20px;
display:none;
}
 .form {
    margin: 80px auto 25px;
    max-width: 470px;
    width: 52%;
    background-color: #fff;
    box-shadow: 0px 3px 10px rgba(0,0,0,0.1);
    border-radius: 10px;
    padding: 29px;
    box-sizing: border-box;
  }

  .form h1 {
    font-size: 30px;
    line-height: 36px;
    color: #000;
    text-align: center;
    margin: 0 0 30px;
    font-weight: 700;
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
    <script src="./js/jquery-3.4.1.min.js"></script>
    
    
    <script>
    function updatePraaarambh(){
    	
		var mspin     =  $("#upeate_mspin").val();
		if (mspin == "") {
			 swal({   
					title: "Enter MSPIN",     
					showCancelButton: false,
					confirmButtonColor: "#DC3545",   
					confirmButtonText: "OK",   
					closeOnConfirm: true },
					function(isConfirm){
						 return false;
					});	
	          return false;
	      }
		document.forms[0].action="updatePraarambhPro?mspin="+mspin;
		document.forms[0].method="post";
		document.forms[0].submit(); 
		 
	}
    
   
    
    </script>
    
  </head>
  <body>
   <div class="left-panel-include">
   <%@include file="./header/left-panel.jsp"%> 
  </div>
    <div class="user-panel-include">
	  <%@include file="./header/user-panel.jsp"%> 
	</div>
 <div class="right-section">
       
    <div >
        <div class="form" style="max-width: 600px!important;">
            <form class="form__section"   id="testForm">
                <h1 style="font-size:25px !important;">Update praarambh status</h1>
                <div class="form__block">
                    <input type="text" name="mspin" id="upeate_mspin" placeholder="Enter mspin">
                </div>
                 <div class="error-chage-email" id="errorEmail"></div>
                <div class="form__block">
                    <input type="button" class="form__button form__button--submit" onclick="updatePraaarambh()" value="Proceed">
                </div>
            </form>
        </div>
    </div>
</div>
<script>
<%if(msg.equals("1")){%>
$('.error-chage-email').append('Praarambh Completed.');
   $('.error-chage-email').show();   
<% }%>

</script>
  </body>
</html>

<%
 }catch(Exception e)
    {
    	 System.out.println("Errror....."+e);
    	  response.sendRedirect("login");
    }%>