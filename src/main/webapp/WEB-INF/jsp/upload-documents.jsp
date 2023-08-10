<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import = "java.util.ResourceBundle" %>

<%
try
    {
	ResourceBundle resource = ResourceBundle.getBundle("application");
String baseServer = resource.getString("client.url");String title = resource.getString("app.title");
String role="";
if(session.getAttribute("role") != null){
	role = session.getAttribute("role").toString().trim();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="icon" type="image/x-icon" href="<%=baseServer%>img/DuflonFavicon.png"/>
<title><%=title %></title>
<link rel="stylesheet" type="text/css" href="./css/common.css" />

<link rel="stylesheet" type="text/css" href="./css/profile.css" />
<link rel="stylesheet" href="./css/scrolltabs.css">
<link rel="stylesheet" type="text/css" href="./css/upload-documents.css" />
<link rel="stylesheet" type="text/css" href="./css/sweetalert.css"/>
       <script type="text/javascript" src="./js/sweetalert.min.js"></script>
<style>
.form-btn{width: 100% !important;}
.gray-btn{
    margin: 0px 10px 0px 0px;
}
.view-btn{
    width: 41px !important;
    text-align: center;
    /* margin: 0px; */
}
a#viewresume {
	text-align: center;
    width: 41px !important;
}
.sa-button-container .cancel {border: 1px solid #DC3545 !important;color: #DC3545 !important;display: inline-block !important;background-color: white !important;}
.upload-input {
    background: none;
    padding: 0;
    border: none;
    display: flex;
    align-items: center;
    justify-content: right !important;
	margin-left: auto !important;
    /* width: 390px !important; */
}
.ir-check{padding: 5px;}
.ir-cross{padding: 5px;}
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
		<h1 class="cen" style="text-align: center;">Document Upload Details</h1>
		<div class="container-1100">
			<div class="profile-container">
				<%@include file="./header/profileMenu.jsp"%>

				<div class="profile-content">
					<form action="upload" method="post" class="form">
						<div class="upload-section no-bor-mar-pad" id="photodiv">
							<input type="hidden" id="accesskey"
								value="${participant.accessKey}">
							<h5>
								Photograph <span>*</span>
							</h5>
							<div class="upload-tnc">
								<p>Upload file in JPEG, PNG and PDF under 500KB</p>
								<p>in 252x252PX</p>
								<div class="success-tnc" id="successphoto"><img src="./img/check-icn.png" /> Successfully uploaded</div>
								<div class="error-tnc" id="errorphoto"><img src="./img/cross-icn.png" /> Please Upload Valid file format</div>
							</div>
							<div class="upload-input">
							<c:if test="${participant.status !='H' || participant.hiredStatus != 'Y'}">
								<%if(role.equalsIgnoreCase("HRE")) { %>
								<div class="file-upload">
									<div class="file-upload-select"
										onclick="$(this).parent().find('input[type=file]').click();">
										<div class="file-select-button">Choose File</div>
										<div class="file-select-name">No file chosen</div>
									</div>
									<input type="file" name="photo-input" id="photofile"
										onchange="$(this).parent().find('.file-select-name').html($(this).val().split(/[\\|/]/).pop());"
										style="display: none;"
										accept=".jpg, .jpeg, .png, .png"/>
								</div>
								 <input type="hidden" value="photograph" id="photo">
								<input type="button" class="gray-btn upload-btn" data-id="signature-input" 
								onclick="uploadFile('photofile','photo','successphoto','errorphoto','viewphoto','photodiv','loader_photo','imgphoto')" value="Upload"/>
								<%} %>
								</c:if>
								<c:choose>
								  <c:when test="${not empty participant.photograph }">
							    <img class="ir-check" src="./img/check-icn.png" id="imgphoto"/>
							    </c:when>
								 <c:otherwise>
                                 <img class="ir-cross" src="./img/cross-icn.png" id="imgphoto" />
                                </c:otherwise>
							    </c:choose>
								<a href="images/${participant.photograph}" class="view-btn gray-btn" target="_blank" id="viewphoto" >View</a>	
                                <img class="preview" id="loader_photo" src="./img/loader.gif" style="width: 20px; display:none;">								
							</div>
						</div>
						<div class="upload-section" id="signdiv">
							<h5>
								Signature <span>*</span>
							</h5>
							<div class="upload-tnc">
								<p>Upload file in JPEG, PNG and JPG under 500KB</p>
								<div class="success-tnc" id="successign"><img src="./img/check-icn.png" /> Successfully uploaded</div>
								<div class="error-tnc" id="errorsign"><img src="./img/cross-icn.png" /> Please Upload Valid file format</div>
							</div>
							<div class="upload-input">
								
									<c:if test="${participant.status !='H' || participant.hiredStatus != 'Y'}">
								<%if(role.equalsIgnoreCase("HRE")) { %>
								<div class="file-upload">
									<div class="file-upload-select"
										onclick="$(this).parent().find('input[type=file]').click();">
										<div class="file-select-button">Choose File</div>
										<div class="file-select-name">No file chosen</div>
									</div>
									<input type="file" name="signature-input" id="signaturefile"
										onchange="$(this).parent().find('.file-select-name').html($(this).val().split(/[\\|/]/).pop());"
										style="display: none;"
										accept=".jpg, .jpeg, .png, .png"/>
								</div>
								 <input type="hidden" value="signature" id="signature">
								<input type="button" class="gray-btn upload-btn" data-id="signature-input" 
								onclick="uploadFile('signaturefile','signature','successign','errorsign','viewsign','signdiv','loader_sign','imgsign')" value="Upload"/>
								<%} %>
								</c:if>
								<c:choose>
								  <c:when test="${not empty participant.signature }">
							    <img class="ir-check" src="./img/check-icn.png"  id="imgsign"/>
							    </c:when>
								 <c:otherwise>
                                 <img class="ir-cross" src="./img/cross-icn.png" id="imgsign"/>
                                </c:otherwise>
							    </c:choose>
								<a href="images/${participant.signature}" class="view-btn gray-btn" target="_blank"id="viewsign" 
								<c:if test="${participant.signature == '' || participant.signature == null}">style="opacity:0.5;cursor: no-drop;pointer-events: none;" </c:if> >View</a>
									  <img class="preview" id="loader_sign" src="./img/loader.gif" style="width: 20px; display:none;">
							</div>
						</div>
						<div class="upload-section" id="identitydiv">
							<h5>
								Identity Proof <span>*</span>
							</h5>
							<div class="upload-tnc">
								<select id="identity_proof">
									<option value="">Select</option>
									<option value="AD">Aadhaar Card</option>
									<option value="PA">PAN Card</option>									
									<option value="VI">Voter ID</option>
									<option value="DL">Driving License</option>
									<option value="PS">Passport</option>
									<option value="Others">Others</option>									
								</select>
							 <p id = "pidenty">Upload file in PDF, JPEG, PNG and JPG under 1MB</p>
                                <div class="success-tnc" id = "succesidentity"><img src="./img/check-icn.png" /> Successfully uploaded</div>
                                <div class="error-tnc" id = "erroridentity"><img src="./img/cross-icn.png" /> Please select proof type</div>
							</div>
							<div class="upload-input">
								
								<c:if test="${participant.status !='H' || participant.hiredStatus != 'Y'}">
								<%if(role.equalsIgnoreCase("HRE")) { %>
								<div class="file-upload">
									<div class="file-upload-select"
										onclick="$(this).parent().find('input[type=file]').click();">
										<div class="file-select-button">Choose File</div>
										<div class="file-select-name">No file chosen</div>
									</div>
									
									<input type="file" name="identity-input" id="identity-input"
										onchange="$(this).parent().find('.file-select-name').html($(this).val().split(/[\\|/]/).pop());"
										style="display: none;" accept=".pdf, .jpg, .jpeg, .png, .png" data-max-size="1000">
								</div>
								 <input type="hidden" value="identitityProof" id="identity">
								<input class="gray-btn upload-btn" data-id="identity-input"type="button" 
								onclick="uploadFile('identity-input','identity','succesidentity','erroridentity','viewidentity','identitydiv','loader_identity','imgId')"
								value="Upload">
								<%} %>
								</c:if>
								<c:choose>
								  <c:when test="${not empty participant.identitityProof }">
							    <img class="ir-check" src="./img/check-icn.png" id="imgId"/>
							    </c:when>
								 <c:otherwise>
                                 <img class="ir-cross" src="./img/cross-icn.png" id="imgId"/>
                                </c:otherwise>
							    </c:choose>
								<a href="images/${participant.identitityProof}" class="view-btn gray-btn" id="viewidentity"  target="_blank"
								<c:if test="${participant.identitityProof == '' || participant.identitityProof == null}">style="opacity:0.5;cursor: no-drop;
									pointer-events: none;" </c:if>
								>View</a>
								 <img class="preview" id="loader_identity" src="./img/loader.gif" style="width: 20px; display:none;">
							</div>
						</div>
						<div class="upload-section" id="addressdiv">
							<h5>
								Address Proof <span>*</span>
							</h5>
							<div class="upload-tnc">
								<select id="address_proof">
									<option value="">Select</option>
									<option value="Aadhar Card">Aadhar Card</option>
									<option value="Voter ID Card">Voter ID Card</option>
									<option value="Passport">Passport</option>
									
									<option value="Ration Card with address">Ration Card with address</option>
									<option value="Bank Passbook">Bank Passbook</option>
									<option value="Electricity Bill (not older than last three months)">Electricity Bill (not older than last three months)</option>
									<option value="Telephone Bill (not older than last three months)">Past Telephone Bill (not older than last three months)</option>
									<option value="Water Bill (not older than last three months)">Water Bill (not older than last three months)</option>
									<option value="Registered Sale/ Rent Agreement">Registered Sale/ Rent Agreement</option>
									<option value="Others">Others</option>
									
								</select>
							  <p id = "pm">Upload file in PDF, JPEG, PNG and JPG under 1MB</p>
                                <div class="success-tnc" id = "succesaddress"><img src="./img/check-icn.png" /> Successfully uploaded</div>
                                <div class="error-tnc" id = "erroraddress"><img src="./img/cross-icn.png" /> Please select proof type</div>
							</div>
							<div class="upload-input">
								
								<c:if test="${participant.status !='H' || participant.hiredStatus != 'Y'}">
								<%if(role.equalsIgnoreCase("HRE")) { %>
								<div class="file-upload">
									<div class="file-upload-select"
										onclick="$(this).parent().find('input[type=file]').click();">
										<div class="file-select-button">Choose File</div>
										<div class="file-select-name">No file chosen</div>
									</div>
									<input type="file" name="address-input" id="address"
										onchange="$(this).parent().find('.file-select-name').html($(this).val().split(/[\\|/]/).pop());"
										style="display: none;" style="display: none;" accept=".pdf, .jpg, .jpeg, .png, .png" >
								</div>
								 <input type="hidden" value="addressProof" id="Address_proof">
								<input type="button" class="gray-btn upload-btn" data-id="address-input" 
								onclick="uploadFile('address','Address_proof','succesaddress','erroraddress','viewaddress','addressdiv','loader_address','imgAddress')" 
								value="Upload" value="Upload">
								<%} %>
								</c:if>
								<c:choose>
								  <c:when test="${not empty participant.addressProof }">
							    <img class="ir-check" src="./img/check-icn.png" id="imgAddress"/>
							    </c:when>
								 <c:otherwise>
                                 <img class="ir-cross" src="./img/cross-icn.png" id="imgAddress"/>
                                </c:otherwise>
							    </c:choose>
								<a href="images/${participant.addressProof}" class="view-btn gray-btn" id="viewaddress"  target="_blank"
								<c:if test="${participant.addressProof == '' || participant.addressProof == null}">style="opacity:0.5;cursor: no-drop;
									pointer-events: none;" </c:if>
								>View</a>
								<img class="preview" id="loader_address" src="./img/loader.gif" style="width: 20px; display:none;">
							</div>
						</div>

						<div class="upload-section" id="qualydiv">
							<h5 id="pq"   style="color: black;">
								Qualification
							</h5>
							<div class="upload-section" id="qualydiv" style="width: 100% !important; border-top: none !important;">

							<h5 class="qual" id="pq m-0 p-0">
								10th<span>*</span>
							</h5>
							<div class="upload-tnc">
								<div id=presign>
									<p>Class 10th (SSC / Matriculation)</p>
									<p>Upload file in PDF, JPEG, PNG and JPG under 1MB</p>
								</div>
								<div class="success-tnc" id="successqualy">
									<img src="./img/check-icn.png" /> Successfully uploaded
								</div>
								<div class="error-tnc" id="errorqualy">
									<img src="./img/cross-icn.png" /> Please Upload Valid file format
								</div>
							</div>
							<div class="upload-input">
								
									<c:if test="${participant.status !='H' || participant.hiredStatus != 'Y'}">
								<%if(role.equalsIgnoreCase("HRE")) { %>
								<div class="file-upload">
									<div class="file-upload-select"
										onclick="$(this).parent().find('input[type=file]').click();">
										<div class="file-select-button">Choose File</div>
										<div class="file-select-name">No file chosen</div>
									</div>
									<input type="file" name="qualification" id="qualification"
										onchange="$(this).parent().find('.file-select-name').html($(this).val().split(/[\\|/]/).pop());"
										style="display: none;" accept=".pdf,.jpg, .jpeg, .png, .png,">
								</div>
								<input type="hidden" value="10th" id="quth10"> <input
									class="gray-btn upload-btn" data-id="qualification-input"
									type="button"
									onclick="uploadFile('qualification','quth10','successqualy','errorqualy','viewqualy','qualydiv','loader_qualy','imgque_1')"
									value="Upload" value="Upload" >
								<%} %>
								</c:if>
								<c:choose>
								  <c:when test="${not empty participant.qualification }">
							    <img class="ir-check" src="./img/check-icn.png" id="imgque_1"/>
							    </c:when>
								 <c:otherwise>
                                 <img class="ir-cross" src="./img/cross-icn.png" id="imgque_1"/>
                                </c:otherwise>
							    </c:choose>
								<a href="images/${participant.qualification}" class="view-btn gray-btn"
									id="viewqualy" target="_blank"
									<c:if test="${participant.qualification == '' || participant.qualification == null}">style="opacity:0.5;cursor: no-drop;
										pointer-events: none;" </c:if>>View</a>
									<img class="preview" id="loader_qualy" src="./img/loader.gif" style="width: 20px; display:none;">
							</div>
						    </div>
						</div>
						<!--  ////////// -->
						<div class="upload-section" id="quth12div" style="border-top:none !important;">
							<h5 id="presigletter">
								12th<span>*</span>
							</h5>
							<div class="upload-tnc">
								<div id=presign>
									<p>Diploma/Class 12th (HSC / Intermediate)</p>
									<p>Upload file in PDF, JPEG, PNG and JPG under 1MB</p>
								</div>
								<div class="success-tnc" id="succesquth12">
									<img src="./img/check-icn.png" /> Successfully uploaded
								</div>
								<div class="error-tnc" id="errorrquth12">
									<img src="./img/cross-icn.png" /> Please Upload Valid file format
								</div>
							</div>
							<div class="upload-input">
								
								<c:if test="${participant.status !='H' || participant.hiredStatus != 'Y'}">
								<%if(role.equalsIgnoreCase("HRE")) { %>
								<div class="file-upload">
									<div class="file-upload-select"
										onclick="$(this).parent().find('input[type=file]').click();">
										<div class="file-select-button">Choose File</div>
										<div class="file-select-name">No file chosen</div>
									</div>
									<input type="file" name="resigningLetter" id="quth12-input"
										onchange="$(this).parent().find('.file-select-name').html($(this).val().split(/[\\|/]/).pop());"
										style="display: none;" accept=".pdf,.jpg, .jpeg, .png, .png">
								</div>
								<input type="hidden" value="12th" id="quth12"> <input
									class="gray-btn upload-btn" data-id="resignation-input"
									type="button"
									onclick="uploadFile('quth12-input','quth12','succesquth12','errorrquth12','viewrquth12','quth12div','loader_quth12','imgque_2')"
									value="Upload" value="Upload" >
								<%} %>
								</c:if>
								<c:choose>
								  <c:when test="${not empty participant.qualification2 }">
							    <img class="ir-check" src="./img/check-icn.png" id="imgque_2"/>
							    </c:when>
								 <c:otherwise>
                                 <img class="ir-cross" src="./img/cross-icn.png" id="imgque_2"/>
                                </c:otherwise>
							    </c:choose>
								<a href="images/${participant.qualification2}" class="view-btn gray-btn"
									id="viewrquth12" target="_blank"
									<c:if test="${participant.qualification2 == '' || participant.qualification2 == null}">style="opacity:0.5;cursor: no-drop;
										pointer-events: none;" </c:if>>View</a>
									<img class="preview" id="loader_quth12" src="./img/loader.gif" style="width: 20px; display:none;">
							</div>
						</div>

						<div class="upload-section" id="gradudiv" style="border-top:none !important;">
							<h5 id="presigletter">
							Graduation and above <span>*</span>
							</h5>
							<div class="upload-tnc">
								<div id=presign>
									<p>Diploma, Graduation, Post-Graduation, Others (if any)</p>
									<p>Upload file in PDF, JPEG, PNG and JPG under 1MB</p>
								</div>
								<div class="success-tnc" id="succesgradu">
									<img src="./img/check-icn.png" /> Successfully uploaded
								</div>
								<div class="error-tnc" id="errorrgradu">
									<img src="./img/cross-icn.png" /> Please Upload Valid file format
								</div>
							</div>
							<div class="upload-input">
								
								<c:if test="${participant.status !='H' || participant.hiredStatus != 'Y'}">
								<%if(role.equalsIgnoreCase("HRE")) { %>
								<div class="file-upload">
									<div class="file-upload-select"
										onclick="$(this).parent().find('input[type=file]').click();">
										<div class="file-select-button">Choose File</div>
										<div class="file-select-name">No file chosen</div>
									</div>
									<input type="file" name="resigningLetter" id="graduation"
										onchange="$(this).parent().find('.file-select-name').html($(this).val().split(/[\\|/]/).pop());"
										style="display: none;" accept=".pdf,.jpg, .jpeg, .png, .png">
								</div>
								<input type="hidden" value="Graduation" id="gradu"> <input
									class="gray-btn upload-btn" data-id="resignation-input"
									type="button"
									onclick="uploadFile('graduation','gradu','succesgradu','errorrgradu','viewrgradu','gradudiv','loader_gradu','imgque_3')"
									value="Upload" value="Upload" >
								<%} %>
								</c:if>
								<c:choose>
								  <c:when test="${not empty participant.qualification3 }">
							    <img class="ir-check" src="./img/check-icn.png" id="imgque_3"/>
							    </c:when>
								 <c:otherwise>
                                 <img class="ir-cross" src="./img/cross-icn.png" id="imgque_3"/>
                                </c:otherwise>
							    </c:choose>
								<a href="images/${participant.qualification3}" class="view-btn gray-btn"
								id="viewrgradu" target="_blank" <c:if test="${participant.qualification3 == '' || participant.qualification3 == null}">style="opacity:0.5;cursor: no-drop;pointer-events: none;" </c:if>>View</a>
							     <img class="preview" id="loader_gradu" src="./img/loader.gif" style="width: 20px; display:none;">
							</div>
						</div>
					<div class="upload-section" id="resigndiv" <c:if test="${participant.fresher == 'fresher' }"> style=" display:none;"</c:if>>
						<h5 id="pq" style="color: black;">
							Work Experience
						</h5>
						<div class="upload-section" id="resigndiv"  style="width: 100% !important; border-top: none !important;">
							<h5>Resignation Letter</h5>
							<div class="upload-tnc">
								<p>Upload Resignation Letter</p>
								<p>Upload file in PDF, JPEG, PNG and JPG under 1MB</p>
								 <div class="success-tnc" id = "succesresign"><img src="./img/check-icn.png" /> Successfully uploaded</div>
                                 <div class="error-tnc" id = "errorresign"><img src="./img/cross-icn.png" /> Please Upload Valid file format</div>
							</div>
							<div class="upload-input">
								
							<c:if test="${participant.status !='H' || participant.hiredStatus != 'Y'}">
								<%if(role.equalsIgnoreCase("HRE")) { %>
								<div class="file-upload">
									<div class="file-upload-select"
										onclick="$(this).parent().find('input[type=file]').click();">
										<div class="file-select-button">Choose File</div>
										<div class="file-select-name">No file chosen</div>
									</div>
									<input type="file" name="resignation-input"
										id="resignation-input"
										onchange="$(this).parent().find('.file-select-name').html($(this).val().split(/[\\|/]/).pop());"
										style="display: none;" accept=".pdf,.jpg, .jpeg, .png, .png">
								</div>
								 <input type="hidden" value="resigningLetter" id="resignation">
								<input type="button" 
								<c:if	test="${participant.fresher == 'fresher' }"> style=" background-color: #dad9d9;"</c:if>
								class="gray-btn upload-btn" data-id="resignation-input" onclick="uploadFile('resignation-input','resignation','succesresign','errorresign','viewresign','resigndiv','loader_resign','imgwork_1')" value="Upload">
								<%} %>
								</c:if>
								<c:choose>
								  <c:when test="${not empty participant.resignationLetter }">
							    <img class="ir-check" src="./img/check-icn.png" id="imgwork_1"/>
							    </c:when>
								 <c:otherwise>
                                 <img class="ir-cross" src="./img/cross-icn.png" id="imgwork_1" />
                                </c:otherwise>
							    </c:choose>
								<a href="images/${participant.resignationLetter}" class="view-btn gray-btn" id="viewresign" target="_blank"
								<c:if test="${participant.resignationLetter == '' || participant.resignationLetter == null}">style="opacity:0.5;cursor: no-drop;
									pointer-events: none;" </c:if>>View</a>
								 <img class="preview" id="loader_resign" src="./img/loader.gif" style="width: 20px; display:none;">
							</div>
						</div>
					</div>
						<div class="upload-section" id="exprncdiv"  style="border-top:none !important;<c:if	test="${participant.fresher == 'fresher' }"> display:none;</c:if>" >
							<h5>Relieving Letter</h5>
							<div class="upload-tnc">
								<p>Upload Experience /Relieving Letter</p>
								<p>Upload file in PDF, JPEG, PNG and JPG under 1MB</p>
								 <div class="success-tnc" id = "succexprnc"><img src="./img/check-icn.png" /> Successfully uploaded</div>
                                 <div class="error-tnc" id = "errorexprnc"><img src="./img/cross-icn.png" /> Please Upload Valid file format</div>
							</div>
							<div class="upload-input">
								
								<c:if test="${participant.status !='H' || participant.hiredStatus != 'Y'}">
								<%if(role.equalsIgnoreCase("HRE")) { %>
								<div class="file-upload" >
									<div class="file-upload-select"  
										onclick="$(this).parent().find('input[type=file]').click();">
										<div class="file-select-button">Choose File</div>
										<div class="file-select-name">No file chosen</div>
									</div>
									<input type="file" name="experience-input" 
										id="experience-input"
										onchange="$(this).parent().find('.file-select-name').html($(this).val().split(/[\\|/]/).pop());"
										style="display: none;" accept=".pdf,.jpg, .jpeg, .png, .png">
								</div>
								<input type="hidden" value="experienceletter" id="experience">
								<input type="button" class="gray-btn upload-btn" 
								<c:if	test="${participant.fresher == 'fresher' }"> style=" background-color: #dad9d9;"</c:if> 
	                         	   data-id="experience-input" 
	                         	   onclick="uploadFile('experience-input','experience','succexprnc','errorexprnc','viewrexprnc','exprncdiv','loader_exprnc','imgwork_2')" 
	                         	   value="Upload" value="Upload"  >
								<%} %>
								</c:if>
								<c:choose>
								  <c:when test="${not empty participant.experienceletter }">
							    <img class="ir-check" src="./img/check-icn.png" id="imgwork_2"/>
							    </c:when>
								 <c:otherwise>
                                 <img class="ir-cross" src="./img/cross-icn.png" id="imgwork_2"/>
                                </c:otherwise>
							    </c:choose>
								<a href="images/${participant.experienceletter}" class="view-btn gray-btn" target="_blank" id="viewrexprnc" 
									<c:if test="${participant.experienceletter == '' || participant.experienceletter == null}">style="opacity:0.5;cursor: no-drop;
										pointer-events: none;" </c:if>>View</a>
									<img class="preview" id="loader_exprnc" src="./img/loader.gif" style="width: 20px; display:none;">
							</div>
						</div>
						<div class="upload-section" id="salarydiv"  style=" width: 100% !important; border-top:none !important; <c:if	test="${participant.fresher == 'fresher' }"> display:none;</c:if>" >
							<h5>Salary Slip</h5>
							<div class="upload-tnc">
								<p>Upload Salary Slip</p>
								<p>Upload file in PDF, JPEG, PNG and JPG under 1MB</p>
								 <div class="success-tnc" id = "successlary"><img src="./img/check-icn.png" /> Successfully uploaded</div>
                                 <div class="error-tnc" id = "errorsalary"><img src="./img/cross-icn.png" /> Please Upload Valid file format</div>
							</div>
							<div class="upload-input">
								
									<c:if test="${participant.status !='H' || participant.hiredStatus != 'Y'}">
								<%if(role.equalsIgnoreCase("HRE")) { %>
								<div class="file-upload">
									<div class="file-upload-select"
										onclick="$(this).parent().find('input[type=file]').click();">
										<div class="file-select-button">Choose File</div>
										<div class="file-select-name">No file chosen</div>
									</div>
									<input type="file" name="salary-input" id="salary-input"
										onchange="$(this).parent().find('.file-select-name').html($(this).val().split(/[\\|/]/).pop());"
										style="display: none;" accept=".pdf,.jpg, .jpeg, .png, .png">
								</div>
								  <input type="hidden" value="salaryslip" id="salary">
								<input  type="button" 
								<c:if	test="${participant.fresher == 'fresher' }"> style=" background-color: #dad9d9;"</c:if>
								class="gray-btn upload-btn" data-id="salary-input"
								 onclick="uploadFile('salary-input','salary','successlary','errorsalary','viewrsalary','salarydiv','loader_salary','imgwork_3')" 
								 value="Upload" value="Upload" >
								<%} %>
								</c:if>
								<c:choose>
								  <c:when test="${not empty participant.salarySlip }">
							    <img class="ir-check" src="./img/check-icn.png" id="imgwork_3" />
							    </c:when>
								 <c:otherwise>
                                 <img class="ir-cross" src="./img/cross-icn.png" id="imgwork_3" />
                                </c:otherwise>
							    </c:choose>
								<a href="images/${participant.salarySlip}" class="view-btn gray-btn" id="viewrsalary" target="_blank"
								<c:if test="${participant.salarySlip == '' || participant.salarySlip == null}">style="opacity:0.5;cursor: no-drop;
									pointer-events: none;" </c:if> >View</a>
									<img class="preview" id="loader_salary" src="./img/loader.gif" style="width: 20px; display:none;">
							</div>
						</div>
						<div class="upload-section" id="resumediv">
							<h5>
								Resume <span>*</span>
							</h5>
							<div class="upload-tnc">
					      <p>Upload file in WORD and PDF under 1MB</p>
						  <div class="success-tnc" id = "succesresume"><img src="./img/check-icn.png" /> Successfully uploaded</div>
                          <div class="error-tnc" id = "errorresume"><img src="./img/cross-icn.png" /> Please Upload Valid file format</div>
								    
							</div>
							<div class="upload-input">
							
							    <c:if test="${participant.status !='H' || participant.hiredStatus != 'Y'}">
					<%if(role.equalsIgnoreCase("HRE")) { %>
					<div class="file-upload">
						<div class="file-upload-select"
							onclick="$(this).parent().find('input[type=file]').click();">
							<div class="file-select-button">Choose File</div>
							<div class="file-select-name">No file chosen</div>
						</div>
						<input type="file" name="resume-input" id="resume-input"
							onchange="$(this).parent().find('.file-select-name').html($(this).val().split(/[\\|/]/).pop());"
							style="display: none;" accept=".pdf, .docx, .doc ">
					</div>
					   <input type="hidden" value="resume" id="resume">
					<input type="button" class="gray-btn upload-btn" data-id="any-input" 
					onclick="uploadFile('resume-input','resume','succesresume','errorresume','viewresume','resumediv','loader_resume','imgwork_4')" 
					value="Upload" value="Upload" >
					<%} %>
					</c:if>
								<c:choose>
								  <c:when test="${not empty participant.resume }">
							    <img class="ir-check" src="./img/check-icn.png"  id="imgwork_4"/>
							    </c:when>
								 <c:otherwise>
                                 <img class="ir-cross" src="./img/cross-icn.png" id="imgwork_4"/>
                                </c:otherwise>
							    </c:choose>
								<a href="images/${participant.resume}" class="gray-btn upload-btn" target="_blank" id="viewresume" >View</a>
								<img class="preview" id="loader_resume" src="./img/loader.gif" style="width: 20px; display:none;">
							</div>
					
			          </div>
			        </form>
			<div class="upload-section" id="otherdiv">
				<h5>Any other document</h5>
				<div class="upload-tnc">
					<p>Upload Any other document</p>
					<p>Upload file in PDF, JPEG, PNG and JPG under 1MB</p>
					<div class="success-tnc" id = "succesdoc"><img src="./img/check-icn.png" /> Successfully uploaded</div>
                    <div class="error-tnc" id = "errordoc"><img src="./img/cross-icn.png" /> Please Upload Valid file format</div>
				</div>
				<div class="upload-input">
					
					<c:if test="${participant.status !='H' || participant.hiredStatus != 'Y'}">
					<%if(role.equalsIgnoreCase("HRE")) { %>
					<div class="file-upload">
						<div class="file-upload-select"
							onclick="$(this).parent().find('input[type=file]').click();">
							<div class="file-select-button">Choose File</div>
							<div class="file-select-name">No file chosen</div>
						</div>
						<input type="file" name="any-input" id="any-input"
							onchange="$(this).parent().find('.file-select-name').html($(this).val().split(/[\\|/]/).pop());"
							style="display: none;" accept=".pdf,.jpg, .jpeg, .png, .png">
					</div>
					   <input type="hidden" value="documents" id="other">
					<input type="button" class="gray-btn upload-btn" data-id="any-input" 
					onclick="uploadFile('any-input','other','succesdoc','errordoc','otherview','otherdiv','loader_other','imgother')" 
					value="Upload" value="Upload" >
					<%} %>
					</c:if>
							<c:choose>
								  <c:when test="${not empty participant.documents }">
							    <img class="ir-check" src="./img/check-icn.png" id="imgother"/>
							    </c:when>
								 <c:otherwise>
                                 <img class="ir-cross" src="./img/cross-icn.png" id="imgother" />
                                </c:otherwise>
							    </c:choose>
					<a href="images/${participant.documents}" class="view-btn gray-btn ir-view" id="otherview" target="_blank"
					<c:if test="${participant.documents == '' || participant.documents == null}">style="opacity:0.5;cursor: no-drop;
						pointer-events: none;" </c:if>>View</a>
					<img class="preview" id="loader_other" src="./img/loader.gif" style="width: 20px; display:none;">
				</div>
			</div>
			
			 <%if(role.equalsIgnoreCase("HRE")) { %>
                  <div class="form-btn">
                     <c:if test="${(participant.status !='H' || participant.hiredStatus != 'Y') && participant.status !='H'}">
                        <!--  <input class="btn blue-btn" type="submit" value="Next" id="submit"  onclick="next()"/> -->
                             <a href="#" class="btn blue-btn" id="btn_next"  onclick="saveDacoment()">Next</a>
                     </c:if>
                  </div>
                  <%} %>
				</div><!-- Profile container -->
		</div>
	</div>
	<!-- Profile Container-->
	</div>
	<div class="blk-bg"></div>
	<input type="hidden" id="accesskey" value="${participant.accessKey}">
	<script>
      $(document).ready(function () {
		  $("#identity_proof").val('${participant.identitityProofName}');
    	  $("#address_proof").val('${participant.addressProofName}');
		   if('${participant.hiredStatus}' == 'Y'){
			//$(".upload-btn").hide(); 
             $(".file-upload").hide();
             $("#btn_next").hide();			
		   }
    	  <%if(role.equalsIgnoreCase("LM")) { %>
    	  $('input').attr('disabled', 'disabled');
    	  $('select').attr('disabled', 'disabled');
		  $('#save_feedback').prop('disabled', false);
		  $('#btn_approve').prop('disabled', false);
		   
    	  <%}%>
        $('#tabs').scrollTabs();
		var profile = document.getElementById("profile");
        var upload_documents = document.getElementById("upload_documents");
		profile.className -= 'tab-btn tab_selected scroll_tab_first';
        upload_documents.className += ' tab-btn tab_selected scroll_tab_first'
        
        function autoClicked(){
            var tabsl = $('#tabs span').length;
            for(let i = 1; i <= tabsl; i++){
            if($('#tabs span:nth-child('+i+')').hasClass('tab_selected')){
                $('#tabs span:nth-child('+i+')').click();
            }
            }
        }
        autoClicked();
            $('#tnc').change(function() {
                if(this.checked) {
                    $('#submit').removeAttr('disabled');
                    console.log('d')
                } else{
                    $('#submit').attr('disabled', true)
                }
            });

       $('#fsdm-feedback').click(function(){
          $('.blk-bg, .feedback-popup').show();
        });
        $('.cancel-popup').click(function(){
          $('.blk-bg, .feedback-popup').hide();
        }); 
        });
      
      function viewFeedback(){
    	  $('.blk-bg, .feedback-popup').show();
      }
      
      function approve(){
    	  $('.blk-bg, .key-popup').show(); 
      }
      
      function no(){
    	  $('.blk-bg, .key-popup').hide();   
      }
      
      function yes(){  
    	  var accesskey =  $("#accesskey").val();
		 $('#btn_approve').prop('disabled', true);
   	     $('#btn_approve').val('Please wait');
			 $.ajax({
			  type: "get",
			  url:  "approvel",
			  data: "accesskey="+accesskey,
			  success: function(data){
				   $('#btn_approve').prop('disabled', false);
				   swal({   
					  title: "You have approved the application of the candidate for MSPIN generation",     
					  showCancelButton: true,
					  confirmButtonColor: "#DC3545",   
					  confirmButtonText: "OK",  
                      cancelButtonText: "Cancel",							  
					  closeOnConfirm: false },
					  function(isConfirm){
					  $('.blk-bg, .key-popup').hide(); 
				       window.location.reload();
					}); 
			  },
			  error: function(errorThrown){
			  }
		  });  
      }
      
      function saveFeedbck(){
    	var feedback =  $("#feedback-text").val();
    	var accesskey =  $("#accesskey").val();
		if(feedback == ""){
			showMSG("Please enter feedback ");
           return false ;					
			
		}
		$('#save_feedback').prop('disabled', true);
   	    $('#save_feedback').val('Please wait');
		  $('.blk-bg, .feedback-popup').hide();
		  swal({   
					  title: "Proceed to REJECT candidate's application.",     
					  showCancelButton: true,
					  confirmButtonColor: "#DC3545",   
					  confirmButtonText: "OK", 
                      cancelButtonText: "Cancel",					  
					  closeOnConfirm: false },
					  function(isConfirm){
					  if(isConfirm){
    	  $.ajax({
			  type: "get",
			  url:  "feedback",
			  data: "accesskey="+accesskey+"&feedback="+feedback,
			  success: function(data){
			$('#btndDate').prop('disabled', false);
			 $('#btndDate').val('OK');
				 swal({   
					  title: "You have rejected candidate's application.",     
					  showCancelButton: false,
					  confirmButtonColor: "#DC3545",   
					  confirmButtonText: "OK",  							  
					  closeOnConfirm: false },
					  function(isConfirm){
					  $('.blk-bg, .key-popup').hide(); 
				       window.location.reload();
					}); 
			  },
			  error: function(errorThrown){
			  }
		  }); 
             }else{
			  $('#save_feedback').prop('disabled', false);
   	         $('#save_feedback').val('Submit');		 
			 $('#btndDate').prop('disabled', false);
			 $('#btndDate').val('OK');
					 return false;
					}
					}); 
      }
      
      function showView(){
		 	if($('#viewsign').is(':visible') && old_mspin=="1" ){
            }				  
	  }
      
      function uploadFile(fileName,name,success,error,view,div,loader,imgcheck)
      {   	
      	 var files = document.getElementById(fileName).files[0];
      	 var filesName = document.getElementById(name).value;
      	 var msg_error = document.getElementById(error);
      	 var msg_success = document.getElementById(success);
      	 var view_file = document.getElementById(view);
      	 var msg_div = document.getElementById(div);
		 var msg_loader = document.getElementById(loader);
      	 var identity_proof = document.getElementById("identity_proof").value;
      	 var address_proof = document.getElementById("address_proof").value;
      	 var accessKey = $('#accesskey').val();
         var fd = new FormData();
          if(filesName=="identitityProof" && identity_proof ==""){
           msg_error.style.display = 'block';
    	   msg_success.style.display = 'none'; 
    	   msg_div.className += ' error'
        	  return;
          }
		  else if(filesName == 'resume'){
	   if (!isResume(document.getElementById(fileName).value)) {
      	showMSG('Document/file type is not valid. Please upload valid document/file as per the specifications.');
          return ;
	   }  
	  }
		  else{
			 
		  if (!isSign(document.getElementById(fileName).value)) {
      	    showMSG('Document/file type is not valid. Please upload valid document/file as per the specifications.');
          return ;
	   }
		  }
          if(filesName=="addressProof" && address_proof ==""){
           msg_error.style.display = 'block';
      	   msg_success.style.display = 'none'; 
      	   msg_div.className += ' error'
          	  return;
            }
			else if(filesName == 'resume'){
	   if (!isResume(document.getElementById(fileName).value)) {
      	showMSG('Document/file type is not valid. Please upload valid document/file as per the specifications.');
          return ;
	   }  
	  }
			 else{
		  if (!isSign(document.getElementById(fileName).value)) {
         	showMSG('PDocument/file type is not valid. Please upload valid document/file as per the specifications.');
          return ;
	   }
		  }
      if(files ==  undefined || files==""){        
           msg_error.style.display = 'block';
    	   msg_success.style.display = 'none'; 
    	   msg_div.className += ' error'
          return false;
      }
	    if(filesName == 'signature' || filesName === 'photograph'){
	      if(!formatFileSize(files.size)){
		    showMSG("File size cannot be greater than 500 KB. \n Please try again.");
			return false;
	      }
		}else{
			if(!formatother(files.size)){
		    showMSG("File size cannot be greater than 1 MB. \n Please try again.");
			return false;
	      }
		}
	   if(filesName == 'signature'){
      if (!isSign(document.getElementById(fileName).value)) {
      	showMSG('Document /file type is not valid. Please upload valid document/file as per the specifications.');
          return ;
	   }
	   }else if(filesName == 'resume'){
	   if (!isResume(document.getElementById(fileName).value)) {
      	showMSG('Document/file type is not valid. Please upload valid document/file as per the specifications.');
          return ;
	   }  
	  }else{
		if (!isImage(document.getElementById(fileName).value)) {
      	showMSG('Document/file type is not valid. Please upload valid document/file as per the specifications.');
          return ;
	   }   
	   }
      if(filesName ==  ""){
      	   msg_error.style.display = 'block';
    	   msg_success.style.display = 'none'; 
    	   msg_div.className += ' error'
          return false;
      }
          fd.append('file',files);
          fd.append('name',filesName);
          fd.append('accessKey',accessKey);
          fd.append('identity_proof',identity_proof);
          fd.append('address_proof',address_proof);
		  msg_loader.style.display = 'block';
       $.ajax({
           type: "POST",
           enctype: 'multipart/form-data',
           url: "upload",
           data: fd,
           processData: false,
           contentType: false,
           cache: false,
           timeout: 600000,
           success: function (data) {
                 	  msg_error.style.display = 'none';
                 	  msg_success.style.display = 'block';
                 	  view_file.style = '';
					  view_file.style.display = 'block';
                      msg_div.classList.remove("error");
                 	  msg_div.className += ' success'
             	      view_file.href=data;
                      msg_loader.style.display = 'none';
                      document.getElementById(imgcheck).src="./img/check-icn.png";					  
           },          
       });   
      }
       function showMSG(msg){
    	   console.log('Inside Swal');
 		  swal({   
 				  title: msg,     
    				  showCancelButton: false,
    				  confirmButtonColor: "#DC3545",   
    				  confirmButtonText: "OK",   
    				  closeOnConfirm: true },
 				  function(isConfirm){			  
 					  return false; 
 				}); 
 	 }
      function getExtension(filename) {
      	  var parts = filename.split('.');
      	  return parts[parts.length - 1];
      	}

      	function isImage(filename) {
      	  var ext = getExtension(filename);
      	  switch (ext.toLowerCase()) {
      	    case 'jpg':
      	    case 'png':
      	    case 'pdf':
      	      return true;
      	  }
      	  return false;
      	}
      	
		function isSign(filename) {
      	  var ext = getExtension(filename);
      	  switch (ext.toLowerCase()) {
      	    case 'jpg':
      	    case 'png':
      	    case 'pdf': 
      	      return true;
      	  }
      	  return false;
      	}
		
		function isResume(filename) {
      	  var ext = getExtension(filename);
      	  switch (ext.toLowerCase()) {
      	     case 'pdf':
		     case 'docx':
		     case 'doc':
      	      return true;
      	  }
      	  return false;
      	}
      	
		
      	function formatFileSize(bytes) {	       
      		       var c=bytes/1024;
      		       if(c>=500){
      		    	   return false;
      		       }  
      		   return   true;
      		}
			
			function formatother(bytes) {	
				console.log('Bytes :: '+bytes);
      		       var c=bytes/1024;
				console.log('CCC :: '+c);
      		       if(c>=1000){
				console.log('in if');
      		    	   return false;
      		       }  
				console.log('out if');
      		   return   true;
      		}
			
      	
      	function saveDacoment(){
			if('${participant.fresher}'=="fresher"){
				if ( !$('#viewsign').is(':visible') || !$('#viewqualy').is(':visible') || !$('#viewaddress').is(':visible') || !$('#viewqualy').is(':visible')
					|| !$('#viewrquth12').is(':visible') || !$('#viewrgradu').is(':visible') 
				   )
					{
					 swal({   
				  title: 'All documents are mandatory',     
				  showCancelButton: false,
				  confirmButtonColor: "#DC3545",   
				  confirmButtonText: "OK",   
				  closeOnConfirm: true },
				  function(isConfirm){			  
					  return false; 
				}); 
					return false;
				}
			}else{
				if ( !$('#viewsign').is(':visible') || !$('#viewqualy').is(':visible') || !$('#viewaddress').is(':visible') || !$('#viewqualy').is(':visible')
					|| !$('#viewrquth12').is(':visible') || !$('#viewrgradu').is(':visible') 
				      )
					{
					 swal({   
				  title: 'All documents are mandatory',     
				  showCancelButton: false,
				  confirmButtonColor: "#DC3545",   
				  confirmButtonText: "OK",   
				  closeOnConfirm: true },
				  function(isConfirm){			  
					  return false; 
				}); 
					return false;
				}
			}
			next();
      	}
		function openVewFile(accesskey,fileName)
        		{
        	    	window.location.href="viewFile?accessKey="+accesskey+"&fineName="+fileName;	
        		}
		 function next() {
			 var accesskey = document.getElementById('accesskey').value
				      /*	var accesskey = $("#accessKey").val();
				  	 	 document.forms[0].action="finalSubmit?accesskey="+accesskey;
				  	 			document.forms[0].method="get";
				  	 			document.forms[0].submit(); */
				      	window.location.href="finalSubmit?accesskey="+accesskey;	
				    	}
    </script>
</body>
</html>
<%}else{
	 response.sendRedirect("login");
}
 }catch(Exception e)
    {
    	 System.out.println("Errror....."+e);
    	  response.sendRedirect("login");
    }%>
