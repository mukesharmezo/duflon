<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import = "java.util.ResourceBundle" %>

<%
try
    {
	ResourceBundle resource = ResourceBundle.getBundle("application");
String baseServer = resource.getString("client.url");
	%>

  <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.12.1/css/jquery.dataTables.min.css">
  <link rel="stylesheet" type="text/css" href="./css/datatable.css">
  <script src="./js/jquery.dataTables.min.js"></script>
  <script src="https://cdn.datatables.net/fixedcolumns/4.2.1/js/dataTables.fixedColumns.min.js"></script>
  <link rel="icon" type="image/x-icon" href="<%=baseServer%>img/iRecruit-favicon.ico"/>
 
	 <h3>Overview</h3>
		<div class="table-date">
		
			<div class="export-to-csv"><input type="button" onclick="funexport()" class="ecsvbutton" value="Export To CSV"></div>
			<table id="data" cellspacing="0" cellpadding="0" border="0" class="stripe display nowrap cell-border" width="50" style="width: 100% !important;height: auto !important;padding:4px">
			<!-- <table id="data" cellspacing="0" cellpadding="0" border="0" class="display nowrap cell-border" width="50" style="width: 100% !important;height: auto !important;"> -->
                    <thead>
                        <tr>
                            <th data-head="Sr.No." class="sorting" style="z-index: 1 !important;"><em>Sr.No.</em></th>
							<th data-head="Candidate Name" class="sorting" style="z-index: 1 !important;"><em>Candidate Name</em></th>
							<!-- <th data-head="Designation" class="sorting"><em>Designation</em></th> -->
							<th data-head="Profile" class="sorting"><em>Profile</em></th>

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
                    <%int i=1; %>
                    <c:forEach items="${participantList}" var="participant">
                        <tr>
                            <td><%=i %></td>
							<td>${participant.participantName }</td>
							<td>${participant.designation}</td>
							<td>${participant.mobile}</td>
							<td>${participant.accesskey}</td>
							<td>${participant.dateOfRegistration}</td>
						<!--	<td>${participant.assessment_Completion_date}</td>        -->
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
                    <%i++; %>
                    </c:forEach>
                    </tbody>
                   
                    
                    
                    </table>   <!-- TBL -->
		</div> <!-- TableData -->
 
 
 <script >
  $(document).ready(function () {
  
    var table = $('#data').DataTable({
        "pageLength": 10,
        scrollY: '444px',
        scrollCollapse: true,
        scrollX: true,
		fixedColumns:   {
            left: 2
        }
    });

	 

    // var dt = $('#data').DataTable();
    // dt.columns([0,2]).visible(false);
});
  </script>
  <%
 }catch(Exception e)
    {
    	 System.out.println("Errror....."+e);
    	  response.sendRedirect("login");
    }%>