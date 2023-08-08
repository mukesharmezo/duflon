<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
<link rel="icon" type="image/x-icon" href="<%=baseServer%>img/DuflonFavicon.png"/>
<title><%=title %></title>
<link rel="stylesheet" type="text/css" href="./css/style.css" />
<script src="./js/jquery-3.4.1.min.js"></script>
<script src="./js/jquery.validate.js"></script>
<script src="./js/additional-methods.js"></script>
<script src="./js/moment.min.js"></script>
<script src="./js/jobPortal.js"></script>
<!-- <link rel="stylesheet" type="text/css" href="./css/common.css"> -->
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.13.0/themes/smoothness/jquery-ui.css" />

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<style>
		.logo{padding: 10px;}
		.logo img{width: 200px;}
		h2{text-align: center;margin-bottom: 30px;margin-top: 15px;}
		label {font-weight: 500;font-size: 15px;display: inline-block;line-height: 18px;margin: 0 0 9px;}
		/* .btn-success {color: #fff;background-color: #DC3545;border-color: #DC3545;margin-left: 15px;} */
.btn-success {color: #fff;background-color: #DC3545 !important;border-color: #DC3545 !important;margin-left: 15px; font-size:17px;     font-weight: 900; border: 1px solid transparent;padding: 0.375rem 0.75rem;border-radius:2rem;}

		.btn-success:hover{background-color: #DC3545;border-color: #DC3545;}
		.header{border-bottom: 1px solid#495057;background-color: #ebebeb !important;}
.btn-danger {color: #fff;background-color: #DC3545 !important;border-color: #DC3545 !important;margin-left: 15px; font-size:17px;     font-weight: 900; border: 1px solid transparent;padding: 0.375rem 0.75rem;border-radius:2rem;}
		/* .btn-danger {color: #fff;background-color: #DC3545;border-color: #DC3545;} */

		.btn-danger:hover{background-color: #DC3545;border-color: #DC3545;}
.btn-circle {    width: 30px;    padding: 6px 0px;    border-radius: 15px;    text-align: center;    font-size: 25px;    line-height: 1.42857;}
.btn-btn-circle{    padding: 0px !important;    min-width:0px !important;	min-width: none !important;    }
	button.btn-remove.btn-success {    color: #fff;    background-color: #DC3545 !important;    border-color: #DC3545 !important;    margin-left: 17px;    font-size: 12px;    border: 1px solid transparent;    padding: 0.375rem 0.75rem;    border-radius: 2rem !important;	font-weight: 900;}
	</style>
</head>
<body>
	<div class="header">
		<div class="logo">
		  <img src="./img/DuflonLogo.png"/>
		</div>
	  </div>
	  <h2>You are applying for ${jobTitle}</h2>
	<div class="container">
		<form:form action="jobUserRegistration" class="form"  method="post" 
			modelAttribute="userRegistration" enctype="multipart/form-data"  id="jobPage">
			<form:input type="hidden" path="jobId" />
			<form:input type="hidden" path="hreId" />
			<div class="form-section">
				<div class="form-block">
					<label for="firstName">First Name</label>
					<form:input path="firstName" id="firstName" class="form-control"
						placeholder="Enter your First Name" required="true" />
				</div>
				<div class="form-block">
					<label for="middleName">Middle Name</label>
					<form:input path="middleName" id="middleName" class="form-control"
						placeholder="Enter your Middle Name" />
				</div>
				<div class="form-block">
					<label for="lastName">Last Name</label>
					<form:input path="lastName" id="lastName" class="form-control"
						placeholder="Enter your Last Name" required="true" />
				</div>
				<div class="form-block">
					<label for="mobile">Mobile</label>
					<form:input path="mobile" id="mobile" class="form-control"
						placeholder="Enter your Mobile number" required="true" />
				</div>
				<div class="form-block">
  					<label for="gender">Gender</label>
  					<select id="gender" name="gender" class="form-control">
    					<option value="">Select Gender</option>
    					<c:forEach items="${genders}" var="gender">
    						<option value="${gender.listCode}">${gender.listDesc}</option>
    					</c:forEach>
  					</select>
				</div>
				<div class="form-block">
					<label for="email">Email</label>
					<form:input path="email" id="email" class="form-control"
						placeholder="Enter your email" required="true" />
				</div>
				<div class="form-block">
					<label for="birthDate">Date of Birth</label>
					<form:input type="date" path="birthDate" id="birthDate"
						class="form-control" placeholder="YYYY-MM-DD" required="true" min="<%= java.time.LocalDate.now().minusYears(50) %>" max="<%= java.time.LocalDate.now().minusYears(18) %>" />
				</div>
				<div class="form-block">
					<label for="education">Education</label>
					<select name="education" id="education" class="form-control">
						<option value="">Select Education</option>
    					<c:forEach items="${educations}" var="education">
    						<option value="${education}">${education}</option>
    					</c:forEach>
					</select>
				</div>
				<div class="form-block">
  					<label for="source">Recruitment Source</label>
  					<select id="source" name="source" class="form-control">
    					<option value="">Select Source</option>
    					<c:forEach items="${sources}" var="source">
    						<option value="${source.listDesc}">${source.listDesc}</option>
    					</c:forEach>
  					</select>
				</div>
				<div class="form-block">
					<label for="profileExperience">Total Experience</label> <input
						type="number" class="form-control" id="profileExperience"
						name="profileExperience" placeholder="Enter total experience">
				</div>
				<div class="form-block">
  					<label for="photoFile">Photo</label> 
  					<input type="file" name="photoFile" id="photoFile" class="form-control-file" accept="image/jpeg, image/png" />
  					 <small class="form-text text-muted">Accepted file types: JPEG, JPG, PNG. Maximum file size: 500 KB.</small>
				</div>
				<div class="form-block">
  					<label for="resumeFile">Resume</label> 
  					<input type="file" name="resumeFile" id="resumeFile" class="form-control-file" accept=".pdf,.doc,.docx" />
  					 <small class="form-text text-muted">Accepted file types: PDF, DOC, DOCX. Maximum file size: 1 MB.</small>
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
                <c:forEach items="${skills}" var="skill" varStatus="status">
                    <tr id="skillRow${status.index + 1}">
                        <td>
                            <input type="text" name="skills[${status.index}].skill" class="form-control autocomplete" required="true" list="skillList${status.index + 1}" value="${skill}" />
                            <datalist id="skillList${status.index + 1}">
                                <c:forEach items="${skills}" var="skillOption">
                                    <option value="${skillOption}" />
                                </c:forEach>
                            </datalist>
                        </td>
                        <td>
                            <input type="number" name="skills[${status.index}].experience" class="form-control" required="true" />
                        </td>
                        <td>
							 <button type="button" class="btn btn-danger btn-circle rounded-circle btn-btn-circle" onclick="removeSkillRow('skillRow${status.index + 1}')">-</button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
		<button type="button" class="btn-remove btn-success" id="addSkillBtn">&#43;</button>
    </div>
</div>
			<div class="text-center mt-3 mb-3">
				<button type="submit" class="btn btn-primary" style="background-color: #DC3545;border: none;">Submit</button>
				</div>
		</form:form>
	</div>
	
	<script type="text/javascript">
		  var skillRowCount = ${skillLength};
	$(document).ready(function() {
		//Focus on next fields if space is entered
		$('#firstName, #middleName, #lastName, #mobile, #email, #profileExperience').keydown(function(e) {
    		if (e.which === 32) { 
      			e.preventDefault(); 
      			$(this).closest('.form-block').next().find('input, select').focus(); //Move focus to the next fields box
    		}
  		});
		  function addSkillRow() {
		    skillRowCount++;
		    var newRow = $('<tr>').attr('id', 'skillRow' + skillRowCount);
		    var dataListId = 'skillList' + skillRowCount;
		    newRow.append($('<td>')
		      .append($('<input>')
		        .attr('type', 'text')
		        .attr('name', 'skills[' + (skillRowCount - 1) + '].skill')
		        .addClass('form-control autocomplete')
		        .attr('required', true)
		        .attr('list', dataListId)))
		      .append($('<datalist>')
		        .attr('id', dataListId)
		        .append($.map(${jsonSkills}, function(skillOption) {
		          return $('<option>').attr('value', skillOption);
		        })))
		      .append($('<td>')
		        .append($('<input>')
		          .attr('type', 'number')
		          .attr('name', 'skills[' + (skillRowCount - 1) + '].experience')
		          .addClass('form-control')
		          .attr('required', true)))
		      .append($('<td>')
		        .append($('<button>')
		          .attr('type', 'button')
		          .addClass('btn btn-danger btn-circle rounded-circle btn-btn-circle')
		          .text('-')
		          .click(function() {
		            removeSkillRow('skillRow' + skillRowCount);
		          })));

		    $('#skillsTable tbody').append(newRow);
		    
		    //Validation
		    for (var i = 0; i < skillRowCount; i++) {
		        $('input[name="skills[' + i + '].skill"]').rules('add', {
		          required: true,
		          messages: {
		            required: "Please enter a skill name."
		          }
		        });

		        $('input[name="skills[' + i + '].experience"]').rules('add', {
		          required: true,
		          messages: {
		            required: "Please enter the required experience for this skill."
		          }
		        });
		      }

		   /*  $('input[name="skills[' + (skillRowCount - 1) + '].skill"]').rules('add', {
		      required: true,
		      messages: {
		        required: "Please enter a skill name."
		      }
		    });

		    $('input[name="skills[' + (skillRowCount - 1) + '].experience"]').rules('add', {
		      required: true,
		      messages: {
		        required: "Please enter the required experience for this skill."
		      }
		    }); */
		  }

		  

		  $('#addSkillBtn').click(function() {
		    addSkillRow();
		  });
		});
	
	function removeSkillRow(rowId) {
		  console.log('Row :: '+rowId);
	    $('#' + rowId).remove();
	    skillRowCount--;
	  }
	</script>
	<script>
		// Use jQuery to select all number input elements
		const numberInputs = $('input[type="number"]');
		// Add event handler using jQuery's "on" method
		numberInputs.on('input', function() {
			if ($(this).val() < 0) {
				$(this).val(0); // Reset to 0 if a negative value is entered
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