<!-- <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="icon" type="image/x-icon" href="https://www.irecruit.org.in/irecruit/img/iRecruit-favicon.ico"/>
<title>iRecruit</title>
</head>
<body>

</body>
</html> -->
<%@ page import = "java.util.ResourceBundle" %>

<%
try
    {
	ResourceBundle resource = ResourceBundle.getBundle("application");
String baseServer = resource.getString("client.url");
	%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<link rel="icon" type="image/x-icon" href="<%=baseServer%>img/iRecruit-favicon.ico"/>   <title>iRecruit</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="./css/common.css" />
    <link rel="stylesheet" type="text/css" href="./css/sweetalert.css"/>
    <script type="text/javascript" src="./js/sweetalert.min.js"></script>
	
    <link rel="stylesheet" type="text/css" href="./css/mspin.css" />
    <link rel="stylesheet" type="text/css" href="./css/hiring-in-process.css" />
     <script src="./js/jquery-3.4.1.min.js"></script>
    <style>
         .left-panel > ul > li:nth-child(2) > ul > li:nth-child(1) a {opacity: 1;}
         .left-panel > ul > li:nth-child(2) > ul > li:nth-child(1) a::after{content: ''; position: absolute; right: 0; top: 50%; transform: translate(0, -50%); border-right: 6px solid #fff; border-top: 6px solid transparent; border-bottom: 6px solid transparent;}
         .analysis__table tr th {
    width: 19% !important;
    font-weight: 500;
    font-size: 15px;
    line-height: 20px;
    color: #2D3392;
    padding: 20px;
    width: 150px;
    box-sizing: border-box;
    background-color: #F8F8F8;
    border-bottom: 1px solid #EBEBEB;
    text-align: left;
}
#analysis{margin: 50px auto 50px;
    /* max-width: 680px; */
    max-width: 780px;
}
.analysis__title{    margin: 30px 0 35px;
    font-weight: 500;
    font-size: 24px;
    line-height: 32px;
    color: #000;
    text-align: center;
}
.mspin__title {
    text-align: center;}
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
        <div id="analysis">
            <h1 class="analysis__title">Question Bank Analysis</h1>
            <!-- <form  class="mspin__form">
                <input type="text" name="mspin" id="search_mspin" class="mspin__search" placeholder="Enter MSPIN" maxlength="10" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
                <input type="button"  class="btn blue-btn" value="Search" onclick="searchMSPIN()" /> <i class="fa fa-search"></i></button>
            </form> -->
            <div class="analysis__data">
                <table class="analysis__table" border="0" cellpadding="0" cellspacing="0">
          
                    <tr>
                        <th>Question ID</th>
                        <!-- <td>${search_mspin}</td> -->
                    </tr> 				
				  <tr>
                        <th>Topic</th>
                        <!-- <td>${mName}</td> -->
                    </tr>
                  <tr>
                        <th>Sub Topic</th>
                        <!-- <td>${emailID}</td> -->
                    </tr>
                    <tr>
                        <th>Chapter</th>
                        <!-- <td>${desgination}</td> -->
                    </tr>
					
                    <tr>
                        <th>Question Type</th>
                        <!-- <td>${MStatus}</td> -->
                    </tr>

                    <tr>
                        <th>Difficulty Level</th>
                        <!-- <td>${empLeavingDate}</td> -->
                    </tr>

                    <tr>
                        <th>Question</th>
                        <!-- <td>${empLeavingDate}</td> -->
                    </tr>

                    <tr>
                        <th>Option 1</th>
                        <!-- <td>${empLeavingDate}</td> -->
                    </tr>

                    <tr>
                        <th>Option 2</th>
                        <!-- <td>${empLeavingDate}</td> -->
                    </tr>

                    <tr>
                        <th>Option 3</th>
                        <!-- <td>${empLeavingDate}</td> -->
                    </tr>

                    <tr>
                        <th>Option 4</th>
                        <!-- <td>${empLeavingDate}</td> -->
                    </tr>

                    <tr>
                        <th>Total Option</th>
                        <!-- <td>${empLeavingDate}</td> -->
                    </tr>

                    <tr>
                        <th>Correct Option</th>
                        <!-- <td>${empLeavingDate}</td> -->
                    </tr>

                    <tr>
                        <th>Total Displayed</th>
                        <!-- <td>${empLeavingDate}</td> -->
                    </tr>
                          
                     <tr>
                        <th>Correct Attempt</th>
                    </tr>

                    <tr>
                        <th>Wrong Attempt</th>
                    </tr>

                    <tr>
                        <th>No Attempt</th>
                    </tr>

                    <tr>
                        <th>Success Rate</th>
                    </tr>
                   
                </table>
            </div>
        </div>
        </div>
       </div> 
       <%
 }catch(Exception e)
    {
    	 System.out.println("Errror....."+e);
    	  response.sendRedirect("login");
    }%>
       
