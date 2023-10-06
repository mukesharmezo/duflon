<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.ResourceBundle"%>

<%
try {
	ResourceBundle resource = ResourceBundle.getBundle("application");
	String baseServer = resource.getString("client.url");
	String title = resource.getString("app.title");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" type="image/x-icon"
	href="<%=baseServer%>img/DuflonFavicon.png" />
<title><%=title%></title>
<script src="./js/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="./js/sweetalert.min.js"></script>
<script src="./js/jquery.validate.js"></script>
<script src="./js/additional-methods.js"></script>
<script src="./js/moment.min.js"></script>
<script src="./js/jobPortal.js"></script>
<script src="./js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/fixedcolumns/4.2.1/js/dataTables.fixedColumns.min.js"></script>
<script src="./js/datatable.js"></script>
<link rel="stylesheet" type="text/css" href="./css/common.css">
<link rel="stylesheet" type="text/css" href="./css/sweetalert.css"/>
<link rel="stylesheet" href="./css/scrolltabs.css">
<link rel="stylesheet" type="text/css"	href="./css/family-member-details.css" />
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.12.1/css/jquery.dataTables.min.css">
    <link rel="stylesheet" type="text/css" href="./css/datatable.css">
<!-- <link rel="stylesheet"	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
 -->
<style>
.form {	background: #fff;	border-radius: 5px;	border: 1px solid #E5E5E5;	padding: 30px;	box-sizing: border-box;	margin-bottom: 50px !important;}
.form .form-section {	display: flex;	flex-wrap: wrap;}
.form .form-section .form-block {	margin: 0 15px 25px;	width: calc(33.33% - 30px)}
.form .form-section .form-block input[type="text"], .form .form-section .form-block input[type="email"], .form .form-section .form-block input[type="file"],
	.form .form-section .form-block input[type="tel"], .form .form-section .form-block input[type="number"],
	.form .form-section .form-block input[type="date"], .form .form-section .form-block select,
	.form .form-section .form-block textarea {	width: 100%;	background: #F7F7F7;	border: 1px solid #D0D0D0;	border-radius: 7px;	color: #4D4D4D;	padding: 9px 15px;	font-size: 15px;	font-family: Arial !important;	line-height: 18px;	outline: none;	box-sizing: border-box;}
.form .error {	color: #f00 !important;	margin: 5px 0 0;	font-size: 11px;	line-height: 13px;}
.form .form-section .form-block.error input[type="text"], .form .form-section .form-block.error input[type="email"],
	.form .form-section .form-block.error input[type="tel"], .form .form-section .form-block.error input[type="number"],
	.form .form-section .form-block.error input[type="date"], .form .form-section .form-block.error select{	border-color: #f00 !important;}
.form .form-section .form-block input[type="date"] {	text-transform: uppercase;}
.btn-primary {	color: #fff;	background-color: #DC3545;	border-color: #DC3545;	margin-left: 15px;	padding: 11px 0px;	flex-grow: 1;}
.btn-primary:hover {	background-color: #DC3545 !important;	border-color: #DC3545 !important;}
.center {	display: flex;	justify-content: center;	margin-top: 20px;}
.form .form-section .form-block input[type="button"] { width: 60%;	border: 1px solid #D0D0D0;	border-radius: 7px;	padding: 9px 15px;	font-size: 15px;	font-family: Arial !important;	line-height: 18px;	outline: none;	box-sizing: border-box; }
.details-column {	max-width: 20ch;	white-space: nowrap;	overflow: hidden;	text-overflow: ellipsis;}

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
		<br> <br>
		<h2 class="text-center" style="font-size: 32px;">Admin Module</h2>
		<br>
		<div class="div-button" style="display: flex;">
		<button class="btn btn-primary" id="pass-btn">Assessment Bypass</button>
		<button class="btn btn-primary" id="delete-btn">Delete Participant</button>
		<button class="btn btn-primary" id="error-logger-btn">Error Logger</button>
		<button class="btn btn-primary" id="upload-btn">Upload Data</button>
		</div>
		<br>
		<div id="upload-page" class="page" style="display: none;">
			<form id="upload-form" class="form" enctype="multipart/form-data">
				<div class="form-section">
					<div class="form-block">
						<label for="adminType">Admin Type</label>
						<select id="adminType" name="adminType">
							<option value="">Select</option>
							<option value="SA">Super Admin</option>
							<option value="LM">Line Manager</option>
							<option value="HRE">HRE</option>
						</select>
					</div>
					<div class="form-block">
  						<label for="dataFile">Upload Data</label> 
  						<input type="file" name="dataFile" id="dataFile" class="form-control-file" accept=".xlsx" />
  					 	<small class="form-text text-muted">Accepted file types: XLSX.</small>
					</div>
					<div class="form-block">
					<br>
					<input type="button" id="download-button" class="submit-btn" value="Template Download">
					<iframe id="downloadFrame" style="display: none;"></iframe>
					<!-- <button type="button" class="submit-btn" id=download-button>Download template</button> -->
					</div>
				</div>
				<div class="center">
					<button type="button" class="submit-btn" id=upload-submit-button>Upload</button>
				</div>
			</form>
		</div>
		<div id="pass-page" class="page" style="display: none;">
			<form id="pass-form" class="form">
				<div class="form-section">
					<div class="form-block">
						<label for="accesskey">Access Key:</label> <input type="text"
							id="accesskey" name="accesskey">
					</div>
					<div class="form-block">
						<label for="testScore">Test Score:</label> <input type="number"
							id="testScore" name="testScore">
					</div>
					<div class="form-block">
						<label for="testStatus">Test Status:</label> <select
							id="testStatus" name="testStatus">
							<option value="">Select</option>
							<option value="1">Pass</option>
							<option value="0">Fail</option>
						</select>
					</div>
					<div class="form-block">
						<label for="totalMark">Total Mark:</label> <input type="number"
							id="totalMark" name="totalMark">
					</div>
					<div class="form-block">
						<label for="section_1">Section 1:</label> <input type="number"
							id="section_1" name="section_1">
					</div>
					<div class="form-block">
						<label for="section_2">Section 2:</label> <input type="number"
							id="section_2" name="section_2">
					</div>
				</div>
				<div class="center">
					<button type="button" class="submit-btn" id=pass-submit-button>Update</button>
				</div>
			</form>
		</div>
		<div id="delete-page" class="page" style="display: none;">
			<form id="find-form" class="form">
				<div class="form-section">
					<div class="form-block">
						<label for="accesskey">Access Key:</label> 
						<input type="text" id="accesskey2" name="accesskey">
					</div>
				</div>
					<div class="center">
					<button type="button" class="submit-btn" id=delete-button>Delete</button>
				</div>
			</form>
		</div>
		<div id="error-logger-page" style="display: none;" class="table-date page">
			<table id="data" cellspacing="0" cellpadding="0" border="0" class="stripe display nowrap cell-border" style="width: 100% !important">
				<thead>
					<tr>
						<th data-head="Sr. No." class="sorting"><em>Sr. No.</em></th>
						<th data-head="Access Key" class="sorting"><em>Access Key</em></th>
						<th data-head="Date and Time" class="sorting"><em>Date and Time</em></th>
						<th data-head="Message" class="sorting"><em>Message</em></th>
						<th data-head="Process" class="sorting"><em>Process</em></th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${errors}" var="error" varStatus="status">
					<tr>
					<td>${status.count}</td>
					<td>${error.accesskey}</td>
					<td>${error.errorDateTime}</td>
					<td class="details-column">${error.errorMessage}</td>
					<td>${error.errorProcess}</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	<div class="delete-popup">
        <p>Are you sure, you want to delete participant data?</p>
        <div class="form-button">
            <button class="cancel-btn outline-btn" onclick="No()">No</button>
            <button class="submit-btn" onclick="deleteParticipant()">Yes</button>
            <input type="hidden"  value="" id="reAttempAccesskey">
        </div>
    </div>
    <div class="hold-popup">
        <p></p>
        <div class="form-button">
            <button class="submit-btn" onclick="closePopup()">Ok</button>
        </div>
    </div>
    <div class="blk-bg"></div>
	<script>
		$(document).ready(function() {
			$(".btn.btn-primary").click(function() {
			    var targetPage = $(this).attr("id").replace("-btn", "-page");
			    $(".page").hide();
			    $("#" + targetPage).show();
			});
			
			$("#delete-button").click(function(){
				$('.delete-popup, .blk-bg').show();
			});
			
			$("#upload-submit-button").click(function() {
				event.preventDefault();
				var form = $('#upload-form')[0];
				var formData = new FormData(form);
				$.ajax({
					type : 'POST',
					enctype: 'multipart/form-data',
					url : 'uploadAdminData',
					data : formData,
					processData : false,
					contentType : false,
					success : function(res){
						swal({
							title : "Data Uploaded Successfully",
							icon: "success"
						});
						$(form).find('input, select').val('');   // Make All Fields Empty
					},
					error : function(){
						console.log('Error in uploading');
					}
				});
			});
			$('#download-button').click(function () {
				
				document.forms[0].action="./pdfTemplateDownload";
	   			document.forms[0].method="post";
	   			document.forms[0].submit();
				
				/* console.log('Clicked');
			 	$.ajax({
					type : 'get',
					url : 'pdfTemplateDownload',
					xhrFields: {
                        responseType: 'blob' // Set the response type to blob
                    },
					success: function (data) {
						  console.log('Downloaded');
						  var blob = new Blob([data], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });
	                        var url = URL.createObjectURL(blob);

	                        // Create a temporary link and trigger the download
	                        var link = document.createElement('a');
	                        link.href = url;
	                        link.download = 'AdminTemplate.xlsx';
	                        link.style.display = 'none';
	                        document.body.appendChild(link);
	                        link.click();
						},
						error : function (error) {
							console.log('Error while downloading');
						}
				}); */
			});
			
			$("#pass-submit-button").click(function() {
				event.preventDefault();
				var formData = $('#pass-form').serialize();
				var form = $(this);
				$.ajax({
					type : 'POST',
					url : 'updateTestStatus',
					data : formData,
					success : function(response) {
						console.log('Form submitted successfully');
						//form[0].reset();
						form.find('input, textarea, select').val('');
						$("#pass-page").hide();
					},
					error : function(xhr, status, error) {
						console.log('Form submission failed');
					}
				});
			});

		});
		
		function No(){
	    	  $('.delete-popup, .blk-bg').hide(); 
	      }
		
		function closePopup(){
	    	  $('.hold-popup, .blk-bg').hide(); 
	      }
		
		function deleteParticipant(){
			$('.delete-popup, .blk-bg').hide();
			var accessKey = $("#accesskey2").val();
			$.ajax({
				type : 'GET',
				url : 'deleteCandidate',
				data : { accesskey : accessKey},
				success : function(data){
			$('.hold-popup, .blk-bg').show();
			var pElement = $('.hold-popup p');
			pElement.text(data);
					console.log(data);
				},
				error : function(){
					console.log("Error in Find Participant");
				}
			});
		}
	</script>
</body>
</html>
<%
} catch (Exception e) {
System.out.println("Errror....." + e);
response.sendRedirect("login");
}
%>