<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import = "java.util.ResourceBundle" %>

<%
try
    {
	ResourceBundle resource = ResourceBundle.getBundle("application");
String baseServer = resource.getString("client.url");String title = resource.getString("app.title");
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title><%=title %></title>
    <link rel="stylesheet" type="text/css" href="./css/common.css" />
    <link rel="stylesheet" type="text/css" href="./css/hiring-in-process.css" />
	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.12.1/css/jquery.dataTables.min.css">
    <link rel="stylesheet" type="text/css" href="./css/datatable.css">
    <link href='https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/ui-lightness/jquery-ui.css' rel='stylesheet'>
    
    <style>
        .left-panel > ul > li:nth-child(2) > a, .left-panel > ul > li:nth-child(2) > ul > li:nth-child(2) > a{opacity: 1;}
        .left-panel > ul > li:nth-child(2) > ul > li:nth-child(2) > a::after{content: ''; position: absolute; right: 0; top: 50%; transform: translate(0, -50%); border-right: 6px solid #fff; border-top: 6px solid transparent; border-bottom: 6px solid transparent;}
    </style>
    <style>
        .ui-datepicker {
            width: 12em; 
        }
        h1{
            color:green;
        }
    </style>

    <script src="./js/jquery-3.4.1.min.js"></script>
   
  </head>
  <body>
    <div class="left-panel-include">
    <%@include file="./header/left-panel.jsp"%> 
    </div>
    <div class="user-panel-include">
	<%@include file="./header/user-panel.jsp"%>
	</div>

        <div class="right-section">
 
        <h1>Details CSV Report Generate</h1>
        <div class="container-1100">
            
                <form action="detailedCSV" method="post"><br><br>
                Start Date: <input type="text" id="picker1" name="date1"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          End Date: <input type="text" id="picker2" name="date2"><br><br>
                <input type="submit" value="Generate Detailed CSV"/>
                </form>
            
  </div>
  </div>
  
    </body>  
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js">
        </script>
        <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js">
        </script>
        <script>
            $(document).ready(function() {
  
                $(function() {
                    $("#picker1").datepicker({});
                });
  
                $(function() {
                    $("#picker2").datepicker({});
                });
  
                $('#picker1').change(function() {
                    startDate = $(this).datepicker('getDate');
                    $("#picker2").datepicker("option", "minDate", startDate);
                })
  
                $('#picker2').change(function() {
                	var x = document.getElementById("picker1").value;
                    endDate = $(this).datepicker('getDate');
                    $("#picker1").datepicker("option", "maxDate", endDate);
                })
            })
        </script>

</html>
<%
 }catch(Exception e)
    {
    	 System.out.println("Errror....."+e);
    	  response.sendRedirect("login");
    }%>
