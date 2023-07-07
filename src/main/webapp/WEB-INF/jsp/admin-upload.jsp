<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.ResourceBundle"%>
<%
try {
	ResourceBundle resource = ResourceBundle.getBundle("application");
	String baseServer = resource.getString("client.url");
	String title = resource.getString("app.title");
/* 	if (session.getAttribute("role") != null) {
		String role = session.getAttribute("role").toString().trim();
		String st = ""; */
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" type="image/x-icon"
	href="<%=baseServer%>img/DuflonFavicon.png" />
<title><%=title%></title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="./css/common.css">
<link rel="stylesheet" type="text/css" href="./css/fsdm.css" />
<link rel="stylesheet" type="text/css" href="css/dashboard-filter.css">
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/1.12.1/css/jquery.dataTables.min.css">
<link rel="stylesheet" type="text/css" href="./css/datatable.css">
<style>
.left-panel>ul>li:nth-child(1)>a, .left-panel>ul>li:nth-child(1)>ul>li:nth-child(1)>a
	{	opacity: 1}

.left-panel>ul>li:nth-child(1)>ul>li:nth-child(1)>a::after {	content: '';	position: absolute;	right: 0;	top: 50%;	transform: translate(0, -50%);	border-right: 6px solid #fff;	border-top: 6px solid transparent;	border-bottom: 6px solid transparent;}
.dataTables_scrollBody {	overflow-y: hidden !important;	overflow-x: auto !important;}
.table-date table tr th {	background: #DC3545 !important;	padding-top: 15px;	padding-bottom: 15px;}
.table-date table tr td .btn {	padding: 5px 10px 4px !important;}
table.dataTable.stripe>tbody>tr.odd>*, table.dataTable.display>tbody>tr.odd>*
	{	box-shadow: none !important;}
.btn-success {	color: #fff;	background-color: #DC3545 !important;	border-color: #DC3545 !important;	margin-left: 15px;	font-size: 17px;	font-weight: 900;	border: 1px solid transparent;	padding: 0.375rem 0.75rem;	border-radius: 2rem;}
.btn-success:hover {	background-color: #DC3545 !important;	border-color: #DC3545 !important;}
label.col-sm-2.col-form-label {	font-weight: 500;	font-size: 15px;	line-height: 18px;	margin: 0 0 9px;	position: relative;}
.btn-primary {	margin-right: 315px !important;	color: #fff;	background-color: #DC3545;	border-color: #DC3545;	margin-left: 15px;}
.btn-primary:hover {	background-color: #DC3545;	border-color: #DC3545;}
#dealerId[disabled] {	opacity: 0.6;	height: auto;}
select {	padding: 5px;}
select option {	padding: 5px;}
h2 {	text-align: center;	margin-bottom: 30px;	margin-top: 15px;}
label {	font-weight: 500;	font-size: 15px;	display: inline-block;	line-height: 18px;	margin: 0 0 9px;}
.form {	background: #fff;	border-radius: 5px;	border: 1px solid #E5E5E5;	padding: 30px;	box-sizing: border-box;	margin-bottom: 50px !important;}
.form .form-section {	display: flex;	flex-wrap: wrap;}
.form .form-section .form-block {	margin: 0 15px 25px;	width: calc(33.33% - 30px)}
.form .form-section .form-block input[type="text"], .form .form-section .form-block input[type="email"],
	.form .form-section .form-block input[type="tel"], .form .form-section .form-block input[type="number"],
	.form .form-section .form-block input[type="date"], .form .form-section .form-block select,
	.form .form-section .form-block textarea {	width: 100%;	background: #F7F7F7;	border: 1px solid #D0D0D0;	border-radius: 7px;	color: #4D4D4D;	padding: 9px 15px;	font-size: 15px;	font-family: Arial !important;	line-height: 18px;	outline: none;	box-sizing: border-box;}
.form .error {	color: #f00 !important;	margin: 5px 0 0;	font-size: 11px;	line-height: 13px;}
.form .form-section .form-block.error input[type="text"], .form .form-section .form-block.error input[type="email"],
	.form .form-section .form-block.error input[type="tel"], .form .form-section .form-block.error input[type="number"],
	.form .form-section .form-block.error input[type="date"], .form .form-section .form-block.error select
	{	border-color: #f00 !important;}
.form .form-section .form-block input[type="date"] {	text-transform: uppercase;}
/* .btn-danger{width: 30px;border-radius: 15px;font-size: 17px;font-weight: 900;border: 1px solid transparent;} */
.btn-danger {	color: #fff;	background-color: #DC3545 !important;	border-color: #DC3545 !important;	margin-left: 15px;	font-size: 17px;	font-weight: 900;	border: 1px solid transparent;	padding: 0.375rem 0.75rem;	border-radius: 2rem;}
.btn-danger:hover {	color: #fff;	background-color: #DC3545;	border-color: #DC3545 !important;}
button.btn.btn-primary {	min-width: 110px;}
.description-column {	max-width: 20ch;	white-space: nowrap;	overflow: hidden;	text-overflow: ellipsis;}
</style>


<script src="./js/jquery-3.4.1.min.js"></script>
<script src="./js/jquery.validate.js"></script>
<script src="./js/jobPortal.js"></script>
<script src="./js/jquery.dataTables.min.js"></script>
<script
	src="https://cdn.datatables.net/fixedcolumns/4.2.1/js/dataTables.fixedColumns.min.js"></script>
<script src="./js/datatable.js"></script>
</head>
<body>

	<div class="left-panel-include">
		<%@include file="./header/left-panel.jsp"%>
	</div>
	<div class="user-panel-include">
		<%@include file="./header/user-panel.jsp"%>
	</div>
	<!-- <div class="container mt-4"> -->
	<div class="right-section">
		<!-- <h1 class="text-center">Job Creator</h1> -->
		<h2>Upload Admin Data</h2>
		<form action="uploadAdminData" class="form" method="post" id="jobPage" enctype="multipart/form-data">
			<div class="form-section">
			<div class="form-block">
  					<label for="resumeFile">Upload Resume</label> 
  					<input type="file" name="file" id="adminFile" class="form-control-file" accept=".xlsx" />
  					 <small class="form-text text-muted">Accepted file types: PDF, DOC, DOCX. Maximum file size: 2MB.</small>
				</div>
				</div>
			<div class="form-group row">
				<div class="col-sm-9 offset-sm-3 text-center">
					<button type="submit" class="btn btn-primary">Upload</button>
				</div>
			</div>
		</form>
		<hr class="my-5">
	</div>
	<script>
		// Initialize the jQuery validation plugin
		$(document).ready(function() {
			
		});
	</script>
</body>
</html>
<%
/* } else {
response.sendRedirect("login");
} */
} catch (Exception e) {
response.sendRedirect("login");
}
%>
