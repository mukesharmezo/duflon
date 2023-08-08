<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import = "java.util.ResourceBundle" %>

<%
try
    {
	ResourceBundle resource = ResourceBundle.getBundle("application");
String baseServer = resource.getString("client.url");String title = resource.getString("app.title");
	%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<link rel="icon" type="image/x-icon" href="<%=baseServer%>img/DuflonFavicon.png"/>    <title>Upload Documents</title>
    <link rel="stylesheet" type="text/css" href="./css/style.css" />
       <link rel="stylesheet" type="text/css" href="./css/sweetalert.css"/>
       <script type="text/javascript" src="./js/sweetalert.min.js"></script>
       <style>
        .sweet-alert button.cancel{color:#DC3545 !important; border: 1px solid #DC3545 ; background-color: #fff !important;}
        .upload-input {justify-content: flex-start !important;}
        .upload-input .ir-view{margin-left: auto !important;}
		.ir-check{padding: 5px;}
        .ir-cross{padding: 5px;}

        @media (max-width:426px) {
        .sweet-alert{    width: 70% !important;left: 72% !important; top: 50% !important;}}

        @media (max-width:768px) {
        .sweet-alert{    width: 50% !important;}}
        @media (max-width:820px) {
        .sweet-alert{    width: 50% !important;}}
       </style>
  </head>
  <body>
    <div class="header">
      <div class="container">
          <!-- <div class="logo"><img src="./img/iRecruit-logo.svg" alt="" /></div> -->
      <div class="logo"><h2 class="LOGO" style="color: #fff; font-size: 32px; font-weight: 700;"><b>DuRecruit</b></h2></div>

      </div>
  </div>
    <div class="container">
      <h1>Upload Documents</h1>
     
       <form action="uploadfiles"  enctype="multipart/form-data" class="form" method = "post">
       <div class="form-block">
            <input type="hidden" name="accessKey" id = "accessKey" value="${participant.accessKey}"/>
          </div>
        <div class="upload-section no-bor-mar-pad">
          <h5>Photograph</h5>
          <div class="upload-tnc">&nbsp;</div>
          <div class="upload-input">
		    <!-- <img class="ir-check" src="./img/check-icn.png" id="imgphoto"/> -->
           <a href ="images/${participant.photograph}" target="_blank" class="gray-btn ir-view">View</a>
          </div>
        </div>
        <div class="upload-section" id="signdiv">
          <h5 id = "ps">Signature <span>*</span></h5>
          <div class="upload-tnc">
            <p id = "psign">Upload file in JPEG, PNG and JPG under 500KB</p>
                <div class="success-tnc" id = "successign"><img src="./img/check-icn.png" /> Successfully uploaded</div>
                <div class="error-tnc" id = "errorsign"><img src="./img/cross-icn.png" />Please Upload Valid file format</div>
          </div>
          <div class="upload-input">
           
            <div class="file-upload">
              <div class="file-upload-select" onclick="$(this).parent().find('input[type=file]').click();">
                <div class="file-select-button">Choose File</div>
                <div class="file-select-name">No file chosen</div>
            </div>
            <input type="file" name="signature" id="signaturefile" onchange="$(this).parent().find('.file-select-name').html($(this).val().split(/[\\|/]/).pop());" style="display: none;" accept=".jpg, .jpeg, .png, .png,">
            </div>
             <input type="hidden" value="signature" id="signature">
             <input class="gray-btn upload-btn" data-id="signature-input" type="button"  onclick="uploadFile('signaturefile','signature','successign','errorsign','viewsign','signdiv','loader_sign','imgsign')" value="Upload">
             
								<c:choose>
								  <c:when test="${not empty participant.signature }">
							    <img class="ir-check" src="./img/check-icn.png" id="imgsign"/>
							    </c:when>
								 <c:otherwise>
                                 <img class="ir-cross" src="./img/cross-icn.png" id="imgsign" />
                                </c:otherwise>
							    </c:choose>
			 <a href ="images/${participant.signature}" class="view-btn gray-btn ir-view" id="viewsign" target="_blank"
			<c:if test="${participant.signature == '' || participant.signature == null}">style="opacity:0.5;cursor: no-drop;pointer-events: none;" </c:if> >View</a> 
			 <img class="preview" id="loader_sign" src="./img/loader.gif" style="width: 20px; display:none;">
          </div>
        </div>
        <div class="upload-section" id="identitydiv">
          <h5 id = "pid">Identity Proof <span>*</span></h5>
          <div class="upload-tnc">
            <select id="identity_proof">
			
			<option value="">Select</option>
            <option value="AD">Aadhaar Card</option>
			<option value="PA">PAN Card</option>									
			<option value="VI">Voter ID Card</option>
			<option value="DL">Driving License</option>
			<option value="PS">Passport</option>
			<option value="Others">Others</option>		
            </select>
            <p id = "pidenty">Upload file in PDF, JPEG, PNG and JPG under 1MB</p>
                <div class="success-tnc" id = "succesidentity"><img src="./img/check-icn.png" /> Successfully uploaded</div>
                <div class="error-tnc" id = "erroridentity"><img src="./img/cross-icn.png" /> Please Upload Valid file format</div>
          </div>
          <div class="upload-input">
         
          
            <div class="file-upload">
              <div class="file-upload-select" onclick="$(this).parent().find('input[type=file]').click();">
                <div class="file-select-button">Choose File</div>
                <div class="file-select-name">No file chosen</div>
            </div>
             <input type="hidden" value="identitityProof" id="identity_name">
            <input type="file" name="identitityProof" id="identity" onchange="$(this).parent().find('.file-select-name').html($(this).val().split(/[\\|/]/).pop());" style="display: none;" accept=".pdf, .jpg, .jpeg, .png,.png," >
            </div>
            <input class="gray-btn upload-btn" data-id="identity-input" type="button" onclick="uploadFile('identity','identity_name','succesidentity','erroridentity','viewidentity','identitydiv','loader_identity','imgId')" value="Upload">
            <c:choose>
								  <c:when test="${not empty participant.identitityProof }">
							    <img class="ir-check" src="./img/check-icn.png" id="imgId"/>
							    </c:when>
								 <c:otherwise>
                                 <img class="ir-cross" src="./img/cross-icn.png" id="imgId"/>
                                </c:otherwise>
							    </c:choose>         
		 <a href ="images/${participant.identitityProof}" target="_blank"
		  class=" view-btn  gray-btn ir-view" id="viewidentity" <c:if test="${participant.identitityProof == '' || participant.identitityProof == null}">style="opacity:0.5;cursor: no-drop;pointer-events: none;" </c:if>>View</a>
          <img class="preview" id="loader_identity" src="./img/loader.gif" style="width: 20px; display:none;">		
		</div>
        </div>
        <div class="upload-section" id="addressdiv">
          <h5  id = "padd">Address Proof <span>*</span></h5>
          <div class="upload-tnc">
            <select id="address_proof">
             <option value="">Select</option>
			 
			 <option value="AD">Aadhar Card</option>
			 <option value="VI">Voter ID Card</option>
			 <option value="PS">Passport</option>
									
			 <option value="Ration Card with address">Ration Card with address</option>
			 <option value="Bank Passbook">Bank Passbook</option>
			 <option value="Electricity Bill (not older than last three months)">Electricity Bill (not older than last three months)</option>
			 <option value="Telephone Bill (not older than last three months)">Past Telephone Bill (not older than last three months)</option>
			 <option value="Water Bill (not older than last three months)">Water Bill (not older than last three months)</option>
			 <option value="Registered Sale/ Rent Agreement">Registered Sale/ Rent Agreement</option>
            </select>
            <p id = "pm">Upload file in PDF, JPEG, PNG, and JPG under 1MB</p>
                <div class="success-tnc" id = "succesaddress"><img src="./img/check-icn.png" /> Successfully uploaded</div>
                <div class="error-tnc" id = "erroraddress"><img src="./img/cross-icn.png" />Please Upload Valid file format</div>
          </div>
          <div class="upload-input">         
            <div class="file-upload">
              <div class="file-upload-select" onclick="$(this).parent().find('input[type=file]').click();">
                <div class="file-select-button">Choose File</div>
                <div class="file-select-name">No file chosen</div>
            </div>
            <input type="file" name="addressProof" id="address" onchange="$(this).parent().find('.file-select-name').html($(this).val().split(/[\\|/]/).pop());" style="display: none;" accept=".pdf, .jpg, .jpeg, .png, .png">
            </div>
             <input type="hidden" value="addressProof" id="Address_proof">
            <input class="gray-btn upload-btn" data-id="address-input" type="button"  onclick="uploadFile('address','Address_proof','succesaddress','erroraddress','viewaddress','addressdiv','loader_address','imgAddress')" value="Upload">
              <c:choose>
								  <c:when test="${not empty participant.addressProof }">
							    <img class="ir-check" src="./img/check-icn.png" id="imgAddress"/>
							    </c:when>
								 <c:otherwise>
                                 <img class="ir-cross" src="./img/cross-icn.png" id="imgAddress"/>
                                </c:otherwise>
							    </c:choose>        
		<a href ="images/${participant.addressProof}" class=" view-btn  gray-btn ir-view" id="viewaddress" target="_blank"
		 <c:if test="${participant.addressProof == '' || participant.addressProof == null}">style="opacity:0.5;cursor: no-drop;pointer-events: none;" </c:if>>View</a>    
         <img class="preview" id="loader_address" src="./img/loader.gif" style="width: 20px; display:none;">		 
		 </div>
        </div>
        <div class="upload-section" id="qualydiv">
        <h5 id="pq"   style="color: black;">
          Qualification
        </h5>
        <div class="upload-section" id="qualydiv" style="width:100%;border-top:none !important;">
        
          <h5 id = "pq">10th<span>*</span></h5>
          <div class="upload-tnc">
             <div id =presign>
            <p>Class 10th (SSC / Matriculation)</p>
            <p>Upload file in PDF, JPEG, PNG and JPG under 1MB</p></div>
                <div class="success-tnc" id = "successqualy"><img src="./img/check-icn.png" /> Successfully uploaded</div>
                <div class="error-tnc" id = "errorqualy"><img src="./img/cross-icn.png" />Please Upload Valid file format</div>
          </div>
          <div class="upload-input">   
            <div class="file-upload">
              <div class="file-upload-select" onclick="$(this).parent().find('input[type=file]').click();">
                <div class="file-select-button">Choose File</div>
                <div class="file-select-name">No file chosen</div>
            </div>
            <input type="file" name="qualification" id="qualification" onchange="$(this).parent().find('.file-select-name').html($(this).val().split(/[\\|/]/).pop());" style="display: none;" accept=".pdf,.jpg, .jpeg, .png, .png">
            </div>
              <input type="hidden" value="10th" id="quth10">
            <input class="gray-btn upload-btn" data-id="qualification-input" type="button"  onclick="uploadFile('qualification','quth10','successqualy','errorqualy','viewqualy','qualydiv','loader_qualy','imgque_1')" value="Upload">
            <c:choose>
								  <c:when test="${not empty participant.qualification }">
							    <img class="ir-check" src="./img/check-icn.png" id="imgque_1"/>
							    </c:when>
								 <c:otherwise>
                                 <img class="ir-cross" src="./img/cross-icn.png" id="imgque_1"/>
                                </c:otherwise>
							    </c:choose>         
		 <a href ="images/${participant.qualification}" class="view-btn gray-btn ir-view" id="viewqualy" target="_blank" 
		  <c:if test="${participant.qualification == '' || participant.qualification == null}">style="opacity:0.5;cursor: no-drop;pointer-events: none;" </c:if>>View</a>   
          <img class="preview" id="loader_qualy" src="./img/loader.gif" style="width: 20px; display:none;">		  
		 </div>
        </div>
        </div>
        <div id="extra-field"></div>
     <!--    <a id="add-qualification">+ Add Qualification</a> -->


 <!--  ////////// -->
   <div class="upload-section" id="quth12div" style="border-top:none !important;" >
          <h5 id = "presigletter">12th <span>*</span></h5>
          <div class="upload-tnc">
             <div id =presign>
            <p>Diploma/Class 12th (HSC / Intermediate)</p>
            <p>Upload file in PDF, JPEG, PNG and JPG under 1MB</p></div>
                <div class="success-tnc" id = "succesquth12"><img src="./img/check-icn.png" /> Successfully uploaded</div>
                <div class="error-tnc" id = "errorrquth12"><img src="./img/cross-icn.png" />Please Upload Valid file format</div>
          </div>
          <div class="upload-input">
            
            <div class="file-upload">
              <div class="file-upload-select" onclick="$(this).parent().find('input[type=file]').click();">
                <div class="file-select-button">Choose File</div>
                <div class="file-select-name">No file chosen</div>
            </div>
          
          <input type="file" name="resigningLetter" id="quth12-input"
										onchange="$(this).parent().find('.file-select-name').html($(this).val().split(/[\\|/]/).pop());"
										style="display: none;" accept=".pdf,.jpg, .jpeg, .png, .png">
	</div>
			<input type="hidden" value="12th" id="quth12" style="border-top:none !important;">
			
            <input class="gray-btn upload-btn" data-id="resignation-input" type="button" onclick="uploadFile('quth12-input','quth12','succesquth12','errorrquth12','viewrquth12','quth12div','loader_quth12','imgque_2')" value="Upload">
          
		  <c:choose>
								  <c:when test="${not empty participant.qualification2 }">
							    <img class="ir-check" src="./img/check-icn.png" id="imgque_2"/>
							    </c:when>
								 <c:otherwise>
                                 <img class="ir-cross" src="./img/cross-icn.png" id="imgque_2"/>
                                </c:otherwise>
							    </c:choose>
		  <a href ="images/${participant.qualification2}" class="view-btn gray-btn ir-view" id="viewrquth12" target="_blank"
		  <c:if test="${participant.qualification2 == '' || participant.qualification2 == null}">style="opacity:0.5;cursor: no-drop;pointer-events: none;" </c:if>>View</a>
		  <img class="preview" id="loader_quth12" src="./img/loader.gif" style="width: 20px; display:none;">
		  </div>
        </div>
        
         <div class="upload-section" id="gradudiv" style="border-top:none !important;">
          <h5 id = "presigletter">Graduation <span>*</span></h5>
          <div class="upload-tnc">
            <div id=presign>
              <p>Diploma, Graduation, Post-Graduation, Others (if any)</p>
              <p>Upload file in PDF, JPEG, PNG and JPG under 1MB</p>
            </div>
                <div class="success-tnc" id = "succesgradu"><img src="./img/check-icn.png" /> Successfully uploaded</div>
                <div class="error-tnc" id = "errorrgradu"><img src="./img/cross-icn.png" />Please Upload Valid file format</div>
          </div>
          <div class="upload-input">
         
            
            <div class="file-upload">
              <div class="file-upload-select" onclick="$(this).parent().find('input[type=file]').click();">
                <div class="file-select-button">Choose File</div>
                <div class="file-select-name">No file chosen</div>
            </div>
            <input type="file" name="resigningLetter" id="graduation" onchange="$(this).parent().find('.file-select-name').html($(this).val().split(/[\\|/]/).pop());" style="display: none;" accept=".pdf,.jpg, .jpeg, .png, .png">
            </div>
             <input type="hidden" value="Graduation" id="gradu">
            <input class="gray-btn upload-btn" data-id="resignation-input" type="button" onclick="uploadFile('graduation','gradu','succesgradu','errorrgradu','viewrgradu','gradudiv','loader_gradu','imgque_3')" value="Upload">
           <c:choose>
								  <c:when test="${not empty participant.qualification3 }">
							    <img class="ir-check" src="./img/check-icn.png" id="imgque_3"/>
							    </c:when>
								 <c:otherwise>
                                 <img class="ir-cross" src="./img/cross-icn.png" id="imgque_3"/>
                                </c:otherwise>
							    </c:choose>         
		 <a href ="images/${participant.qualification3}" class="view-btn gray-btn ir-view" id="viewrgradu" target="_blank"
		  id="viewrgradu" target="_blank" <c:if test="${participant.qualification3 == '' || participant.qualification3 == null}">style="opacity:0.5;cursor: no-drop;pointer-events: none;" </c:if>>View</a>   
 <img class="preview" id="loader_gradu" src="./img/loader.gif" style="width: 20px; display:none;">		  
		 </div>
        </div>
 <!--  ////////// -->
 <div class="upload-section" id="resigndiv" <c:if test="${participant.fresher == 'fresher' }"> style=" display:none;"</c:if>>
        <h5 id="pq" style="color: black;">
          Work Experience
        </h5>
        <div class="upload-section" id="resigndiv"  style="width:100%;border-top: none !important;">
          
          <h5 id = "presigletter" style="border-top: none !important;">Resignation Letter </h5>
          <div class="upload-tnc">
             <div id =presign>
            <p>Upload Resignation Letter</p>
            <p>Upload file in PDF, JPEG, PNG and JPG under 1MB</p></div>
                <div class="success-tnc" id = "succesresign"><img src="./img/check-icn.png" /> Successfully uploaded</div>
                <div class="error-tnc" id = "errorresign"><img src="./img/cross-icn.png" />Please Upload Valid file format</div>
          </div>
          <div class="upload-input">
         
            
            <div class="file-upload">
              <div class="file-upload-select" onclick="$(this).parent().find('input[type=file]').click();">
                <div class="file-select-button">Choose File</div>
                <div class="file-select-name">No file chosen</div>
            </div>
            <input type="file" name="resigningLetter" id="resignation-input" onchange="$(this).parent().find('.file-select-name').html($(this).val().split(/[\\|/]/).pop());" style="display: none;" accept=".pdf,.jpg, .jpeg, .png, .png">
            </div>
             <input type="hidden" value="resignation" id="resignation">
            <input <c:if	test="${participant.fresher == 'fresher' }"> style=" background-color: #dad9d9;pointer-events: none"</c:if> class="gray-btn upload-btn" data-id="resignation-input" type="button" onclick="uploadFile('resignation-input','resignation','succesresign','errorresign','viewresign','resigndiv','loader_resign','imgwork_1')" value="Upload">
             <c:choose>
								  <c:when test="${not empty participant.resignationLetter }">
							    <img class="ir-check" src="./img/check-icn.png" id="imgwork_1"/>
							    </c:when>
								 <c:otherwise>
                                 <img class="ir-cross" src="./img/cross-icn.png" id="imgwork_1" />
                                </c:otherwise>
							    </c:choose>            
			<a href ="images/${participant.resignationLetter}" class="view-btn gray-btn ir-view" id="viewresign" target="_blank"
		  <c:if test="${participant.resignationLetter == '' || participant.resignationLetter == null}">style="opacity:0.5;cursor: no-drop;pointer-events: none;" </c:if>>View</a>   
          <img class="preview" id="loader_resign" src="./img/loader.gif" style="width: 20px; display:none;">		  
		 </div>
        </div>
		</div>
        <div class="upload-section" id="exprncdiv"  style="border-top:none !important; <c:if	test="${participant.fresher == 'fresher' }"> display:none;</c:if>">
          <h5 id = "pexpletter">Relieving Letter </h5>
          <div class="upload-tnc">
          <div id = "pexprnc">
            <p >Upload Experience /Relieving Letter</p>
            <p>Upload file in PDF, JPEG, PNG and JPG under 1MB</p></div>
                <div class="success-tnc" id = "succexprnc"><img src="./img/check-icn.png" /> Successfully uploaded</div>
                <div class="error-tnc" id = "errorexprnc"><img src="./img/cross-icn.png" />Please Upload Valid file format</div>
          </div>
          <div class="upload-input">
          
            <div class="file-upload">
              <div class="file-upload-select" onclick="$(this).parent().find('input[type=file]').click();">
                <div class="file-select-button">Choose File</div>
                <div class="file-select-name">No file chosen</div>
            </div>
            <input type="file" name="experienceletter" id="experience-input" onchange="$(this).parent().find('.file-select-name').html($(this).val().split(/[\\|/]/).pop());" style="display: none;" accept=".pdf,.jpg, .jpeg, .png, .png">
            </div>
            <input type="hidden" value="experience" id="experience">
            <input <c:if	test="${participant.fresher == 'fresher' }"> style=" background-color: #dad9d9;pointer-events: none"</c:if> class="gray-btn upload-btn" data-id="experience-input" type="button" onclick="uploadFile('experience-input','experience','succexprnc','errorexprnc','viewrexprnc','exprncdiv','loader_exprnc','imgwork_2')" value="Upload">
           
		   <c:choose>
								  <c:when test="${not empty participant.experienceletter }">
							    <img class="ir-check" src="./img/check-icn.png" id="imgwork_2"/>
							    </c:when>
								 <c:otherwise>
                                 <img class="ir-cross" src="./img/cross-icn.png" id="imgwork_2"/>
                                </c:otherwise>
							    </c:choose>
		   <a href ="images/${participant.experienceletter}" class="view-btn gray-btn ir-view" id="viewrexprnc" target="_blank"
		   <c:if test="${participant.experienceletter == '' || participant.experienceletter == null}">style="opacity:0.5;cursor: no-drop;pointer-events: none;" </c:if>>View</a>
           <img class="preview" id="loader_exprnc" src="./img/loader.gif" style="width: 20px; display:none;">		   
		 </div>
        </div> 
        <div class="upload-section" id="salarydiv" style="border-top:none !important; <c:if	test="${participant.fresher == 'fresher' }"> display:none;</c:if>">
          <h5 id = "hsalaryslip">Salary Slip </h5>
          <div class="upload-tnc">
          <div id ="psalary">
            <p>Upload Salary Slip</p>
            <p>Upload file in PDF, JPEG, PNG and JPG under 1MB</p></div>
                <div class="success-tnc" id = "successlary"><img src="./img/check-icn.png" /> Successfully uploaded</div>
                <div class="error-tnc" id = "errorsalary"><img src="./img/cross-icn.png" />Please Upload Valid file format</div>
          </div>
          <div class="upload-input">
         
            <div class="file-upload">
              <div class="file-upload-select" onclick="$(this).parent().find('input[type=file]').click();">
                <div class="file-select-button">Choose File</div>
                <div class="file-select-name">No file chosen</div>
            </div>
            <input type="file" name="salaryslip" id="salary-input" onchange="$(this).parent().find('.file-select-name').html($(this).val().split(/[\\|/]/).pop());" style="display: none;" accept=".pdf,.jpg, .jpeg, .png, .png">
            </div>
            <input type="hidden" value="salaryslip" id="salary">
           <input <c:if	test="${participant.fresher == 'fresher' }"> style=" background-color: #dad9d9;pointer-events: none"</c:if> class="gray-btn upload-btn" data-id="salary-input" type="button" onclick="uploadFile('salary-input','salary','successlary','errorsalary','viewrsalary','salarydiv','loader_salary','imgwork_3')" value="Upload">
            <c:choose>
								  <c:when test="${not empty participant.salarySlip }">
							    <img class="ir-check" src="./img/check-icn.png" id="imgwork_3" />
							    </c:when>
								 <c:otherwise>
                                 <img class="ir-cross" src="./img/cross-icn.png" id="imgwork_3" />
                                </c:otherwise>
							    </c:choose>           
		   <a href ="images/${participant.salarySlip}" class="view-btn gray-btn ir-view" id="viewrsalary" target="_blank"
		  <c:if test="${participant.salarySlip == '' || participant.salarySlip == null}">style="opacity:0.5;cursor: no-drop;pointer-events: none;" </c:if>>View</a>    
         <img class="preview" id="loader_salary" src="./img/loader.gif" style="width: 20px; display:none;">		  
		 </div>
        </div>
   
          <div class="upload-section">
          <h5>Resume<span>*</span></h5>
          <div class="upload-tnc">
            <!--<input type="text" placeholder="cv_2_jun_2022.pdf"  value="${participant.resume}" disabled /> -->
          </div>
          <div class="upload-input">
		   <!-- <img class="ir-check" src="./img/check-icn.png"  id="imgwork_4"/> -->
         <a href="images/${participant.resume}" class="gray-btn upload-btn ir-view" target="_blank" id="viewrSal" >View</a>
          </div>
          
        </div>
        <div class="upload-section" id="otherdiv">
          <h5 id = "hdoc">Any other document</h5>
          <div class="upload-tnc">
            <p id = "pdoc">Upload Any other document</p>
					<p>Upload file in PDF, JPEG, PNG and JPG under 1MB</p>

                <div class="success-tnc" id = "succesdoc"><img src="./img/check-icn.png" /> Successfully uploaded</div>
                <div class="error-tnc" id = "errordoc"><img src="./img/cross-icn.png" />Please Upload Valid file format</div>
          </div>
          <div class="upload-input">
         
            
            <div class="file-upload">
              <div class="file-upload-select" onclick="$(this).parent().find('input[type=file]').click();">
                <div class="file-select-button">Choose File</div>
                <div class="file-select-name">No file chosen</div>
            </div>
            <input type="file" name="documents" id="any-input" onchange="$(this).parent().find('.file-select-name').html($(this).val().split(/[\\|/]/).pop());" style="display: none;" accept=".pdf,.jpg, .jpeg, .png, .png">
            </div>
             <input type="hidden" value="other" id="other">
            <input  class="gray-btn upload-btn" data-id="any-input"  type="button" onclick="uploadFile('any-input','other','succesdoc','errordoc','otherview','otherdiv','loader_other','imgother')" value="Upload">
              <c:choose>
								  <c:when test="${not empty participant.documents }">
							    <img class="ir-check" src="./img/check-icn.png" id="imgother"/>
							    </c:when>
								 <c:otherwise>
                                 <img class="ir-cross" src="./img/cross-icn.png" id="imgother" />
                                </c:otherwise>
							    </c:choose>            
			<a href ="images/${participant.documents}" class="view-btn gray-btn ir-view" target="_blank"
		  id="otherview" <c:if test="${participant.documents == '' || participant.documents == null}">style="opacity:0.5;cursor: no-drop;pointer-events: none;" </c:if>>View</a>  
          <img class="preview" id="loader_other" src="./img/loader.gif" style="width: 20px; display:none;">		  
		 </div>
        </div>
        <div class="form-btn wtnc">
          <div class="acc-tnc">
            <input type="checkbox" id="tnc" /><label for="tnc"
              >By clicking here, I state that I have read and understood the
              <a href="#" target="_blank"><b>Terms & Conditions</b></a> .
<!--               <a href="./termsCondition" target="_blank"><b>Terms & Conditions</b></a> . -->
			   
			  </label >
          </div>
          <div class="btns">
           <!--  <input type="button" class="btn" onclick="saveDacoment('save')" value="Save"> -->
            <input type="button" id="submit" class="btn blue-btn" type="submit" disabled onclick="saveDacoment('save')" value="Submit">
          </div>
        </div>
      </form>
       <input type="hidden" id="accesskey" value="${participant.accessKey}">
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/jquery.validate.min.js"></script>
   <!--  <script type="text/javascript" src="/js/register.js"></script>  -->
    <script>
        $(document).ready(function () {
			 $("#identity_proof").val('${participant.identitityProofName}');
    	         $("#address_proof").val('${participant.addressProofName}');
            $('#tnc').change(function() {
                if(this.checked) {
                    $('#submit').removeAttr('disabled');
                    console.log('d')
                } else{
                    $('#submit').attr('disabled', true)
                }
            });


            var quali_count = 1;
            function extra_quali(){
                var extra_quali_field = `
                
                <div class="upload-section">
                    <h5>Qualification ${quali_count}<span>*</span></h5>
                    <div class="upload-tnc">
                        <select id="a">
                        <option value="">Select</option>
                        <option value="10th">10th</option>
                        <option value="12th">12th</option>
                        <option value="Graduation">Graduation</option>
                        </select>
                    </div>
                    <div class="upload-input">
                    <!--<a href ="C:\ParticipantUploadedFiles">
                    <input class=" view-btn  gray-btn" type="button" name="signature" value="View File"  id = "adqview"/></a>
                        <!-- <button class="view-btn gray-btn">View File</button> -->
                        <div class="file-upload">
                          <div class="file-upload-select" onclick="$(this).parent().find('input[type=file]').click();">
                    <div class="file-select-button">Choose File</div>
                    <div class="file-select-name">No file chosen</div>
                </div>
                <input type="file" name="quali${quali_count}-input" id="quali${quali_count}-input" onchange="$(this).parent().find('.file-select-name').html($(this).val().split(/[\\|/]/).pop());" style="display: none;">
                        </div>
                        <input class="gray-btn upload-btn"  id ="addqualify"  onclick="uploadFile('signaturefile','signature','successign','errorsign','viewsign','signdiv')" value="Upload" type="button">
                    </div>
                    </div>
               <script> `
			    
                $('#extra-field').append(extra_quali_field);
            }
                $('#add-qualification').on('click', function(){
                    quali_count++;
                    console.log(quali_count)
                    extra_quali()
                });
        });
        
        
        function uploadFile(fileName,name,success,error,view,div,loader,imgcheck)
        {
        	 var files = document.getElementById(fileName).files[0];
        	 var filesName = document.getElementById(name).value;
        	 var msg_error = document.getElementById(error);
        	 var msg_success = document.getElementById(success);
        	 var view_file = document.getElementById(view);
        	 var msg_div = document.getElementById(div);
			 var loader_div = document.getElementById(loader);
        	 
        	 var identity_proof = document.getElementById("identity_proof").value;
        	 var address_proof = document.getElementById("address_proof").value;
			
        	 
        	 var accessKey = $('#accesskey').val();
             var fd = new FormData();
        if(files ==  undefined || files==""){
             msg_error.style.display = 'block';
      	     msg_success.style.display = 'none'; 
      	     msg_div.className += ' error'
             return false;
        }
        
		if(filesName=="identitityProof" && identity_proof ==""){
           msg_error.style.display = 'block';
    	   msg_success.style.display = 'none'; 
    	   msg_div.className += ' error'
        	  return;
          }
          
          if(filesName=="addressProof" && address_proof ==""){
           msg_error.style.display = 'block';
      	   msg_success.style.display = 'none'; 
      	   msg_div.className += ' error'
          	  return;
            }
			if(!formatFileSize(files.size)){
				 showMSG("File size cannot be greater than 500 KB. Please try again. ");
			}
       
        
       if(filesName == 'signature'){
	      if(!formatFileSize(files.size)){
		    showMSG("File size cannot be greater than 500 KB. Please try again. ");
			return false;
	      }
		}else{
			
			if(!formatother(files.size)){
		    showMSG("File size cannot be greater than 1 MB. Please try again. ");
			return false;
	      }
		}
		
		 if(filesName == 'signature'){
      if (!isSign(document.getElementById(fileName).value)) {
      	showMSG('Document / file type is not valid. Please upload valid document/file as per the specifications.');
          return ;
	   }
	   }else{
		if (!isImage(document.getElementById(fileName).value)) {
      	showMSG('Document / file type is not valid. Please upload valid document/file as per the specifications.');
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
			loader_div.style.display = 'block';
         $.ajax({
             type: "POST",
             enctype: 'multipart/form-data',
             url: "uploadByCandidate",
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
                   	  msg_div.className += ' success';
					  view_file.href=data;
                     loader_div.style.display = 'none';	
                     document.getElementById(imgcheck).src="./img/check-icn.png";						 
             },
             
         });
		 
     
        }
        
		function formatother(bytes) {		       
      		       var c=bytes/1024;
      		       if(c>=1000){
      		    	   return false;
      		       }  
      		   return   true;
      		}
        function getExtension(filename) {
        	  var parts = filename.split('.');
        	  return parts[parts.length - 1];
        	}

			function isSign(filename) {
      	  var ext = getExtension(filename);
      	  switch (ext.toLowerCase()) {
      	    case 'jpg':
      	    case 'png':
      	    case 'pdf':
			// case 'txt':
      	      return true;
      	  }
      	  return false;
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
        	
        	function formatFileSize(bytes) {		       
        		       var c=bytes/1024;
        		       if(c>=1000){
        		    	   return false;
        		       }  
        		   return   true;
        		}
        	
        	function saveDacoment(status){
			         var viewsign =  $("#viewsign").css('pointer-events');
					 var viewaddress =  $("#viewaddress").css('pointer-events');
					 var viewidentity =  $("#viewidentity").css('pointer-events');
					 var viewqualy =  $("#viewqualy").css('pointer-events');
					 var viewrquth12 =  $("#viewrquth12").css('pointer-events');
					 var viewrgradu =  $("#viewrgradu").css('pointer-events');
					
					 
					 
					// alert(viewrgradu);
					 //return false;
               
				if ( viewsign == 'none' || viewaddress == 'none'  || viewidentity =='none' || viewqualy == 'none' || viewrquth12 == 'none' || viewrgradu == 'none'  )
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
				
			
        		 var accessKey = $('#accesskey').val();  

                            swal({   
				 					title: "Are you sure you want to submit these documents? Once submitted, you are not able to change anything.",     
				 					showCancelButton: true,
				 					confirmButtonColor: "#DC3545",   
				 					confirmButtonText: "OK",   
				 					closeOnConfirm: false },
				 					function(isConfirm){
				 						if(isConfirm){
				 						$('#submit').prop('disabled', true);
   	                                    $('#submit').val('Please wait');
                                         $('.confirm').prop('disabled', true);
   	                                   										
        		  $.ajax({
				         url: 'savedocument',
				         type:'post',
				         data:'accesskey='+accessKey+'&status='+status,
				         success:function(res){
							  $('.confirm').prop('disabled', false);
							  if(res =="3"){
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
				        	 if(res =="success"){
				        		 swal({   
				 					title: 'Your Documents are uploaded. Please contact your HRE for more information.',     
				 					showCancelButton: false,
				 					confirmButtonColor: "#DC3545",   
				 					confirmButtonText: "OK", 
                                    cancelButtonText: "Cancel",									
				 					closeOnConfirm: false },
				 					function(isConfirm){
				 						if(isConfirm){
				 							 window.location.href="<%=baseServer%>candidateLogin";
				 						}else{
				 							return false;
				 						}
				 					});	
				        	 }
				    	  },
				          error:function(ress){
				        	  alert(ress);
							//window.close();
				    	  }
			  			}); 
				 						}else{
				 							return false;
				 						}
				 					});	 
				 
				 
				 
        	}
        	
        	 function openVewFile(accesskey,fileName)
        		{
        	    	window.location.href="viewFile?accessKey="+accesskey+"&fineName="+fileName;	
        		}
				
		function showMSG(msg){		 
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
        	 
    </script>
  </body>
</html>
<%
 }catch(Exception e)
    {
    	 System.out.println("Errror....."+e);
    	  response.sendRedirect("login");
    }%>
