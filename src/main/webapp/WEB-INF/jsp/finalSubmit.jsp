<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="java.util.ResourceBundle"%>

<%
try {
	ResourceBundle resource = ResourceBundle.getBundle("application");
	String baseServer = resource.getString("client.url");
	String title = resource.getString("app.title");
	String role = "";
	if (session.getAttribute("role") != null) {
		role = session.getAttribute("role").toString().trim();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="icon" type="image/x-icon"
	href="<%=baseServer%>img/DuflonFavicon.png" />
<title><%=title%></title>
<link rel="stylesheet" type="text/css" href="./css/upload-documents.css" />
<link rel="stylesheet" type="text/css" href="./css/common.css" />
<link rel="stylesheet" type="text/css" href="./css/profile.css" />
<link rel="stylesheet" href="./css/scrolltabs.css">
<link rel="stylesheet" type="text/css" href="./css/sweetalert.css" />
<script type="text/javascript" src="./js/sweetalert.min.js"></script>
<style>
.gray-btn {
	margin: 0px 10px 0px 0px;
}

.view-btn {
	width: 41px;
	text-align: center;
}

#cancelFeedback {
	border: 1px solid #DC3545 !important;
	color: #DC3545 !important;
	display: inline-block !important;
	background-color: white !important;
}

.upload-input {
	background: none;
	padding: 0;
	border: none;
	display: flex;
	align-items: center;
	justify-content: right !important;
	width: 390px !important
}

input#tnc {
	margin: 0px 15px 81px 0px
}

.viewFeedback {
	text-align: center;
}

#fsdmFeedback2 {
	background: #F7F7F7;
	border: 1px solid #D0D0D0;
	border-radius: 7px;
	color: #4D4D4D;
	padding: 11px 15px;
	font-size: 15px;
	font-family: Arial !important;
	line-height: 18px;
	outline: none;
	box-sizing: border-box;
}

#docType {
	background: #F7F7F7;
	border: 1px solid #D0D0D0;
	border-radius: 7px;
	color: #4D4D4D;
	padding: 11px 15px;
	font-size: 15px;
	font-family: Arial !important;
	line-height: 18px;
	outline: none;
	box-sizing: border-box;
}

#reason {
	background: #F7F7F7;
	border: 1px solid #D0D0D0;
	border-radius: 7px;
	color: #4D4D4D;
	padding: 11px 15px;
	font-size: 15px;
	font-family: Arial !important;
	line-height: 18px;
	outline: none;
	box-sizing: border-box;
}

.sa-button-container .cancel {
	border: 1px solid #DC3545 !important;
	color: #DC3545 !important;
	background-color: white !important;
}

#feedback_text {
	background: #F7F7F7;
	border: 1px solid #D0D0D0;
	border-radius: 7px;
	color: #4D4D4D;
	padding: 0px 25px;
	font-size: 15px;
	font-family: Arial !important;
	line-height: 18px;
	outline: none;
	box-sizing: border-box;
}

#feedback_text {
	padding: 10px !important;
	width: 345px;
	height: 80px;
}

.btns {
	text-align: center;
}
</style>

