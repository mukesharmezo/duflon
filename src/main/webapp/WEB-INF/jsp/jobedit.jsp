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
<script src="./js/jquery-3.4.1.min.js"></script>
<script src="./js/jquery.validate.js"></script>
<script src="./js/additional-methods.js"></script>
<script src="./js/moment.min.js"></script>
<script src="./js/jobPortal.js"></script>
<link rel="stylesheet" type="text/css" href="./css/common.css">
<link rel="stylesheet"href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<style>
.form{background: #fff; border-radius: 5px; border: 1px solid #E5E5E5; padding: 30px; box-sizing: border-box;margin-bottom: 50px !important;}
.form .form-section{display: flex; flex-wrap: wrap;}
.form .form-section .form-block{margin: 0 15px 25px; width: calc(33.33% - 30px)}
.form .form-section .form-block input[type="text"], .form .form-section .form-block input[type="email"], .form .form-section .form-block input[type="tel"], .form .form-section .form-block input[type="number"], .form .form-section .form-block input[type="date"], .form .form-section .form-block select, .form .form-section .form-block textarea {width: 100%; background: #F7F7F7; border: 1px solid #D0D0D0; border-radius: 7px; color: #4D4D4D; padding: 9px 15px; font-size: 15px;font-family: Arial !important; line-height: 18px; outline: none; box-sizing: border-box;}
.form .error {color: #f00 !important; margin: 5px 0 0; font-size: 11px; line-height: 13px;} 
.form .form-section .form-block.error input[type="text"], .form .form-section .form-block.error input[type="email"], .form .form-section .form-block.error input[type="tel"], .form .form-section .form-block.error input[type="number"], .form .form-section .form-block.error input[type="date"], .form .form-section .form-block.error select{border-color: #f00 !important;}
.form .form-section .form-block input[type="date"]{text-transform: uppercase;}

.btn-success {color: #fff;background-color: #DC3545 !important;border-color: #DC3545 !important;margin-left: 15px;font-size:17px;border: 1px solid transparent;padding: 0.375rem 0.75rem;border-radius: 2rem;font-weight: 900;}
			.btn-success:hover {background-color: #DC3545 !important;border-color: #DC3545 !important;}
			.btn-primary {margin-right: 315px !important;color: #fff;background-color: #DC3545;border-color: #DC3545;margin-left: 15px;}
.btn-primary:hover {background-color: #DC3545 !important;border-color: #DC3545 !important;}
		     label.col-sm-2.col-form-label {font-weight: 500;font-size: 15px;line-height: 18px;margin: 0 0 9px;position: relative;}
			/* .btn-danger{width: 30px;border-radius: 15px;font-size: 15px;font-weight: 900; border: 1px solid transparent;} */
.btn-danger {color: #fff;background-color: #DC3545 !important;border-color: #DC3545 !important;margin-left: 15px; font-size:17px;border: 1px solid transparent;padding: 0.375rem 0.75rem;border-radius:2rem;    font-weight: 900;}

			button.btn.btn-primary {min-width: 110px;}
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
		<h1 class="text-center">Job Update</h1>
		<form action="updateJobDetails" class="form" method="post" id="jobPage">
			<input type="hidden" id= jobId name="jobId" value="${job.jobId}"/>
			<div class="form-section">
				<div class="form-block">
				<label for="hreId" >HRE</label>
					<select class="form-control" id="hreId" name="hreId">
						<option value="">Select HRE</option>
						<c:forEach items="${hres}" var="hre" varStatus="status">
							<option value="${hre.id}" <c:if test="${job.hreId eq hre.id || hres.size() eq 1}"> selected</c:if>>${hre.name}</option>
						</c:forEach>
					</select>
			</div>
			<div class="form-block">
				<label for="designation">Designation</label>
				<select class="form-control" id="designation" name="designation">
					<option value="">Select Designation</option>
					<option value="Manager">Manager</option>
					<option value="HRE">HRE</option>
				</select>
			</div>
				<div class="form-block">
				<label for="description">Description</label>
					<textarea class="form-control" id="description" name="description"
						rows="1" placeholder="Enter description">${job.description}</textarea>
				</div>
			<div class="form-block">
				<label for="salaryMin">Min Salary</label>
					<input type="number" class="form-control" id="salaryMin" name="salaryMin"  value="${job.salaryMin}">
			</div>
			<div class="form-block">
				<label for="salaryMax">Max Salary</label>
					<input type="number" class="form-control" id="salaryMax" name="salaryMax"   value="${job.salaryMax}">
			</div>
			<div class="form-block">
				<label for="education">Education</label>
					<select class="form-control" id="education" name="education">
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
				<div class="form-block col-md-12" style="padding-right: 56px;padding-left:0px;">
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
						
						 <c:forEach items="${job.skills}" var="skill" varStatus="status">
							<tr id="skillRow${status.count}">
								<td><input type="text" name="skills[${status.index}].skillName"
									class="form-control" required="true" value="${skill.skillName}"/>
								</td>
								<td><input type="number"
									name="skills[${status.index}].requiredExperience" class="form-control" value="${skill.requiredExperience}"/></td>
								<td>
									<!-- <button type="button" class="btn-remove btn-danger btn-sm"
										onclick="removeSkillRow('skillRow1')">Remove</button> -->
									<button type="button" class="btn-remove btn-danger btn-sm"
										onclick="removeSkillRow('skillRow${status.count}')"> &#8211;  </button>
								</td>
							</tr>
						 </c:forEach>
						</tbody>
					</table>
					<!-- <button type="button" class="btn-remove btn-success"
						onclick="addSkillRow()">Add Skill</button> -->
					<button type="button" class="btn-remove btn-success"
						onclick="addSkillRow()"> &#43;</button>
				</div>
			</div>
			<div class="form-section">
			<div class="form-block">
				<label for="profileExperience">Profile Experience</label>
					<input type="number" class="form-control" id="profileExperience"
						name="profileExperience" value="${job.profileExperience}">
			</div>
			<div class="form-block">
				<label for="company" >Company 	Name</label>
					<select name="company" id="company" class="form-control">
						<option value="">Select Company Name</option>
						<option value="DuFlon Industries Pvt Ltd. ">DuFlon
							Industries Pvt Ltd.</option>
						<option value="DuFlon Elastomers LLP">DuFlon Elastomers
							LLP</option>
					</select>
			</div>
			<div class="form-block">
				<label for="region" >Region</label>
					<select name="region" id="region" class="form-control"
						required="true">
						<option value="">Select Region</option>
						<option value="India">India</option>
						<option value="Europe">Europe</option>
					</select>
			</div>
			<div class="form-block">
				<label for="location">Locatioin</label>
					<select name="location" id="location" class="form-control"
						required="true">
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
				<label for="unit" >Unit</label>
					<select name="unit" id="unit" class="form-control" required="true">
						<option value="">Select Unit</option>
						<option value="Unit I">Unit I</option>
						<option value="Unit II">Unit II</option>
						<option value="Unit III">Unit III</option>
						<option value="Office">Office</option>
					</select>
			</div>
			<div class="form-block">
				<label for="business" >Business</label>
					<select name="business" id="business" class="form-control"
						required="true">
						<option value="">Select Business</option>
						<option value="EP & E">EP & E</option>
						<option value="Corporate Office">Corporate Office</option>
						<option value="Casting">Casting</option>
						<option value="CSP">CSP</option>
						<option value="Elastomers">Elastomers</option>
					</select>
			</div>
			<div class="form-block">
				<label for="function" >Function</label>
					<select name="function" id="function" class="form-control"
						required="true">
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
				<label for="product" >Product</label>
					<select name="product" id="product" class="form-control"
						required="true">
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
	
	</div>
	<script type="text/javascript">
		document.getElementById("education").value ="${job.education}"; 
	</script>
	<script>
		var skillRowCount = ${skillLength};
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
					+ skillRowCount + '\')"> &#8211;  </button></td>';
			newRow += '</tr>';
			$("#skillsTable tbody").append(newRow);
			
		}

		function removeSkillRow(rowId) {
			$("#" + rowId).remove();
			skillRowCount--;
		}

		$(document).ready(function() {
			//Show HRM selected if there are one HRM only
			var dealerDropdown = $('#dealerId');
			var optionsCount = dealerDropdown.find('option').length;
			if(optionsCount == 2){
				dealerDropdown.val(dealerDropdown.find('option:last').val());
				dealerDropdown.prop('disabled',true);
				//dealerDropdown.css('cursor','not-allowed');
			}
		});
	</script>
</body>
</html>
<%
 }catch(Exception e)
    {
    	 System.out.println("Errror....."+e);
    	  response.sendRedirect("login");
    }%>
