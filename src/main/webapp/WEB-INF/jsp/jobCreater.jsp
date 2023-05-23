<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.ResourceBundle"%>
<%
try {
	ResourceBundle resource = ResourceBundle.getBundle("application");
	String baseServer = resource.getString("client.url");
	String title = resource.getString("app.title");
	if (session.getAttribute("role") != null) {
		String role = session.getAttribute("role").toString().trim();
		String st = "";
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
	{
	opacity: 1
}

.left-panel>ul>li:nth-child(1)>ul>li:nth-child(1)>a::after {
	content: '';
	position: absolute;
	right: 0;
	top: 50%;
	transform: translate(0, -50%);
	border-right: 6px solid #fff;
	border-top: 6px solid transparent;
	border-bottom: 6px solid transparent;
}

.dataTables_scrollBody {
	overflow-y: hidden !important;
	overflow-x: auto !important;
}

.table-date table tr th {
	background: #DC3545 !important;
	padding-top: 15px;
	padding-bottom: 15px;
}

.table-date table tr td .btn {
	padding: 5px 10px 4px !important;
}

table.dataTable.stripe>tbody>tr.odd>*, table.dataTable.display>tbody>tr.odd>*
	{
	box-shadow: none !important;
}

.btn-success {
	color: #fff;
	background-color: #DC3545 !important;
	border-color: #DC3545 !important;
	margin-left: 15px;
	font-size: 17px;
	font-weight: 900;
	border: 1px solid transparent;
	padding: 0.375rem 0.75rem;
	border-radius: 2rem;
}

.btn-success:hover {
	background-color: #DC3545 !important;
	border-color: #DC3545 !important;
}

label.col-sm-2.col-form-label {
	font-weight: 500;
	font-size: 15px;
	line-height: 18px;
	margin: 0 0 9px;
	position: relative;
}

.btn-primary {
	margin-right: 315px !important;
	color: #fff;
	background-color: #DC3545;
	border-color: #DC3545;
	margin-left: 15px;
}

.btn-primary:hover {
	background-color: #DC3545;
	border-color: #DC3545;
}

#dealerId[disabled] {
	opacity: 0.6;
	height: auto;
}

select {
	padding: 5px;
}

select option {
	padding: 5px;
}

h2 {
	text-align: center;
	margin-bottom: 30px;
	margin-top: 15px;
}

label {
	font-weight: 500;
	font-size: 15px;
	display: inline-block;
	line-height: 18px;
	margin: 0 0 9px;
}

.form {
	background: #fff;
	border-radius: 5px;
	border: 1px solid #E5E5E5;
	padding: 30px;
	box-sizing: border-box;
	margin-bottom: 50px !important;
}

.form .form-section {
	display: flex;
	flex-wrap: wrap;
}

.form .form-section .form-block {
	margin: 0 15px 25px;
	width: calc(33.33% - 30px)
}

.form .form-section .form-block input[type="text"], .form .form-section .form-block input[type="email"],
	.form .form-section .form-block input[type="tel"], .form .form-section .form-block input[type="number"],
	.form .form-section .form-block input[type="date"], .form .form-section .form-block select,
	.form .form-section .form-block textarea {
	width: 100%;
	background: #F7F7F7;
	border: 1px solid #D0D0D0;
	border-radius: 7px;
	color: #4D4D4D;
	padding: 9px 15px;
	font-size: 15px;
	font-family: Arial !important;
	line-height: 18px;
	outline: none;
	box-sizing: border-box;
}

.form .error {
	color: #f00 !important;
	margin: 5px 0 0;
	font-size: 11px;
	line-height: 13px;
}

.form .form-section .form-block.error input[type="text"], .form .form-section .form-block.error input[type="email"],
	.form .form-section .form-block.error input[type="tel"], .form .form-section .form-block.error input[type="number"],
	.form .form-section .form-block.error input[type="date"], .form .form-section .form-block.error select
	{
	border-color: #f00 !important;
}

.form .form-section .form-block input[type="date"] {
	text-transform: uppercase;
}
/* .btn-danger{width: 30px;border-radius: 15px;font-size: 17px;font-weight: 900;border: 1px solid transparent;} */
.btn-danger {
	color: #fff;
	background-color: #DC3545 !important;
	border-color: #DC3545 !important;
	margin-left: 15px;
	font-size: 17px;
	font-weight: 900;
	border: 1px solid transparent;
	padding: 0.375rem 0.75rem;
	border-radius: 2rem;
}

.btn-danger:hover {
	color: #fff;
	background-color: #DC3545;
	border-color: #DC3545 !important;
}

button.btn.btn-primary {
	min-width: 110px;
}

.description-column {
	max-width: 20ch;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}
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
		<h2>Job Creater</h2>
		<form action="saveJobDetails" class="form" method="post" id="jobPage">
			<div class="form-section">
				<div class="form-block">
					<label for="hreId">HRE</label> <select class="form-control"
						id="hreId" name="hreId">
						<option value="">Select HRE</option>
						<c:forEach items="${hres}" var="hre" varStatus="status">
							<option value="${hre.id}"
								<c:if test="${hres.size() eq 1}"> selected</c:if>>${hre.name}</option>
						</c:forEach>
					</select>
				</div>
				<div class="form-block">
					<label for="designation">Designation</label> <select
						class="form-control" id="designation" name="designation">
						<option value="">Select Designation</option>
						<option value="Manager">Manager</option>
						<option value="HRE">HRE</option>
					</select>
				</div>
				<div class="form-block">
					<label for="description">Description</label>
					<textarea class="form-control" id="description" name="description"
						rows="1" placeholder="Enter description"></textarea>
				</div>
				<div class="form-block">
					<label for="salaryMin">Min Salary</label> <input type="number"
						class="form-control" id="salaryMin" name="salaryMin"
						placeholder="Enter min salary">
				</div>
				<div class="form-block">
					<label for="salaryMax">Max Salary</label> <input type="number"
						class="form-control" id="salaryMax" name="salaryMax"
						placeholder="Enter max salary">
				</div>
				<div class="form-block">
					<label for="education">Education</label> <select
						class="form-control" id="education" name="education">
						<option value="">Select Education</option>
						<option value="High School">High School</option>
						<option value="Associate's Degree">Associate's Degree</option>
						<option value="Bachelor's Degree">Bachelor's Degree</option>
						<option value="Master's Degree">Master's Degree</option>
						<option value="Doctoral Degree">Doctoral Degree</option>
					</select>
				</div>

			</div>
			<div class="form-section">
				<div class="form-block col-md-12"
					style="padding-right: 56px; padding-left: 0px;">
					<label for="skills">Skills with Experience</label>
					<table id="skillsTable" class="table">
						<thead>
							<tr>
								<th>Skill</th>
								<th>Experience (in Years)</th>
								<th></th>
							</tr>
						</thead>
						<tbody>

							<tr id="skillRow1">
								<td><input type="text" name="skills[0].skillName"
									class="form-control autocomplete" required="true" />
									<div class="skill-suggestions"></div></td>
								<td><input type="number"
									name="skills[0].requiredExperience" class="form-control"
									required="true" /></td>
								<td>
									<!-- <button type="button" class="btn-remove btn-danger btn-sm"
										onclick="removeSkillRow('skillRow1')">Remove</button> -->
									<button type="button" class="btn-remove btn-danger btn-sm"
										onclick="removeSkillRow('skillRow1')">&#8211;</button> <!-- <div class="cssCircle minusSign" style="padding-top:00px" onclick="removeSkillRow('skillRow1')">
											&#8211;
										  </div> -->
								</td>
							</tr>
						</tbody>
					</table>
					<!-- <button type="button" class="btn-remove btn-success"
						onclick="addSkillRow()">Add Skill</button> -->
					<button type="button" class="btn-remove btn-success"
						onclick="addSkillRow()">&#43;</button>
				</div>
			</div>
			<div class="form-section">
				<div class="form-block">
					<label for="profileExperience">Profile Experience</label> <input
						type="number" class="form-control" id="profileExperience"
						name="profileExperience" placeholder="Enter profile experience">
				</div>
				<div class="form-block">
					<label for="company">Company Name</label> <select name="company"
						id="company" class="form-control">
						<option value="">Select Company Name</option>
						<option value="DuFlon Industries Pvt Ltd. ">DuFlon
							Industries Pvt Ltd.</option>
						<option value="DuFlon Elastomers LLP">DuFlon Elastomers
							LLP</option>
					</select>
				</div>
				<div class="form-block">
					<label for="region">Region</label> <select name="region"
						id="region" class="form-control">
						<option value="">Select Region</option>
						<option value="India">India</option>
						<option value="Europe">Europe</option>
					</select>
				</div>
				<div class="form-block">
					<label for="location">Locatioin</label> <select name="location"
						id="location" class="form-control">
						<option value="">Select Locatioin</option>
						<option value="Mahad">Mahad</option>
						<option value="Mumbai">Mumbai</option>
						<option value="Ahmedabad">Ahmedabad</option>
						<option value="Vadodara">Vadodara</option>
						<option value="Ambernath">Ambernath</option>
						<option value="Hungry">Hungry</option>
					</select>
				</div>
				<div class="form-block">
					<label for="unit">Unit</label> <select name="unit" id="unit"
						class="form-control">
						<option value="">Select Unit</option>
						<option value="Unit I">Unit I</option>
						<option value="Unit II">Unit II</option>
						<option value="Unit III">Unit III</option>
						<option value="Office">Office</option>
					</select>
				</div>
				<div class="form-block">
					<label for="business">Business</label> <select name="business"
						id="business" class="form-control">
						<option value="">Select Business</option>
						<option value="EP & E">EP & E</option>
						<option value="Corporate Office">Corporate Office</option>
						<option value="Casting">Casting</option>
						<option value="CSP">CSP</option>
						<option value="Elastomers">Elastomers</option>
					</select>
				</div>
				<div class="form-block">
					<label for="function">Function</label> <select name="function"
						id="function" class="form-control">
						<option value="">Select Function</option>
						<option value="Prodction / Fuctional">Prodction /
							Fuctional</option>
						<option value="Finance / Legal & secretorial">Finance /
							Legal & secretorial</option>
						<option value="HR / Logistics / Procurment ">HR /
							Logistics / Procurment</option>
					</select>
				</div>
				<div class="form-block">
					<label for="product">Product</label> <select name="product"
						id="product" class="form-control">
						<option value="">Select Product</option>
						<option value="PV">PV</option>
						<option value="Eletrical">Eletrical</option>
						<option value="CSP">CSP</option>
						<option value="Casting">Casting</option>
						<option value="Rubber">Rubber</option>
						<option value="Semi conductor & eletronics">Semi
							conductor & eletronics</option>
					</select>
				</div>
			</div>
			<div class="form-group row">
				<div class="col-sm-9 offset-sm-3 text-center">
					<button type="submit" class="btn btn-primary">Save</button>
				</div>
			</div>
		</form>
		<hr class="my-5">
		<div class="jobTable">
			<h1 class="my-4 text-center">Job Listings</h1>

			<div class="container-1100">
				<div class="table-date">
					<table id="data" cellspacing="0" cellpadding="0" border="0"
						class="display nowrap cell-border" width="100%">
						<thead>
							<tr>
								<th data-head="Sr. No." style="z-index: 1 !important;"><em>Sr.
										No.</em></th>
								<th data-head="Job Title" class="sorting"
									style="z-index: 1 !important;"><em>Designation</em></th>
								<th data-head="Description" class="sorting"><em>Description</em></th>
								<th data-head="Skill" class="sorting"><em>Skill</em></th>
								<th data-head="Experience" class="sorting"><em>Experience</em></th>
								<th data-head="HRE Name" class="sorting"><em>HRE Name</em></th>
								<th data-head="Edit" class="sorting"><em>Edit</em></th>
								<th data-head="Delete" class="sorting"><em>Delete</em></th>
								<th data-head="HRE Approval" class="sorting"><em>HRE
										Approval</em></th>
								<th data-head="LM Approval" class="sorting"><em>LM
										Approval</em></th>
								<th data-head="Status" class="sorting"><em>Status</em></th>
								<!--  (Open new Link for analysis) -->
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${jobs}" var="job" varStatus="status">
								<tr>
									<td>${status.count}</td>
									<td>${job.designation}</td>
									<td class="description-column">${job.description}</td>
									<td><c:forEach items="${job.skills}" var="skill">
											<p>${skill.skillName}</p>
										</c:forEach></td>
									<td><c:forEach items="${job.skills}" var="skill">
											<p>${skill.requiredExperience}</p>
										</c:forEach></td>
									<td>${job.hreName}</td>
									<td><a href="editJob?jobId=${job.jobId}"><span
											class="btn btn-warning">Edit</span></a></td>
									<td><a href="deleteJob?jobId=${job.jobId}"><span
											class="btn btn-danger">Delete</span></a></td>
									<td><c:if test="${job.approvalHr == 'R'}">
											<a href="approveJobByHre?jobId=${job.jobId}"><span
												class="btn btn-secondary">Approve</span></a>
										</c:if> <c:if test="${job.approvalHr != 'R'}">
											<a href="rejectJobByHre?jobId=${job.jobId}"><span
												class="btn btn-secondary">Reject</span></a>
										</c:if></td>
									<td><c:choose>
											<c:when test="${role == 'LM'}">
												<c:if test="${job.approvalLm == 'R'}">
													<a href="approveJobByLM?jobId=${job.jobId}"> <span
														class="btn btn-secondary">Approve</span>
													</a>
												</c:if>
												<c:if test="${job.approvalLm != 'R'}">
													<a href="rejectJobByLM?jobId=${job.jobId}"> <span
														class="btn btn-secondary">Reject</span>
													</a>
												</c:if>
											</c:when>
											<c:otherwise>
												<c:if test="${job.approvalLm != 'R'}">
												<span>Approved</span>
												</c:if>
												<c:if test="${job.approvalLm == 'R'}">
												<span>Approval Pending</span>
												</c:if>
											</c:otherwise>
										</c:choose></td>
									<td><c:if test="${job.status == 'H'}">
											<a href="unholdJobByHre?jobId=${job.jobId}"><span
												class="btn btn-secondary">UnHold</span></a>
										</c:if> <c:if test="${job.status == 'U'}">
											<a href="holdJobByHre?jobId=${job.jobId}"><span
												class="btn btn-secondary">Hold</span></a>
										</c:if></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>


	<script>
		var skillRowCount = 1;
		//Define the validation rules and messages
		var validationRules = {
			"skills[]" : {
				required : true
			}
		};

		var validationMessages = {
			"skills[]" : {
				required : "The skill field is required."
			}
		};

		// Initialize the jQuery validation plugin
		$(document).ready(function() {
			$("#myForm").validate({
				rules : validationRules,
				messages : validationMessages
			});
			//Show HRM selected if there are one HRM only
			/*	var dealerDropdown = $('#dealerId');
				var optionsCount = dealerDropdown.find('option').length;
				if(optionsCount == 2){
					dealerDropdown.val(dealerDropdown.find('option:last').val());
					dealerDropdown.prop('disabled',true);
					//dealerDropdown.css('cursor','not-allowed');
				}*/
		});

		// Add the validation rules and messages to the dynamic rows
		function addSkillRow() {
			skillRowCount++;
			var newRow = '<tr id="skillRow' + skillRowCount + '">';
			newRow += '<td><input type="text" name="skills['
					+ (skillRowCount - 1)
					+ '].skillName" class="form-control autocomplete" required="true" />';
			newRow += '<div class="skill-suggestions"></div></td>';
			newRow += '<td><input type="number" name="skills['
					+ (skillRowCount - 1)
					+ '].requiredExperience" class="form-control" required="true" /></td>';
			newRow += '<td><button type="button" class="btn btn-danger btn-sm" onclick="removeSkillRow(\'skillRow'
					+ skillRowCount + '\')"> &#8211; </button></td>';
			newRow += '</tr>';

			// Append the new row to the table
			$("#skillsTable tbody").append(newRow);

			// Add validation rules and messages to the new row
			var newRowId = "#skillRow" + skillRowCount;
			$(
					newRowId + " input[name='skills[" + (skillRowCount - 1)
							+ "].skillName']").rules("add", {
				required : true,
				messages : {
					required : "Please enter a skill name."
				}
			});
			$(
					newRowId + " input[name='skills[" + (skillRowCount - 1)
							+ "].requiredExperience']")
					.rules(
							"add",
							{
								required : true,
								messages : {
									required : "Please enter the required experience for this skill."
								}
							});
		}
		function removeSkillRow(rowId) {
			$("#" + rowId).remove();
			skillRowCount--;
		}
	</script>

</body>
</html>
<%
} else {
response.sendRedirect("login");
}
} catch (Exception e) {
response.sendRedirect("login");
}
%>