<script src="./js/jquery-3.4.1.min.js"></script>
<script src="./js/jquery.dataTables.min.js"></script>
<script src="./js/jquery.scrolltabs.js"></script>
</head>
<body>
	<div class="left-panel-include">
		<%@include file="./header/left-panel.jsp"%>
	</div>
	<div class="user-panel-include">
		<%@include file="./header/user-panel.jsp"%>
	</div>

	<div class="right-section">
		<h1 class="cen" style="text-align: center;">Final Submit</h1>
		<div class="container-1100">
			<div class="profile-container">
				<%@include file="./header/profileMenu.jsp"%>

				<div class="profile-content">
				<input type="hidden" name="accesskey" id="accesskey" value= "${participant.accessKey}">
					<%
					if (role.equalsIgnoreCase("HRE")) {
					%>
					<c:if
						test="${participant.hiredStatus != 'Y' && participant.status != 'H'}">
<%-- 						test="${participant.documents_status != 'final' && participant.hiredStatus != '2' && participant.status != 'H'}"> --%>
						<c:if test="${participant.documents_status == 'final'}">
							<p style="text-align:center;">All details and documents are submitted.</p>
						</c:if>
						<c:if test="${participant.documents_status != 'final'}">
						<div id="div_dealer">
							<div class="form-btn wtnc" style="border-top: none !important;">
								<input type="checkbox" id="tnc" />
								<div class="acc-tnc">
									<h3></h3>
									<p>
										<label> By submitting, I certify that the candidate
											details provided here are true and complete to the best of my
											knowledge and belief.<br> <br> I further declare
											that I have verified all the information and documents
											submitted by the candidate, in this connection.<br> <br>
											I promise to extend total cooperation and furnish relevant
											documents if required.
										</label>
									</p>
								</div>
							</div>
						</div>
						<div class="btns">
							<input type="button" id="submit" class="btn blue-btn"
								onclick="saveDacoment('final')" disabled value="Submit" />
						</div>
						</c:if>
					</c:if>
				</div>
				<%
				}
				%>
			</div>
		</div>
	</div>
	<script>
		$(document)
				.ready(
						function() {
							$('#tabs').scrollTabs();
							var profile = document.getElementById("profile");
							var final_submit = document
									.getElementById("final_submit");
							profile.className -= 'tab-btn tab_selected scroll_tab_first';
							final_submit.className += 'tab-btn tab_selected scroll_tab_first';

							function autoClicked() {
								var tabsl = $('#tabs span').length;
								for (let i = 1; i <= tabsl; i++) {
									if ($('#tabs span:nth-child(' + i + ')')
											.hasClass('tab_selected')) {
										$('#tabs span:nth-child(' + i + ')')
												.click();
									}
								}
							}
							autoClicked();
							$('#tnc').change(function() {
								if (this.checked) {
									$('#submit').removeAttr('disabled');
									console.log('d')
								} else {
									$('#submit').attr('disabled', true)
								}
							});

						});

		function saveDacoment(status) {
			var accessKey = $('#accesskey').val();
			swal(
					{
						title : "Are you sure you want to submit the details?",
						showCancelButton : true,
						confirmButtonColor : "#DC3545",
						confirmButtonText : "OK",
						closeOnConfirm : false
					},
					function(isConfirm) {
						if (isConfirm) {
							$('#submit').prop('disabled', true);
							$('#submit').val('Please wait');
							$('.confirm').prop('disabled', true);
							$
									.ajax({
										url : 'savedocuments',
										type : 'post',
										data : 'accesskey=' + accessKey
												+ '&status=' + status,
										success : function(res) {
											$('#submit')
													.prop('disabled', false);
											$('#submit').val('OK');
											$('.confirm').prop('disabled',
													false)
											if (res == "success") {
												showMSGSave("The candidate's application has been successfully submitted.");
											}
											if (res == "1" || res == "2"
													|| res == '3') {
												showMSGSave('Please fill in the mandatory fields and upload mandatory documents.')
											}

											if (res != "1" && res != "2"
													&& res != '3'
													&& res != "success") {
												showMSGSave(res)
											}

										},
										error : function(ress) {
											window.close();
										}
									});
						} else {
							return false;
						}
					});
		}
		function showMSGSave(msg) {

			swal({
				//title: "The candidate's application was successfully submitted for FSDM approval.",     
				title : msg,
				showCancelButton : false,
				confirmButtonColor : "#DC3545",
				confirmButtonText : "OK",
				closeOnConfirm : false
			}, function(isConfirm) {
				if (isConfirm) {
					location.reload();
				}
			});
		}

		function showView() {
			if ($('#viewsign').is(':visible') && old_mspin == "1") {
			}
		}
	</script>
</body>
</html>
<%
} else {
response.sendRedirect("login");
}
} catch (Exception e) {
System.out.println("Errror....." + e);
response.sendRedirect("login");
}
%>
