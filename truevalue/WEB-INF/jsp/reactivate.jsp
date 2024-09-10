<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ page import = "java.util.ResourceBundle" %>

<%
try
    {
	ResourceBundle resource = ResourceBundle.getBundle("application");
String baseServer = resource.getString("client.url");
if(session.getAttribute("role") == null){
	 response.sendRedirect("login");
}


	%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
	 <link rel="icon" type="image/x-icon" href="<%=baseServer%>img/iRecruit-favicon.ico"/>  <title>iRecruit</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="./css/common.css" />
    <link rel="stylesheet" type="text/css" href="./css/sweetalert.css"/>
    <script type="text/javascript" src="./js/sweetalert.min.js"></script>
	
    <link rel="stylesheet" type="text/css" href="./css/mspin.css" />
    <link rel="stylesheet" type="text/css" href="./css/hiring-in-process.css" />
     <script src="./js/jquery-3.4.1.min.js"></script>
    <style>
		 .mspin__data {
    max-width: 725px;
}
.blue-btn {line-height:25px !important;}
    </style>

    <script src="./js/jquery-3.4.1.min.js"></script>
    <script src="./js/jquery.dataTables.min.js"></script>
  </head>
  <body>
    <div class="left-panel-include">
     <%@include file="./header/left-panel.jsp"%> 
    </div>
	   <div class="user-panel-include">
	<%@include file="./header/user-panel.jsp"%>
	</div>
    <div class="user-panel-include"></div>

        <div class="right-section">       
        <div class="container-1100">
        <div id="mspin">
          <h1 class="mspin__title">Reactivate Access key</h1>
            <form  class="mspin__form">
                <input type="text" name="accesskey" id="access_key" class="mspin__search" placeholder="Reactivate Access key" >
                <input type="button"  class="btn blue-btn" value="Activate" onclick="searchMSPIN()" /> </button>
            </form>
            <div class="mspin__data">
                <table class="mspin__table" border="0" cellpadding="0" cellspacing="0">
          
                    <tr>
                        <th>Access Key</th>
                        <td>${accesskey}</td>
                    </tr> 				
				  <tr>
                        <th>Status</th>
                        <td>${status}</td>
                    </tr>
              
                   
                </table>
            </div>
        </div>
        </div>
       </div> 
       <script>
      $(document).ready(function () {
       // $(".left-panel-include").load("/includes/left-panel/left-panel.html");
       // $(".user-panel-include").load("/includes/user-panel/user-panel.html");
      });
	  
	   function searchMSPIN()
  	{
		var search_mspin = $("#search_mspin").val();
		if(search_mspin == ""){
		 swal({   
				  title: "Please enter MSPIN",     
				  showCancelButton: false,
				  confirmButtonColor: "#2D3392",   
				  confirmButtonText: "OK",   
				  closeOnConfirm: true },
				  function(isConfirm){			  
					  return false; 
				}); 
             return false;				
		}
  			document.forms[0].action="./reactivateAcccesskeyPro";
  			document.forms[0].method="post";
  			document.forms[0].submit();
  	}
    </script>
    </body>
    </html>
   <%
 }catch(Exception e)
    {
    	 System.out.println("Errror....."+e);
    	  response.sendRedirect("login");
    }%>   