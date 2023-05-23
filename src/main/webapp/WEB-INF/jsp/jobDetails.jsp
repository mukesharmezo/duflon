<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import = "java.util.ResourceBundle" %>

<%
try
    {
	ResourceBundle resource = ResourceBundle.getBundle("application");
String baseServer = resource.getString("client.url");
String title = resource.getString("app.title");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" type="image/x-icon" href="<%=baseServer%>img/DuflonFavicon.png"/>
<title><%=title %></title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="./css/common.css">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<style>
button.collapsible {
	font-weight: 600;
	font-size: 17px;
}
.logo{padding: 10px;}
.logo img{width: 200px;}
/* body{background-color: #fff !important;} */
.btn-info {
	float: right !important;
}
.arrow {
	float:left !important;
	/* display: inline-block; */
	width: 12px;
	height: 12px;
	border-top: 2px solid #ea3135;
	border-right: 2px solid #ea3135;
	cursor: pointer;
	margin-top: 5px;
}
.arrow-bottom {
	-webkit-transform: rotate(135deg);
	transform: rotate(135deg);


}
.joblist-container .container {
	max-width: 100%;
}
.job-lists {
	box-shadow: -10px -30px 50px rgba(11, 202, 243, .05), 10px 10px 20px
		rgba(1, 2, 2, .5);
	border-radius: 10px;
	height: auto;
	margin-bottom: 1rem;
	padding: 1.5rem;
	color: #0f326c;
	background: #fff;
	align-items: center;
}
.job-lists .position__name div {
	display: flex;
	justify-content: flex-start;
	align-items: flex-start;
	margin-left: 75px !important;
	margin-top: 5px;
}
.job-lists .job_list_view {
	display: flex;
	justify-content: flex-start;
	align-items: center;
}
.location__name_location, .position__name_reqid {
	font-family: "Poppins-Regular";
	font-style: normal;
	font-weight: 400;
	font-size: 18px;
	line-height: 27px;
	color: #fff;
}
.job_list_view .posted__date_date, .location__name_location,
	.position__name_reqid {
	font-family: "Poppins-Regular";
	font-style: normal;
	font-weight: 400;
	font-size: 18px;
	line-height: 27px;
	color: #0f326c;
}
a{
    color: #fff;
}
a:hover{
	text-decoration: none;
}
.apply__btn {
	font-family: "Poppins-Regular";
	font-style: normal;
	font-weight: 400;
	font-size: 18px;
	line-height: 36px;
	text-align: center;
	width: 150px;
	padding: 0 6px;
	cursor: pointer;
	background-color: #ea3135;
	color: #fff;
	border: 1px solid #ea3135;
	border-radius: 40px;
	float: right;
}
.career_section {
	background-image: url(/static/media/opportunities_new.096004f4.png);
	-webkit-transform-origin: 0 100%;
	transform-origin: 0 100%;
	background-repeat: no-repeat;
	background-size: cover;
	background-position: top;
	/* max-width: 85%; */
	margin-top: -5rem;
	padding:50px 80px 24px;
}
.container {
	width: 100%;
}
.labels-career-open {
    color: #000;
    text-align: left;
    font-size: 22px;
    font-weight: 500;
    font-family: "Roboto", sans-serif;
    max-width: 100%;
    padding-left: 15px;
    padding-right:40px;
    padding-bottom: 24px;
	padding-top: 40px;
}
.labels-career-open .job_title {
    padding-left: 50px;
}
.labels-career-open .job_list_view .experience_year{
    display: flex;
    justify-content: flex-start;
    align-items: center;
}
.header{border-bottom: 1px solid#495057;}
</style>
</head>
<body>
	<div class="header">
		<div class="logo">
		  <img src="./img/DuflonLogo.png"/>
		</div>
	  </div>
	<div class="container">
		<h2 class="text-center" style="font-size: 32px;">Job Opening</h2>
		<div class="labels-career-open row">
			<div class="col-md-1 "></div>
			<div class="job_title col-md-3">Job Title</div>
			<div class="experience_year col-md-3">Experience</div>
			<div class="location__name col-md-3">Location</div>
		</div>
		<c:forEach items="${jobs}" var="job" varStatus="status">
			<div class="career_section container">
				<div class="m-0 row">
					<div class="container">
						<div class="job-lists row">
							<div class="position__dropdown  link">
								<a onclick="myFunction(${status.count})"><span class="arrow arrow-bottom">
								</span></a> 

								<div class="position__name text-bold col-md-3">
									<div>${job.designation}</div>
								</div>
								<div class="position__name text-bold col-md-3">
									<div>${job.profileExperience}</div>
								</div>
								<div class="position__name text-bold col-md-3">
									<div>${job.location}</div>
								</div> 

								<div class="apply__col">
									<div class="apply__btn redbtn"><a href="applyForJob?jobId=${job.jobId}">Apply Now</a></div>
								</div>

								<div id="my${status.count}" class="position__dropdown"
									style="display: none;">
									<br>
									<br>
									<h4>${job.designation}</h4>
									<p style="width: 90% !important;">Description : ${job.description}</p>
									<p>Salary : ${job.salaryMax}</p>
									<p>Education : ${job.education}</p>
									<p>Location : ${job.location}</p>
									<table class="table">
										<tr>
											<th>Skill</th>
											<th>Experience</th>
										</tr>
										<c:forEach items="${job.skills}" var="skill"
											varStatus="status">
											<tr>
												<td>${skill.skillName}</td>
												<td>${skill.requiredExperience}</td>
											</tr>
										</c:forEach>
									</table>
								</div>
							</div>
							
							
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
	<script>
function myFunction(id) {
	   var myDiv = document.getElementById("my"+id);
	   if (myDiv.style.display === "block") {
	     myDiv.style.display = "none";
	   } else {
	     myDiv.style.display = "block";
	   }
	}
</script>
</body>
</html>
<%
 }catch(Exception e)
    {
    	 System.out.println("Errror....."+e);
    	  response.sendRedirect("login");
    }%>