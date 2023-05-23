<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<script src="./js/jquery-3.4.1.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/jquery.validate.min.js"></script>
<script type="text/javascript" src="/js/register.js"></script>
<link rel="stylesheet" type="text/css" href="./css/login.css" />
</head>
<body>
<h4>Change Your Email Address</h4>
<% String mspin3=""; 
mspin3=session.getAttribute("mspin").toString().trim();

%>
  <div class="left-panel-include">
    <%@include file="./header/left-panel.jsp"%> 
    </div>
    <div class="user-panel-include">
	<%@include file="./header/user-panel.jsp"%>
	</div>
	<div class="right-panel">
		<div class="form">
			<form action="changeEmail" method="post" class="form"  id="testForm">
				<div class="form-section">
					<input type="hidden" name="mspin" id="mspin"	value="<%=mspin3%>" />	
						<div class="form-block">
							<h5>Email</h5>
							<input type="email" name="email" id="email" placeholder="enter new email"/>
						</div> 
						<div class="form-block">
							<input class="btn blue-btn" type="submit" value="Add" id="submit" />
						</div>	<br><br>					
				</div>
			</form>
		</div>
</div>
</body>
</html>