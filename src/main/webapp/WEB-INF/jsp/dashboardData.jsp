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
              String assessUrl = resource.getString("client.asseesment");
HttpSession s = request.getSession();
s.setAttribute("remove_final", "final");
%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
    <link rel="icon" type="image/x-icon" href="<%=baseServer%>img/DuflonFavicon.png"/>

    <title><%=title %></title>
    <link rel="stylesheet" type="text/css" href="./css/common.css" />
    <link rel="stylesheet" type="text/css" href="./css/hiring-in-process.css" />
    <link rel="stylesheet" type="text/css" href="./css/jquery.datatable.min.css"/>
    <link rel="stylesheet" type="text/css" href="./css/datatable.css">

    <script src="./js/jquery-3.4.1.min.js"></script>
    <script src="./js/jquery.dataTables.min.js"></script>
	<script src="./js/datatable.js"></script>
    <style>
		.dataTables_scrollBody {overflow-y: hidden !important;overflow-x: auto !important;}  
		.table-date {    margin: 10px;}
		h1 {    text-align: center;}
    </style>
  </head>
  <body>
        <div class="container-1100">
  <h1  >Dashboard Data</h1>
            <div class="table-date">
                <table id="data" cellspacing="0" cellpadding="0" border="0" class="display nowrap cell-border" style="width: 100% !important">
                    <thead>
                        <tr>
                           <th data-head="Sr. No." style="z-index: 1 !important;"><em>Sr. No.</em></th>
							<th data-head="Candidate Name" class="sorting" style="z-index: 1 !important;"><em>Candidate Name</em></span></th>
							<th data-head="Designation" class="sorting"><em>Designation</em></span></th>
							<th data-head="Mobile Number" class="sorting"><em>Mobile Number</em></th>
							<th data-head="Access Key" class="sorting"><em>Access Key</em></th>
							<th data-head="Registration Date" class="sorting"><em>Registration Date</em></th>
							<th data-head="Assessment Date" class="sorting"><em>Assessment Date</em></th> 
                            <th data-head="Marks Obtained" class="sorting"><em>Marks Obtained</em></th>				
                            <th data-head="Assessment Status" class="sorting"><em>Assessment Status</em></th>
							<th data-head="Candidate Status" class="sorting"><em>Candidate Status</em></th>
                           
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${participantList}" var="participant" varStatus="status">
                        <tr>
                            <td>${status.count}</td>
                            <td>${participant.participantName }</td>
							<td>${participant.designation}</td>
							<td>${participant.mobile}</td>
							<td>${participant.accesskey}</td>
							<td>${participant.dateOfRegistration}</td>
						<c:choose>
							<c:when  test="${empty participant.assessment_Completion_date}">
							<td><span >NA</span></td>
							</c:when>
							<c:when test="${not empty participant.assessment_Completion_date}">
							<td>${participant.assessment_Completion_date}</td>
							</c:when>
							</c:choose>
							 <c:choose>
							 <c:when  test="${empty participant.assessment_Completion_date && empty participant.testScore }">
							<td><span >NA</span></td>
							</c:when>
                               <c:when test="${participant.passFailStatus == '1' }">
							    <td><span class="green">${participant.testScore} </span></td>
								 </c:when>
                               <c:when test="${participant.passFailStatus == '0' }">
							    <td><span class="red">${participant.testScore} </span></td>
								</c:when>
							    </c:choose>
							
							 <c:choose>
                               <c:when test="${participant.passFailStatus == '1' }">
                                  <td><span class="green">Pass</span></td>
                               </c:when>
                               <c:when test="${not empty participant.assessment_Completion_date  && participant.passFailStatus == '0' }">
                                  <td ><span class="red" >Fail</span> </td>
                               </c:when>
							 <c:when test="${empty participant.assessment_Completion_date && participant.passFailStatus == '0' }">
                                  <td ><span >NA</span> </td>
                               </c:when>
                               </c:choose>	
							    <td>${participant.status}</td>			
                        </tr>
                        </c:forEach>
                    </tbody>
                </table>
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
