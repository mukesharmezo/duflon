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
String baseServer = resource.getString("client.url");String title = resource.getString("app.title");
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
	 <link rel="icon" type="image/x-icon" href="<%=baseServer%>img/DuflonFavicon.png"/>  <title><%=title %></title>
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
            <h1 class="mspin__title">Search Old MSPIN</h1>
            <form  class="mspin__form">
                <input type="text" name="mspin" id="search_mspin" class="mspin__search" placeholder="Enter MSPIN" maxlength="10" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
                <input type="button"  class="btn blue-btn" value="Search" onclick="searchMSPIN()" /> <!-- <i class="fa fa-search"></i> --></button>
            </form>
            <div class="mspin__data">
                <table class="mspin__table" border="0" cellpadding="0" cellspacing="0">
          
                    <tr>
                        <th>MSPIN</th>
                        <td>${search_mspin}</td>
                    </tr> 				
				  <tr>
                        <th>Name</th>
                        <td>${mName}</td>
                    </tr>
                  <!--  <tr>
                        <th>Email ID</th>
                        <td>${emailID}</td>
                    </tr> -->
                    <tr>
                        <th>Designation</th>
                        <td>${desgination}</td>
                    </tr>
					
                    <tr>
                        <th>Current Status</th>
                        <td>${MStatus}</td>
                    </tr>
					
					 <c:choose>
                               <c:when test="${(mName  eq '' || mName eq null)  && (not empty message)}">
							    <tr>
                        <th>Message</th>
                        <td>MSPIN Does not exist</td>
                    </tr>
							   </c:when>
							    </c:choose>
                   
					
                    <tr>
                        <th>Date of Leaving</th>
                        <td>${empLeavingDate}</td>
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
				  confirmButtonColor: "#DC3545",   
				  confirmButtonText: "OK",   
				  closeOnConfirm: true },
				  function(isConfirm){			  
					  return false; 
				}); 
             return false;				
		}
  			document.forms[0].action="./searchMspinPro";
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