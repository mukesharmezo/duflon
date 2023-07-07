<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import = "java.util.ResourceBundle" %>
<%
try {
	ResourceBundle resource = ResourceBundle.getBundle("application");
	String baseServer = resource.getString("client.url");String title = resource.getString("app.title");
	String role = "";
	if (session.getAttribute("role") != null) {
		role = session.getAttribute("role").toString().trim();
%>
<!DOCTYPE html>
<html>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="icon" type="image/x-icon" href="<%=baseServer%>img/DuflonFavicon.png"/>
	<title><%=title %></title>
	
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="./css/common.css">
	<link rel="stylesheet" type="text/css" href="./css/sweetalert.css"/>
	<link rel="stylesheet" type="text/css" href="./css/fsdm.css" />
    <link rel="stylesheet" type="text/css" href="css/dashboard-filter.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.12.1/css/jquery.dataTables.min.css">
    <link rel="stylesheet" type="text/css" href="./css/datatable.css">
		<style>
			.btn-primary:not(:disabled):not(.disabled):active{color: #fff;background-color: #DC3545;border-color: #DC3545;}
			a:hover {color: #DC3545;text-decoration: underline;}
			.logout-popup p {font-size: 15px;line-height: 24px;margin: 0 0 35px;color: #000;text-align: center;}
			table.dataTable.stripe>tbody>tr.odd>*, table.dataTable.display>tbody>tr.odd>* {box-shadow:none !important;}
			 .table-date table tr td .btn{width: auto !important;}
		  </style>
		  <script src="./js/jquery-3.4.1.min.js"></script>
		  <script type="text/javascript" src="./js/sweetalert.min.js"></script>
		  <script src="./js/jquery.dataTables.min.js"></script>
		  <script src="https://cdn.datatables.net/fixedcolumns/4.2.1/js/dataTables.fixedColumns.min.js"></script>
		  <script src="./js/datatable.js"></script>
	</head>
<body>
	<div class="left-panel-include">
		<%@include file="./header/left-panel.jsp"%>
	</div>
	<div class="user-panel-include">
		<%@include file="./header/user-panel.jsp"%>
	</div>
	<div class="right-section">
		<h1 class="my-4 text-center">Candidate List Of Current Job</h1>
		<div class="container-1100">
            <div class="table-date">
		<table id="data" cellspacing="0" cellpadding="0" border="0" class="display nowrap cell-border" width="100%">

			<thead>
				<tr>
					<th data-head="Sr. No." style="z-index: 1 !important;"><em>Sr. No.</em></th>
					<th data-head="Name"  class="sorting" style="z-index: 1 !important;"><em>Name</em></th>
					<th data-head="Email"  class="sorting"><em>Email</em></th>
					<th data-head="Mobile"  class="sorting" ><em>Mobile</em></th>
					<th data-head="Match%"   class="sorting"><em>Interview</em></th>
					<th data-head="Skill"  class="sorting" ><em>Skill</em></th>
					<th data-head="Experience"   class="sorting"><em>Experience</em></th>
					<%if(role.equalsIgnoreCase("HRE")) {%>
					<th data-head="Invite Candidate"  class="sorting" ><em>Invite Candidate</em></th><!--  (Open new Link for analysis) -->
					<%} %>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${payloads}" var="payload" varStatus="status">
					<tr>
						<td>${status.count}</td>
						<td>${payload.name}</td>
						<td>${payload.email}</td>
						<td>${payload.mobile}</td>
						<td>${payload.matchPercentage}</td>
						<td>
						<c:forEach items="${payload.skills}" var="skill" >
						<p>${skill.skill}</p>
						</c:forEach>
						</td>
						<td>
						<c:forEach items="${payload.skills}" var="skill">
						<p>${skill.experience}</p>
						</c:forEach>
						</td>
						
						<%if(role.equalsIgnoreCase("HRE")) {%>
							<c:choose>
								<c:when test="${payload.joined>1}">
									  <td><button class="btn btn-primary" disabled>Recruited</button></td>
								</c:when>
								<c:when test="${payload.assessmentStatus == 'Y'}">
									  <td><button class="btn btn-primary" disabled>In Progress</button></td>
								</c:when>
								<c:otherwise>
								  <td><a href="#"><span
								  class="btn btn-primary" onclick="sendEmail('${payload.userId}', '${payload.email}')">
								  <c:if test="${payload.invitationFlag<=1}"> Invite Candidate
								  </c:if>
								  <c:if test="${payload.invitationFlag>1}"> Reinvite Candidate
								  </c:if>
								  </span></a></td>
							  </c:otherwise>
						  </c:choose>
						<%} %>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>
</div>
        <script>
	$(document).ready(function() {
	});
	</script>
      <script>
      	function sendEmail(userId, email){
      		 $.ajax({
                 type: 'GET',
                 url: 'sendInvitationEmail',
                 data: {userId: userId},
                 success: function(msg) {
                	 swal({   
       				  title: "Invitation email has been sent to "+email,     
       				  showCancelButton: false,
       				  confirmButtonColor: "#DC3545",   
       				  confirmButtonText: "OK",   
       				  closeOnConfirm: true },
       				  function(isConfirm){			  
       					location.reload();
       				}); 
                 }
             });
      	}
      </script>
</body>
</html>
<%
} else {
response.sendRedirect("login");
}
} catch (Exception e) {
System.out.println("Errror....." + e);
response.sendRedirect("login");
}
%>