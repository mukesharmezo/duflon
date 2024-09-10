
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import = "java.util.ResourceBundle" %>
<% try{%>
	ResourceBundle resource = ResourceBundle.getBundle("application");
    		  String baseServer = resource.getString("client.url");

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="icon" type="image/x-icon" href="<%=baseServer%>img/iRecruit-favicon.ico"/>
<title>GAMMEZO</title>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript"
	src="http://js.nicedit.com/nicEdit-latest.js"></script>
<script type="text/javascript" src="/resources/nicEdit.js"></script>

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>



<style>
/* Modal Content */
.modal-content {
	background-color: #fefefe;
	margin: auto;
	padding: 20px;
	border: 1px solid #888;
	width: 70%;
}

.card {
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
	transition: 0.3s;
	width: 40%;
	height: 5%;
	text-align: center;
	padding: 100px;
	margin-top: 50px;
}

.
:hover {
	box-shadow: 0 8px 16px 0 rgba(0, 0, 0, 0.2);
}
</style>

<script type="text/javascript">
	            bkLib.onDomLoaded(function() { nicEditors.allTextAreas() });
	      
				 function saveResp()
					{					
					 var data = $('#peter').find('.nicEdit-main').html();
							  $('#msg').val(data); 
							   if( $('#subject').val() ==""){
								   alert("Please Enter Subject ");								 
								 return false;
							 }
							 if( $('#msg').val() ==""){
								 alert("Please Enter Email");							 
								 return false;
							 }	
							 alert($('#msg').val());
							    document.forms[0].action="addPro";
								document.forms[0].method="post";
								document.forms[0].submit();								
					}
				 
				 
				
				
				</script>
<style>
fieldset.scheduler-border {
	border: 1px solid #3d3d3d !important;
	padding: 1em !important;
	margin: 0 0 1em 0 !important;
	/* -webkit-box-shadow: 0px 0px 0px 0px #000; */
	/* box-shadow: 0px 0px 0px 0px #000; */
	background: #ffffffc2;
}

legend.scheduler-border {
	font-size: 15px !important;
	font-weight: bold !important;
	text-align: left !important;
	width: auto;
	padding: 0 10px;
	border-bottom: none;
	background: #3d3d3d;
	color: #fff;
	border-radius: 18px;
}

.form-control {
	border-radius: 0;
	font-size: 13px;
	margin-bottom: 7px;
	height: 28px;
	padding: .225rem .75rem;
}

label {
	display: inline-block;
	margin-bottom: 1.3px;
	font-size: 14px;
}

select.form-control {
	padding: .225rem 5px;
}

.form-control[readonly] {
	background-color: #fdfdfd;
}

input {
	border-radius: 5px;
}
</style>

</head>
<body>
	<form id="peter" >
		<div class="container">
			<div class="row">
				<div class="col-md-6 col-md-offset-3 ">
					<div class="panel panel-primary">
						<div class="panel-heading">Add Mail Content</div>
						<div class="panel-body box">
							<fieldset class="row form-group">
								<label class="control-label col-sm-4" for="">Email
									Subject Line:</label>
								<div class="col-sm-8">
									<input type="text" class="form-control"
										value="" required="required"
										name="subject" id="subject" />
								</div>

							</fieldset>
							<fieldset class="form-group">
								<label>Email Body Part:</label>
								<textarea rows="20" cols="" required="required" name="" id="msgBod"style="width: 100%;">	
																										
								</textarea>
							</fieldset>
							<input type="hidden" id="msg" name="msgBod">
							 <input type="button" class="btn btn-success" onclick="saveResp()" value="Save" id="btn_save">
						</div>
						<div>${msg}</div>
					</div>
				</div>
			</div>
		</div>
	</form>
	<script>
		
		
		
		if($('#msgBod').val()==''){
			
			$('#peter').find('.nicEdit-main').html('');
			
		}
		
		
		
		</script>
</body>
</html>
<%
     }catch(Exception e)
    {
    	  response.sendRedirect("sessionExpire");
    }
   %>

