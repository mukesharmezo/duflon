<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.util.ResourceBundle" %>

<%
try
    {
	ResourceBundle resource = ResourceBundle.getBundle("application");
String baseServer = resource.getString("client.url");String title = resource.getString("app.title");
 String assessUrl = resource.getString("client.asseesment");
	%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
	  <link rel="icon" type="image/x-icon" href="<%=baseServer%>img/DuflonFavicon.png"/>  <title><%=title %></title>
    <link rel="stylesheet" type="text/css" href="./css/common.css" />
    <link rel="stylesheet" type="text/css" href="./css/fsdm.css" />
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.12.1/css/jquery.dataTables.min.css">
    <link rel="stylesheet" type="text/css" href="./css/datatable.css">
    <script src="https://staging.irecruit.org.in/irecruit/js/jquery-3.4.1.min.js"></script>
    <style> 
    
		.dataTables_scroll{padding: 5px 0px 0px 0px;}
        .dataTables_scrollBody{position: relative;overflow: auto;width: 100%;max-height: 425px !important;}
        .export-to-csv .ecsvbutton {background: #DC3545 !important;color: #fff !important;}
        .export-to-csv{right: 0 !important;padding: 20px 0px 0px 0px !important;}
	    .csv-icn-button{font-family: Arial;display: inline-block;padding: 9px 17px 9px 15px;font-size: 13px !important;line-height: 18px;border:1px solid #DC3545;color: #fff;border-radius: 30px;cursor: pointer;position: relative;background-color: #DC3545;text-decoration: none;}
 
        /* .left-panel > ul > li:nth-child(1) > a, .left-panel > ul > li:nth-child(1) > ul > li:nth-child(1) > a{opacity: 1;}
        .left-panel > ul > li:nth-child(1) > ul > li:nth-child(1) > a::after{content: ''; position: absolute; right: 0; top: 50%; transform: translate(0, -50%); border-right: 6px solid #fff; border-top: 6px solid transparent; border-bottom: 6px solid transparent;} */
        .heading-section{ text-align: center !important;margin-bottom:30px ;}
        .upload-section{display: flex; text-align: center;}
        #select-option{text-align: center;width: 100%;background: #F7F7F7;border: 1px solid #D0D0D0;border-radius: 7px;color: #4D4D4D;padding: 11px 15px;font-size: 13px;line-height: 18px;outline: none;box-sizing: border-box;margin-bottom: 10px;max-width: 290px;}
        /* #Analysisdiv{display: inline-block;justify-content: center;border-top: 1px solid #EBEBEB;} */
        .search-btn{background-color: #fff !important;color: #DC3545 !important;border: 1px solid #DC3545 !important;font-size: 12px;line-height: 16px;text-decoration: none;border: none;padding: 11px 15px;border-radius: 30px;cursor: pointer;width: 87px;}
        .reset-btn{margin: 0 10px;font-size: 12px;text-decoration: none;border: none;padding: 11px 15px;background-color: #DC3545;border: 1px solid #DC3545;border-radius: 30px;cursor: pointer;width: 87px;}
        .upload-section{text-align: left;}
        div#Analysisdiv {padding: 0px 0px 0px 10px;}
        .Question option{width: 100%;;}
        .que-option{display: flex;justify-content: center;}
        .button{margin-top: 45px;}
        .table-body.txt1{padding-left:15px !important;text-align: center !important;}
        .right-section{padding-right: 0 !important;}
        a.badge.badge-primary {display: inline-block;padding: 9px 17px 9px 15px;font-size: 13px;line-height: 18px;border: 1px solid #DC3545;color: #DC3545;border-radius: 30px;cursor: pointer;position: relative;background-color: #fff;text-decoration: none;}
    </style>
  </head>
  <body>
    <div class="left-panel-include">
     <%@include file="./header/left-panel.jsp"%> 
    </div>
    <div class="user-panel-include">
      <%@include file="./header/user-panel.jsp"%>
    </div>
 
 
        <div class="right-section">
        <h3 style="margin-top: 25px !important;">Question Wise Analysis</h3>
          <a href="<%=baseServer%>showAllLinksCSV?flag" class="csv-icn-button">Back to report</a>
          
		<embed src="<%=assessUrl%>pa/questionWiseReport"
               width="100%" 
               height="900px"  scrolling="no" />
          
   
    </div>

    <div class="blk-bg"></div>
   
  </body>

</html>
<%
 }catch(Exception e)
    {
    	 System.out.println("Errror....."+e);
    	  response.sendRedirect("login");
    }%>
