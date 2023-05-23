<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<script src="../js/jquery-3.4.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="../css/login.css" />
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/jquery.validate.min.js"></script>
    <script type="text/javascript" src="/js/register.js"></script>
  

</head>
<body>
<% String mspin1="", message=""; 
mspin1=session.getAttribute("mspin").toString().trim();
if(session.getAttribute("message") != null){
	  message = (String)session.getAttribute("message");
	  session.removeAttribute("message");
}
%>

  <div class="left-panel-include">
    <%@include file="./header/left-panel.jsp"%> 
    </div>
    <!-- <div class="user-panel-include"></div> -->
    <div class="user-panel-include">
	<%@include file="./header/user-panel.jsp"%>
	</div>
	
	<div class="right-panel">
        <div class="form">
		<form action="../changePassword" method="post"  class=form id="testForm" >
		<div class="form-section">
			<h2>Change Password</h2>
			<br><br>
			<!--<input type="hidden" name="mspin" id="mspin"	value="<%=mspin1%>" /> -->
			<div class="form-section">
				<div class="form-block">
					<h5>Old Password</h5>
					<input type="text" name="oldPassword" id="oldPassword"  /><br>
					<span id="oError" style="color:red"></span>
				</div><br>
				<div class="form-block">
					<h5>New Password</h5>
					<input type="text" name="newPassword" id="newPassword"  /><br>
					<span id="nError" style="color:red"></span>
				</div>
				<div class="form-block">
					<h5>Confirm New Password</h5>
					<input type="text" name="confirmPassword" id="confirmPassword"  /><br>
					<span id="cError" style="color:red"></span>
				</div>
				<br>
				 <span style="color:red;">
						      <!--  -	<strong><%=message %></strong> -->							
						</span>
				<br>
				<div class="form-block">
						<input class="btn blue-btn" type="submit" value="Confirm Change Password" id="submit" />
					</div>
			</div>
		</div>  <!-- Form Section -->
		</form>
		
		
	</div>
	

	</div>
</body>
</html>