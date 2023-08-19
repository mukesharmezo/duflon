<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import = "java.util.ResourceBundle" %>

<%
try
    {
	ResourceBundle resource = ResourceBundle.getBundle("application");
String baseServer = resource.getString("client.url");String title = resource.getString("app.title");
%>
<!DOCTYPE html>
<html>
<head>
	
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
	<link rel="stylesheet" type="text/css" href="./css/fsdm.css" />
    <link rel="stylesheet" type="text/css" href="css/dashboard-filter.css">
    <link rel="stylesheet" type="text/css" href="./css/jquery.datatable.min.css"/>
    <!-- <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.12.1/css/jquery.dataTables.min.css"> -->
    <link rel="stylesheet" type="text/css" href="./css/datatable.css">

	<style>
        .left-panel > ul > li:nth-child(1) > a, .left-panel > ul > li:nth-child(1) > ul > li:nth-child(1) > a{opacity: 1;}
        .left-panel > ul > li:nth-child(1) > ul > li:nth-child(1) > a::after{content: ''; position: absolute; right: 0; top: 50%; transform: translate(0, -50%); border-right: 6px solid #fff; border-top: 6px solid transparent; border-bottom: 6px solid transparent;}
		.dataTables_scrollBody {overflow-y: hidden !important;overflow-x: auto !important;}  
		/* .dataTables_wrapper .dataTables_filter input{padding: 10px 0px 10px 0px !important;} */
		.table-date table tr th {background: #DC3545 !important;padding-top: 15px;padding-bottom: 15px;}
		.table-date table tr td .btn{padding:5px 10px 4px !important;}
		table.dataTable.stripe>tbody>tr.odd>*, table.dataTable.display>tbody>tr.odd>* {box-shadow:none !important;}
		.btn-success {color: #fff;background-color: #28a745;border-color: #28a745;margin-left: 15px;}
		.description-column {	max-width: 20ch;	white-space: nowrap;	overflow: hidden;	text-overflow: ellipsis;}
   </style>

    <script src="./js/jquery-3.4.1.min.js"></script>
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
		<h1 class="my-4 text-center">Admin Home Page</h1>
		<div class="container-1100">
            <div class="table-date">
		<table id="data" cellspacing="0" cellpadding="0" border="0" class="display nowrap cell-border" width="100%">
			<thead>
				<tr>
					<th data-head="Sr. No." style="z-index: 1 !important;"><em>Sr. No.</em></th>
					<th data-head="Job Title"  class="sorting" style="z-index: 1 !important;"><em>Designation</em></th>
					<th data-head="Description"  class="sorting"><em>Description</em></th>
					<th data-head="Job Post Date"  class="sorting"><em>Job Post Date</em></th>
					<th data-head="HRE Name"  class="sorting"><em>HRE Name</em></th>
					<th data-head="Applicants"  class="sorting"><em>Applicants</em></th>
					<th data-head="Email Invitation"  class="sorting" ><em>Email Invitation</em></th>
					<th data-head="Interview"   class="sorting"><em>Interview</em></th>
					<th data-head="Selected"  class="sorting" ><em>Selected</em></th>
					<th data-head="Joined"   class="sorting"><em>Joined</em></th>
					<th data-head="View Details"  class="sorting" ><em>View Details</em></th><!--  (Open new Link for analysis) -->
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${payloads}" var="payload" varStatus="status">
					<tr>
						<td>${status.count}</td>
						<td>${payload.jobDesignation}</td>
						<td class="description-column">${payload.jobDescription}</td>
						<td>${payload.jobPostDate}</td>
						<td>${payload.hreName}</td>
						<td>${payload.applicants}</td>
						<td>${payload.emails}</td>
						<td>${payload.interview}</td>
						<td>${payload.selected}</td>
						<td>${payload.joined}</td>
						<td><a href="jobAnalysis?jobId=${payload.jobId}"><span
								class="btn btn-primary">View Details</span></a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	</div>
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