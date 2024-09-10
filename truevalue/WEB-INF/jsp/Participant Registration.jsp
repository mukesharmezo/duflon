<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import = "java.util.ResourceBundle" %>

<%
try
    {
	ResourceBundle resource = ResourceBundle.getBundle("application");
String baseServer = resource.getString("client.url");
	%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<link rel="icon" type="image/x-icon" href="<%=baseServer%>img/iRecruit-favicon.ico"/>   <title>iRecruit</title>
    <link rel="stylesheet" type="text/css" href="./css/style.css" />
    <link rel="stylesheet" type="text/css" href="./css/sweetalert.css"/>
    <script type="text/javascript" src="./js/sweetalert.min.js"></script>
 
	
	
    <script type="text/javascript">
  function getAge() {
	 
	 var dateString=  $("#birthDate").val();
	    var today = new Date();
	    var birthDate = new Date(dateString);
	    var age = today.getFullYear() - birthDate.getFullYear();
	    var m = today.getMonth() - birthDate.getMonth();
	    if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) {
	        age--;
	    }  
	  $("#age").val(age);
	} 
 </script>
 <style>
.header{padding: 1px 40px;}
@media (max-width: 767px) {.sweet-alert{
    width: 70% !important;
    display: block;
    margin-top: 0px !important;
    left: 89% !important;
    top: 54% !important;
}
.gray-btn{padding: 4px 15px;}
}
#divspin{position: relative;}
#searchmspin {position: absolute !important; margin-left: -30px; margin-top: 14px; width: 15px; height: 15px; background: url('img/search-icn-colored.svg') no-repeat left top; z-index: 9; cursor: pointer; border: none; text-indent: -999999999px;}
#div_msg{color: #f00; margin-top: 5px;  bottom: -20px; left: 0;}

@media (max-width: 768px) {
    .sweet-alert{top: 28% !important;left: 90% !important;}
    }
@media (max-width: 426px) {
    .sweet-alert{top: 28% !important;left: 71% !important;}
    }
@media (max-width: 376px) {
    .sweet-alert{top: 28% !important;left:78% !important;}
    }
@media (max-width: 320px) {
    .sweet-alert{top: 28% !important;left: 90% !important;}
    }

 </style>
  </head>
  <body>
    <div class="header">
		<div class="container">  <div class="logo"><h2 class="LOGO" style="color: #fff; font-size: 32px; font-weight: 700;"><b>iRecruit</b></h2></div></div>
      <!-- <div class="logo"><img src="./img/iRecruit-logo.svg" alt="" /></div> -->
    

    </div>
    <div class="container">
      <h1>Candidate Registration Form</h1>
      <!-- <form action="" class="form"> -->
      	<form action="./reg"   class="form" enctype="multipart/form-data" method="post"  id = "testForm"  >
      	<div class="form-block">
          <!-- <h5>Name <span>*</span></h5> -->
            <input type="hidden" name="accessKey" id = "accessKey" value="${participant.accessKey }"  onkeypress="return /[0-9a-zA-Z]/i.test(event.key)"/>
            <!-- <p>Please enter your name</p> -->
          </div>
<p class="imp-instr">All fields are mandatory!</p>
		<h4>General Information</h4>
        <div class="form-section">
          <!-- <div class="form-block">
            <h5>Name </h5>
            <input type="text" name="firstName" id = "firstName" value ="${name}" onkeypress="return /[0-9a-zA-Z]/i.test(event.key)" disabled />
          </div> -->
		  <div class="form-block">
            <h5>Title</h5 >
			<select name ="title" style="color: black !important">
				<option value ="">Select</option>
				<c:forEach items="${title }" var="title">									
                    <option value="${title.listCode}"> ${title.listDesc}</option>                          							
				</c:forEach>
			  </select>
            <!-- <p>Please enter your name</p> -->
          </div>
		 
		  <div class="form-block">
            <h5>First Name</h5>
            <input type="text" name="firstName" id = "firstName" placeholder="First Name" value ="${candidateFirsName}"  onkeypress="return /[0-9a-zA-Z]/i.test(event.key)" disabled />
            <!-- <p>Please enter your name</p> -->
          </div>
		  <div class="form-block">
            <h5>Last Name </h5>
            <input type="text" name="lastName" id = "lastName"  placeholder="Last Name" value ="${CandidateLastName}" onkeypress="return /[0-9a-zA-Z]/i.test(event.key)" />
            <!-- <p>Please enter your name</p> -->
          </div>
		  <div class="form-block">
            <h5>Date of Birth</h5>
            <input type="date" name="birthDate" id="birthDate" placeholder="Date of Birth"  onchange="getAge()" onkeydown="return false"/>
          </div>
		  <div class="form-block">
            <h5>Gender </h5>
            <select  name="gender" id="gender" style="color: black !important">
              <option value ="">Select</option>
             <c:forEach items="${gender }" var="gender">
                 <option value = "${gender.listCode}">${gender.listDesc}</option>        
               </c:forEach>
            </select>
          </div>
		  <div class="form-block">
			<h5>Marital Status</h5>
			  <select   id="martialStatus" name="martialStatus" style="color: black !important">
					 <option value = ""  >Select</option>
					 <option value="Married">Married</option>
					 <option value="Single">Single</option>      
					 <option value="Divorced">Divorced</option>  
			         <option value="Widowed	">Widowed	</option>  	 
			 </select>
	      </div>
		  <div class="form-block">
            <h5>UID/Aadhaar Number</h5>
            <input type="text" name="adharNumber" id="adharNumber" placeholder="UID/Aadhaar Number"  maxlength="12" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/>
          </div>

		  <div class="form-block">
            <h5>Source to know about Dealership</h5>
            <select   id="dealership" name="source" style="color: black !important">
              <option value = "" >Select</option>
              <option value="Referrals">Referrals</option>
              <option value="Direct walk-in">Direct walk-in</option>
              <option value="Advertisement">Advertisement</option>
              <option value="Job Consultant">Job Consultant</option>
              <option value="Social Media">Social Media</option>
              <option value="others">Others</option>
            </select>
          </div> <!-- first photograph upload -->
		  <div class="upload-section" id="upload-section-photo" style="width: 100% !important;">
			  <h5 id = "pht">Upload Your Photograph </h5>
			  <div class="upload-tnc">
			  
			  
			
			  <div id = "pp">
				  <p>Self-Passport Color Photo (Allowed Photo Size - 3.5 cm x 4.5 cm)</p>
				  <p>File format: JPEG, PNG, JPG and File Size: 500 KB</p></div>
				   <!-- in sucess case -->
				  <div class="success-tnc" id = "successphoto"><img src="./img/check-icn.png" /> Successfully uploaded</div>
				  <!-- in sucess case -->
				  <!-- in error case -->
				  <div class="error-tnc" id = "errorphoto"><img src="./img/cross-icn.png" /> Please upload file</div>
				  <!-- in error case -->
			  </div>
			  <div class="upload-input">
			   <!-- in sucess case -->
			  
			  <!--<input type="button" id="vewphoto" class="view-btn gray-btn" onclick="openVewFile('${participant.accessKey }','photograph')" value="View File" style="display:none;">  -->
				   <!-- in sucess case -->
				  <div class="file-upload">
				 <div class="file-upload-select" onclick="$(this).parent().find('input[type=file]').click();">                
						 <div class="file-select-button">Choose File</div>
						  <div class="file-select-name">No file chosen</div>
						  <!-- <input type="file" name="photograph" id="file-upload-input"> -->
					  </div>
					  <input type="file" name="photograph" id="phtograph-input" onchange="$(this).parent().find('.file-select-name').html($(this).val().split(/[\\|/]/).pop());" 
					  style="display: none;" accept=".jpg, .jpeg, .png">
				  </div>
				 
				  <button class="gray-btn upload-btn" data-id="phtograph-input" type="button" onclick="uploadFile('photograph');">Upload</button>
				   <a href="images/${participant.photograph}" class="gray-btn upload-btn" target="_blank"
									  id="vewphoto" style="display:none;">View</a> <img class="preview" id="loader_photo" src="./img/loader.gif" style="width: 20px; display:none;">
			  </div>
		  </div>   
		


		</div><!--closeGeneralInformation-->

		<h4>Contact Information</h4>
        <div class="form-section">
          <div class="form-block"  id="email">
            <h5>Email Id</h5>
            <input type="email" name="email"  placeholder="Email Id"  value = "${participant.email }" disabled/>
          </div>
          <div class="form-block">
            <h5>Mobile</h5>
            <input type="text" name="mobile" id="mobile"  placeholder="Mobile" value = "${participant.mobile}" maxlength="10"  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" />
          </div>
          <div class="form-block">
            <h5>State</h5>
            <select   name = "state" id = "state" placeholder="State" onchange="getCity()" style="color: black !important">
              <option value ="">Select</option>        
            </select>
          </div>
		  
          <div class="form-block">
            <h5>City</h5>
            <select   name="city" id="cityList" placeholder="City"   onchange="getPincodeByCity()" style="color: black !important">
              <option value = "">Select</option>
            </select>
          </div>
         
          <div class="form-block">
            <h5>Pin Code </h5>
           <!-- <input type="text" name="pin" maxlength="6"  list="pincodeList"  placeholder="Pincode" id="pincode" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/>
          
		      <datalist id="pincodeList" style="pading:padding-left:10px;">
           </datalist>-->
		    <select   name="pin" placeholder="Pin Code"    id="pincode" style="color: black !important">
              <option value = "">Select</option>
            </select>
		  
		  </div>
         
          <div class="form-block">
            <h5>Address </h5>
            <input type="text"name="address" placeholder="Address" id="address" />
          </div>	  
       </div><!--closeContactInformation-->

	   <h4>Do you own/have?</h4>
	   <div class="form-section">
		 <div class="form-block">
		   <h5>Two Wheeler</h5>
		   <input type="radio" placeholder="Two Wheeler"  value = "yes" id="own_2_yes" name="" onclick="ownTwoYes()"/>
		   <label for="yes">Yes</label>
		   <input type="radio"  value = "no" id="own_2_no" name="" onclick="ownTwoN()"/>
		   <label for="no">No</label>
		   <br>
		   <div style="font-weight: 500;font-size: 12px;font-family:Roboto, sans-serif;display:none;bottom: -28px; color: #f00; margin-top: 5px;" id="ownTwoDiv">Please select</div>
		 </div>
	   
		 <div class="form-block">
		   <h5>Four Wheeler</h5>
		   <input type="radio" placeholder="Four Wheeler"  value = "yes" id="own_4_yes" name="" onclick="ownFourYes()" />
		   <label for="yes">Yes</label>
		   <input type="radio"  value = "no" id="own_4_no" name="" onclick="ownFourNo()"/>
		   <label for="no">No</label>
		   <br>
		   <div style="font-weight: 500;font-size: 12px;font-family:Roboto, sans-serif;display:none;bottom: -28px; color: #f00; margin-top: 5px;" id="fourTwoDiv">Please select</div>
		 </div>
	   </div><!--Doyouown/have-->  




<h4>Do you know Driving?</h4>
<div class="form-section">
  <div class="form-block">
	<h5>Two Wheeler</h5>
	<input type="radio" placeholder="Two Wheeler" value = "yes" id="driving_2_yes"  name="" onclick="drivingTwoYes()"/>
	<label for="yes">Yes</label>
	<input type="radio"  value = "no" id="driving_2_no" name="" onclick="drivingTwoNo()"/>
	<label for="no">No</label>
	<br>
	<div style="font-weight: 500;font-size: 12px;font-family:Roboto, sans-serif;display:none;bottom: -28px; color: #f00; margin-top: 5px;" id="twoWheelerDiv">Please select</div>
  </div>

  <div class="form-block">
	<h5>Four Wheeler</h5>
	<input type="radio"  placeholder="Four Wheeler"  value = "yes" id="driving_4_yes" name="" onclick="drivingFourYes()" />
	<label for="yes">Yes</label>
	<input type="radio"  value = "no" id="driving_4_no" name="" onclick="drivingFourNo()"/>
	<label for="no">No</label>
	<br>
	<div style="font-weight: 500;font-size: 12px;font-family:Roboto, sans-serif;display:none;bottom: -28px; color: #f00; margin-top: 5px;" id="fourWheelerDiv">Please select</div>
  </div>

  <div class="form-block licence-ertifiedd">
	<h5>MDS Certified</h5>
	<input type="radio"  placeholder="MDS Certified"  value = "yes" id="certified_yes" name="" onclick="mdsYes()"/>
	<label for="yes">Yes</label>
	<input type="radio"  value = "no" id="certified_no" name="" onclick="mdsNo()"/>
	<label for="no">No</label>
	<br>
	<div style="font-weight: 500;font-size: 12px;font-family:Roboto, sans-serif;display:none;bottom: -28px; color: #f00; margin-top: 5px;" id="certifiedDiv">Please select</div>
  </div>

  <div class="form-block ">
	<h5>Driving Licence</h5>
	<input type="radio" placeholder="Driving Licence"  value = "yes" id="licence_yes" name="" onclick="dlYes()" />
	<label for="yes">Yes</label>
	<input type="radio"  value = "no" id="licence_no" name="" onclick="dlNo()"/>
	<label for="no">No</label>
	<br>
	<div style="font-weight: 500;font-size: 12px;font-family:Roboto, sans-serif;display:none;bottom: -28px; color: #f00; margin-top: 5px;" id="dlDiv">Please select</div>
  </div>

  <!-- <div class="form-block licence-ertified">
	<h5>MDS Certified</h5>
	<input type="radio"  value = "yes" id="certified_yes" name="" onclick="mdsYes()"/>
	<label for="yes">Yes</label>
	<input type="radio"  value = "no" id="certified_no" name="" onclick="mdsNo()"/>
	<label for="no">No</label>
	<br>
	<div style="font-weight: 500;font-size: 12px;ont-family:Roboto, sans-serif;display:none;bottom: -28px; color: #f00; margin-top: 5px;" id="certifiedDiv">Please select</div>
  </div> -->
</div><!--closeDoyouknowDriving-->
  
<!-- <h4>Do you know Driving</h4>
<div class="form-section">

	<div class="form-block">
		<h5>Two Wheeler</h5>
		<input type="radio"  value = "yes" id="fresher" name="experience" />
		<label for="yes">Yes</label>
		<input type="radio"  value = "no" id="experience" name="experience" />
		<label for="no">No</label>
	  </div>
	
	  <div class="form-block">
		<h5>Four Wheeler</h5>
		<input type="radio"  value = "yes" id="fresher" name="experience" />
		<label for="yes">Yes</label>
		<input type="radio"  value = "no" id="experience" name="experience" />
		<label for="no">No</label>
	  </div>
</div> -->


<h4>Professional Information</h4>
	  <div class="form-section">   
		<div class="form-block">
            <h5>Work Experience</h5>
            <input type="radio"  value = "fresher" id="fresher" name="" onclick="closeExp() "/>
            <label for="fresher">Fresher</label>
            <input type="radio"  value = "experience" id="experience" name="" onclick="openExp()" />
            <label for="experience">Experience</label>
			<br>
	        <div style="font-weight: 500;font-size: 12px;font-family:Roboto, sans-serif;display:none;bottom: -28px; color: #f00; margin-top: 5px;" id="expDiv">Please select</div>
          </div>
		
		  <div class="form-block"></div>
		  <div class="form-block"></div>

          <div class="form-block">
            <h5>Highest Qualification </h5>
            <select   name ="highestQualification" style="color: black !important">
              <option value="">Select</option>
            <c:forEach items="${qualification}" var="qualification">
				   <option value="${qualification.listCode}" >${qualification.listDesc}</option>
                          
                  </c:forEach>   
            </select>
          </div>
          
		<div class="form-section" style="width: 100% !important;">   
           
		  <div class="form-block work-exp">
            <h5>Total Experience (in months)</h5>
            <input type="text" name="total" placeholder="Total Experience (in months)" maxlength="3"  id="total" onkeyup="checkTotalExp()" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/>
		  </div>

		  <div class="form-block work-exp">
            <h5>Experience in Automobile Industry (in months) </h5>
            <input type="text" name="autoIndustryExperience" maxlength="3" placeholder="Experience in Automobile Industry (in months)"    id="autoIndustryExperience" onkeyup="checkTotalExp()" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/>
		  </div> 

		  <div class="form-block work-exp">
            <h5>Experience in Non-Automobile Industry (in months) </h5>
            <input type="text" name="nonAutoIndustryExperience" placeholder="Experience in Non-Automobile Industry (in months)"  maxlength="3" id="nonAutoIndustryExperience" onkeyup="checkTotalExp()" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/>
		  </div>
		</div>   

       </div>
	      <!-- <div class="form-block"></div>
			<div class="form-block"></div> -->
			<div class="form-section">   

		  <div class="form-block work-exp">
			<h5>Worked With MSIL Before </h5>
			<input type="radio"  value = "yes" id="msilYes" name="" onclick="milYes()"/>
			<label for="yes">Yes</label>
			<input type="radio"  value = "no" id="msilNo" name="" onclick="milNo()"/>
			<label for="no">No</label>
			<br>
	        <div style="font-weight: 500;font-size: 12px;font-family:Roboto, sans-serif;display:none;bottom: -28px; color: #f00; margin-top: 5px;" id="msilDiv">Please select</div>
		  </div>
       
		 <div class="form-block work-exp" id="old_mspin">
            <h5>MSIL Experience (in months)
			</h5>
            <input type="text" name="msilExp" placeholder="MSIL Experience (in months)"   maxlength="8" id="mil_exp"  onkeyup="checkMSIL()"  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/>
		 </div>
		  <div class="form-block work-exp"  id="old_mspin2" >	
                    <div >		  
								<h5>
									MSPIN 
								</h5>
								<input type="text" placeholder="MSPIN" name="oldMspin" id="mspin" maxlength="8" onkeyup="deleteOldMSPIN()"   oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/><!--<input type="button" value="search" onclick="getOldMSPIN()" id="searchmspin" placeholder="MSPIN">-->
								<div style="font-weight: 500;font-size: 12px;font-family:Roboto, sans-serif;display:none;bottom: -28px;" id="div_msg"></div>
								</div>
							</div> 
							
							
		 
		</div>

		 <!-- <div class="form-block"></div> -->
		<div class="form-section">   
 
			<div class="form-block">
			<h5>
				Primary Language 
			</h5>
			<select   name="primaryLanguage" id="primery_lg" style="color: black !important">
				<option value="">Select</option>
				<c:forEach items="${language}" var="language">
				 <c:choose>
					 <c:when test="${language  eq personal.primaryLanguage}">
						 <option value="${language.listCode}"selected="selected">${language.listDesc}</option>
					 </c:when>
					  <c:otherwise>
						 <option value="${language.listCode}">${language.listDesc}</option>
				   </c:otherwise>
				  </c:choose>
				
				</c:forEach>
			</select>
		</div>
		<div class="form-block">
			<h5>
				Secondary Language 
			</h5>
			<select   name="secondaryLanguage" id="secondary_lg" style="color: black !important">
				<option value="">Select</option>
				<c:forEach items="${language}" var="language">
				  <c:choose>
					 <c:when test="${language.listCode  eq personal.secondaryLanguage}">
					   <option value="${language.listCode }" selected="selected">${language.listDesc}</option>
				   </c:when>
				   <c:otherwise>
					  <option value="${language.listCode}">${language.listDesc}</option>
				   </c:otherwise>
			 </c:choose>									
				</c:forEach>
			</select>
		</div>
		
</div>  
<div class="upload-section" id="divrmg" style="width: 96% !important;" >
            <h5 id = "rsmm">Upload Your Resume </h5>
            <div class="upload-tnc">
              <div id = "pp">
                <p>File format: MS Word and PDF File Size: 500 KB</p></div>
                <!-- in sucess case -->
                <div class="success-tnc" id = "successrsm"><img src="./img/check-icn.png" /> Successfully uploaded</div>
                <!-- in sucess case -->
                <!-- in error case -->
                <div class="error-tnc" id = "errorrsm" ><img src="./img/cross-icn.png" /> Please upload file</div>
                <!-- in error case -->
            </div>
            <div class="upload-input">	 
                <!-- in sucess case -->
                <div class="file-upload">
                  <div class="file-upload-select" onclick="$(this).parent().find('input[type=file]').click();">
                    
                        <div class="file-select-button">Choose File</div>
                        <div class="file-select-name">No file chosen</div>
                        <!-- <input type="hidden" name="resume" id="file-upload-input"> -->
                    </div>
                       <input type="file" name="resume" id="resume-input" onchange="$(this).parent().find('.file-select-name').html($(this).val().split(/[\\|/]/).pop());" 
					   style="display: none;" accept=".pdf, .docx, .doc ">                    
                </div>
           <button class="gray-btn upload-btn" data-id="resume-input" type="button" onclick="uploadFile8('resume');">Upload</button>
		     <a href="images/${participant.resume}" class="gray-btn upload-btn" target="_blank" id="vewrsm" style="display:none;">View</a>
			 <img class="preview" id="resume_photo" src="./img/loader.gif" style="width: 20px; display:none;">
			  </div>
            </div>
			<div class="form-btn">
				<input  class="btn blue-btn" type="submit" name="req" value="Submit"  id = "submitbtn" />
				<input type="hidden"  value = "" id="temp_fresher"  name="fresher" />
				<input type="hidden"  value = "" id="temp_experience" name="experience" />
				<input type="hidden"  value = "" id="age" name="age" />
				<input type="hidden"  value = "" id="twoWheeler" name="twoWheeler" />
				<input type="hidden"  value = "" id="fourWheeler" name="fourWheeler" />
				<input type="hidden"  value = "" id="licence" name="DL" />
				<input type="hidden"  value = "" id="certified" name="mdsCertified" />
				
				<input type="hidden"  value = "" id="ownTwoWheeler" name="ownTwoWheeler" />
				<input type="hidden"  value = "" id="ownFourWheeler" name="ownFourWheeler" />
				<input type="hidden"  value = "" id="msilExp" name="workedWithMSILBefore" />
				<input  path="oldMSPINStatus" type="hidden"  id="old_mspin_hiden" value=""/>
				<input type="hidden" value="${participant.finalDesignation}" id="designation" /> 
		   </div>
		 </form>          
        </div><!--closeProfessionalInformation-->

          <!-- <div class="break-section"></div>
          <h4>Do you know Driving</h4>
          <div class="break-section"></div>
          <div class="form-block">
            <h5>Two Wheeler</h5>
            <select   name ="twoWheeler">
              <option value = "">Select</option>
              <option value="Yes">Yes</option>
              <option value="No">No</option>
            </select>
          </div>
          <div class="form-block">
            <h5>Four Wheeler </h5>
            <select   name ="fourWheeler">
              <option value = "">Select</option>
              <option value="Yes">Yes</option>
              <option value="No">No</option>
            </select>
          </div>
          <div class="form-block">
                <h5>Driving Licence </h5>
                  <select   name="DL">
                      <option value ="">Select</option>
					  <option value="Yes">Yes</option>
				      <option value="No">No</option>       
                 </select>
          </div>
          <div class="break-section"></div>
          <h4>Do you own/have</h4>
          <div class="break-section"></div>
          <div class="form-block">
            <h5>Two Wheeler </h5>
            <select   name ="ownTwoWheeler">
              <option value = "">Select</option>
              <option value="Yes">Yes</option>
              <option value="No">No</option>
            </select>
          </div>
          <div class="form-block">
            <h5>Four Wheeler</h5>
            <select   name ="ownFourWheeler">
              <option value = "">Select</option>
              <option value="Yes">Yes</option>
              <option value="No">No</option>
            </select>
          </div>
         
          <div class="form-block">
            <h5>Work Experience</h5>
            <input type="radio"  value = "fresher" id="fresher" name="experience" />
            <label for="fresher">Fresher</label>
            <input type="radio"  value = "experience" id="experience" name="experience" />
            <label for="experience">Experience</label>
          </div>
          
          <div class="form-block work-exp experience">
            <h5>Experience in Automobile Industry (in months) </h5>
            <input type="text"  name ="autoIndustryExperience" id ="autoIndustryExperience" onkeyup="checkTotalExp()" maxlength="3" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/>
          </div>
          <div class="form-block work-exp experience">
            <h5>Experience in Non-Automobile Industry (in months) </h5>
            <input type="text"  name ="nonAutoIndustryExperience" id ="nonAutoIndustryExperience" maxlength="3" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" onkeyup="checkTotalExp()"/>
          </div>
		  <div class="form-block work-exp experience">
            <h5>Total Work Experience (in months) </h5>
            <input type="number" name ="total" id ="total" readonly="true"/>
          </div>
           <div class="form-block work-exp experience">
            <h5>MSIL Experience (in months) </h5>
             <input type="text"  name ="msilExp"   maxlength="3" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/>
          </div>
          
							<div class="form-block" >
							<div id="divspin" style="display:none">
								<h5>
									MSPIN 
								</h5>
								<input type="text"  id="old_mspin" maxlength="8"  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/>
							<div style="font-weight: 500;font-size: 12px;ont-family:Roboto, sans-serif;display:none;bottom: -28px; color: #f00 !important;" id="div_msg">Please enter accesskey</div>
							</div>
							</div>
								
           
          <div class="form-block" id="others">
            <h5>&nbsp;</h5>
            <input type="text" placeholder="Please mention *" name = "other"/>
          </div>
          <div class="break-section"></div>
        </div>
    </div>    -->
       <!-- first photograph upload -->
        <!-- <div class="upload-section" id="upload-section-photo">
            <h5 id = "pht">Upload Your Photograph </h5>
            <div class="upload-tnc">
            <div id = "p">
                <p>Self-Passport Color Photo (Allowed Photo Size - 3.5 cm x 4.5 cm)</p>
                <p>File format: JPEG, PNG, TIFF, BMP, JPG and File Size: 500 KB</p></div> -->
                 <!-- in sucess case -->
                <!-- <div class="success-tnc" id = "successphoto"><img src="./img/check-icn.png" /> Successfully uploaded</div> -->
                <!-- in sucess case -->
                <!-- in error case -->
                <!-- <div class="error-tnc" id = "errorphoto"><img src="./img/cross-icn.png" /> Please upload file</div> -->
                <!-- in error case -->
            <!-- </div> -->
            <!-- <div class="upload-input"> -->
             <!-- in sucess case -->
			
            <!--<input type="button" id="vewphoto" class="view-btn gray-btn" onclick="openVewFile('${participant.accessKey }','photograph')" value="View File" style="display:none;">  -->
                 <!-- in sucess case -->
                <!-- <div class="file-upload"> -->
               <!-- <div class="file-upload-select" onclick="$(this).parent().find('input[type=file]').click();">                
                       <div class="file-select-button">Choose File</div>
                        <div class="file-select-name">No file chosen</div> -->
                        <!-- <input type="file" name="photograph" id="file-upload-input"> -->
                    <!-- </div>
                    <input type="file" name="photograph" id="phtograph-input" onchange="$(this).parent().find('.file-select-name').html($(this).val().split(/[\\|/]/).pop());" 
					style="display: none;" accept=".jpg, .jpeg, .png,.png, .tiff, .bmf">
                </div>
                <button class="gray-btn upload-btn" data-id="phtograph-input" type="button" onclick="uploadFile('photograph');">Upload</button>
				 <a href="images/${participant.photograph}" class="gray-btn upload-btn" target="_blank"
									id="vewphoto" style="display:none;">View</a>
            </div>
        </div>         -->
        <!-- upload file resume upload -->
        <!-- <div class="upload-section" id="divrmg" style="width: 96% !important;" >
            <h5 id = "rsmm">Upload Your Resume </h5>
            <div class="upload-tnc">
              <div id = "pp">
                <p>File format: MS Word, TXT, PDF and File Size: 500 KB</p></div> -->
                <!-- in sucess case -->
                <!-- <div class="success-tnc" id = "successrsm"><img src="./img/check-icn.png" /> Successfully uploaded</div> -->
                <!-- in sucess case -->
                <!-- in error case -->
                <!-- <div class="error-tnc" id = "errorrsm" ><img src="./img/cross-icn.png" /> Please upload file</div> -->
                <!-- in error case -->
            <!-- </div>
            <div class="upload-input">	  -->
                <!-- in sucess case -->
                <!-- <div class="file-upload">
                  <div class="file-upload-select" onclick="$(this).parent().find('input[type=file]').click();">
                    
                        <div class="file-select-button">Choose File</div>
                        <div class="file-select-name">No file chosen</div> -->
                        <!-- <input type="file" name="resume" id="file-upload-input"> -->
                    <!-- </div>
                       <input type="file" name="resume" id="resume-input" onchange="$(this).parent().find('.file-select-name').html($(this).val().split(/[\\|/]/).pop());" 
					   style="display: none;" accept=".pdf,.jpg, .jpeg, .png,.png, .tiff, .bmf">                    
                </div>
           <button class="gray-btn upload-btn" data-id="resume-input" type="button" onclick="uploadFile8('resume');">Upload</button>
		     <a href="images/${participant.resume}" class="gray-btn upload-btn" target="_blank" id="vewrsm" style="display:none;">View</a>
            </div>          
        </div> -->
        <!-- <div class="form-btn">
             <input  class="btn blue-btn" type="submit" name="req" value="Submit"  id = "submitbtn" />
             <input type="hidden"  value = "" id="temp_fresher"  name="fresher" />
             <input type="hidden"  value = "" id="temp_experience" name="experience" />
             <input type="hidden"  value = "" id="age" name="age" />
			 <input type="hidden"  value = "" id="twoWheeler" name="twoWheeler" />
			 <input type="hidden"  value = "" id="fourWheeler" name="fourWheeler" />
			 <input type="hidden"  value = "" id="licence" name="DL" />
			 <input type="hidden"  value = "" id="certified" name="mdsCertified" />
			 
			  <input type="hidden"  value = "" id="ownTwoWheeler" name="ownTwoWheeler" />
			   <input type="hidden"  value = "" id="ownFourWheeler" name="ownFourWheeler" />
			   <input type="hidden"  value = "" id="msilExp" name="workedWithMSILBefore" />
        </div>
      </form> -->
     <!-- javaScript and jquery -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/jquery.validate.min.js"></script>
    <script type="text/javascript" src="./js/register.js"></script>   
    
    <script>
	 $(document).ready(function () {
    	getState();
		closeExp();
		 $(function(){
    	    var dtToday = new Date();
    	    
    	    var month = dtToday.getMonth();
    	    var day = dtToday.getDate();
    	    var year = dtToday.getFullYear()-18;
    	    if(month < 10)
    	        month = '0' + month.toString();
    	    if(day < 10)
    	        day = '0' + day.toString();
			
			if(month ==0)
    	    month = '01';
    	    var maxDate = year + '-' + month + '-' + day;
			//alert(maxDate);
    	    // or instead:
    	    // var maxDate = dtToday.toISOString()./(0, 10);
    	   // $('#birthDate').attr('max', maxDate);
		   
		   document.getElementById("birthDate").setAttribute("max", maxDate);
    	    
    	    
    	});
		
		 var designation = $("#designation").val();
		 console.log("........."+designation);
		 if(designation == "STR"){
			 console.log("........."+designation);
			$("#old_mspin2").hide(); 
		 }
    
  });
	 function openVewFile(accesskey,fileName)
	{
    	window.location.href="viewFile?accessKey="+accesskey+"&fineName="+fileName;	
	}
	
      $(document).ready(function () {
        $("#dealership").change(function () {
          if (this.value == "others") {
            $("#others").show().find(':input').attr('required', true);
            $("#others input").attr('required', true);
          } else {
            $("#others").hide().find(':input').attr('required', false);
            $("#others input").removeAttr('required');
          }
        });

      });
	  
	  function drivingTwoYes(){
		   $(".licence-ertified").show();
		   $("#driving_2_yes").prop('checked',true);
		   $("#driving_2_no").prop('checked',false);
		  $("#twoWheeler").val("Yes");
	  }
	  
	  function drivingTwoNo(){	  
		 
          $("#driving_2_yes").prop('checked',false);
		  $("#driving_2_no").prop('checked',true);
          $("#twoWheeler").val("No");
          if( $("#twoWheeler").val() == "No" && ($("#fourWheeler").val() == "No" || $("#fourWheeler").val() == "")){		  
           $(".licence-ertified").hide();
		  <!-- $("#licence").val(""); -->
		   $("#certified").val("");
		  <!-- $("#licence_yes").prop('checked',false); -->
		  <!-- $("#licence_no").prop('checked',false);  -->
		   
		   $("#certified_yes").prop('checked',false);
		   $("#certified_no").prop('checked',false);
		  }		   
	  }
	  
	   function drivingFourYes(){
		   $(".licence-ertified").show();
		   $("#driving_4_yes").prop('checked',true);
		   $("#driving_4_no").prop('checked',false);
		   $("#fourWheeler").val("Yes");		  		
	  }
	  
	  function drivingFourNo(){	  
		 
          $("#driving_4_yes").prop('checked',false);
		  $("#driving_4_no").prop('checked',true);	
          $("#fourWheeler").val("No");
         if( ($("#twoWheeler").val() == "No" || $("#twoWheeler").val() == "") && ($("#fourWheeler").val() == "No" || $("#fourWheeler").val() == "")){		  
             $(".licence-ertified").hide();
		  <!-- $("#licence").val(""); -->
		   $("#certified").val("");  
		 <!-- $("#licence_yes").prop('checked',false);  -->
		 <!--  $("#licence_no").prop('checked',false); -->
		   
		   $("#certified_yes").prop('checked',false);
		   $("#certified_no").prop('checked',true);
		  }	
         if($("#twoWheeler").val() =="Yes"){
			$("#certified_yes").prop('checked',false);
        	$("#certified_no").prop('checked',true);
			 $("#certified").val("No");
			}
		  
	  }
	  
	  function openExp(){
		var val = $("#experience:checked").val();
        	$("#temp_experience").val(val);
        	 $("#temp_fresher").val("");
        	 $("#experience").prop('checked',true);
        	 $("#fresher").prop('checked',false);
        	 $(".work-exp, experience").show();
        	 $(".work-exp").find(':input').attr('required', true);  
			 // $("#mspin").find(':input').attr('required', false);
                $("#mspin").removeAttr('required');			 
		  milYes();
	  }
	  
	  function closeExp(){
		 var val = $("#fresher:checked").val();
        	
        	$("#temp_experience").val("");
        	$("#fresher").prop('checked',true);
        	$("#experience").prop('checked',false);
        	$(".work-exp, experience").hide();	 
        	$(".work-exp").find(':input').attr('required', false); 
			$("#temp_fresher").val("fresher");
			
			 $("#total").val("");
			 $("#autoIndustryExperience").val("");
			 $("#nonAutoIndustryExperience").val("");
			 $("#msilExp").val("");
			milNo();
	  }
	 
	 function dlYes(){
		    $("#licence_yes").prop('checked',true);
        	$("#licence_no").prop('checked',false);
			$("#licence").val("Yes");
	   }
	   
	    function dlNo(){
			 $("#licence_yes").prop('checked',false);
        	$("#licence_no").prop('checked',true);
			$("#licence").val("No");
			
		//	$("#certified_yes").prop('checked',false);
        //	$("#certified_no").prop('checked',true);
			//$("#certified").val("No");
	   }
	   
	    function mdsYes(){
		    $("#certified_yes").prop('checked',true);
        	$("#certified_no").prop('checked',false);
			$("#certified").val("Yes");
			if( $("#fourWheeler").val() == "No"){
			$("#certified").val("No");
            $("#certified_yes").prop('checked',false);
        	$("#certified_no").prop('checked',true);			
			}
	   }
	   
	    function mdsNo(){
			 $("#certified_yes").prop('checked',false);
        	$("#certified_no").prop('checked',true);
			$("#certified").val("No");
	   }
	   
	    function milYes(){
		    $("#msilYes").prop('checked',true);
        	$("#msilNo").prop('checked',false);
			$("#msilExp").val("Yes");
			$("#old_mspin").show();
			$("#old_mspin").find(':input').attr('required', true); 
            $("#mspin").find(':input').attr('required', true); 	

         $("#old_mspin2").show();	
		  var designation  = $("#designation").val();
		  if(designation == "STR"){
			  $("#old_mspin2").hide();	
		  }
         //$("#old_mspin2").find(':input').attr('required', true); 				
	   }
	   
	    function milNo(){
			 $("#msilNo").prop('checked',true);
        	$("#msilYes").prop('checked',false);
			$("#msilExp").val("No");
			$("#old_mspin").hide();
			$("#old_mspin").find(':input').attr('required', false); 
            $("#mspin").find(':input').attr('required', false); 
            $("#mspin").val("");
            $("#mil_exp").val("");	

           $("#old_mspin2").hide();	
           //$("#old_mspin2").find(':input').attr('required', false); 		   
	   }
	   
	   
	   
	    function ownTwoYes(){
		    $("#own_2_yes").prop('checked',true);
        	$("#own_2_no").prop('checked',false);
			$("#ownTwoWheeler").val("Yes");
			
	   }
	   
	    function ownTwoN(){
			 $("#own_2_no").prop('checked',true);
        	$("#own_2_yes").prop('checked',false);
			$("#ownTwoWheeler").val("No");
			
	   }
	   
	    function ownFourYes(){
		    $("#own_4_yes").prop('checked',true);
        	$("#own_4_no").prop('checked',false);
			$("#ownFourWheeler").val("Yes");
			
	   }
	   
	    function ownFourNo(){
			 $("#own_4_yes").prop('checked',true);
        	$("#own_4_yes").prop('checked',false);
			$("#ownFourWheeler").val("No");
	   }
	   
		function checkTotalExp(){
			var autoExp = $("#autoIndustryExperience").val();
			var nonAutoExp = $("#nonAutoIndustryExperience").val();
			if(autoExp != "" && nonAutoExp !=""){
			var alltotal = parseInt(autoExp)+parseInt(nonAutoExp);
			document.getElementById("total").value=alltotal;
			}
			var totalExp = document.getElementById("total").value;
			if(totalExp >= 600){
			 swal({   
				  title: 'Total experince cannot be more than 600 months.',     
				  showCancelButton: false,
				  confirmButtonColor: "#2D3392",   
				  confirmButtonText: "OK",   
				  closeOnConfirm: true },
				  function(isConfirm){	
                  $("#autoIndustryExperience").val("");	
                  $("#nonAutoIndustryExperience").val("");
                  $("#total").val("");				  
					  return false; 
				}); 
			}
		}
		
		
		function checkMSIL(){
			
			var autoExp1 = Number($("#autoIndustryExperience").val());
			var mspinExp = Number($("#mil_exp").val());
			var totalExp1 = Number($("#total").val());
			if(mspinExp > autoExp1 || mspinExp > totalExp1){
			 swal({   
				  title: 'MSIL experience cannot be more than total experience & experience in automobile industry.',     
				  showCancelButton: false,
				  confirmButtonColor: "#2D3392",   
				  confirmButtonText: "OK",   
				  closeOnConfirm: true },
				  function(isConfirm){	
                 $("#mil_exp").val("");				  
					  return false; 
				}); 
			}
		}
		
		function getCity(){
			var state = $("#state").val();
			 var fd = new FormData();
			  fd.append('state',state);
			$.ajax({
		         url: 'dms/getCity',
		         enctype: 'multipart/form-data',
		         type:'post',
		         data: fd,
		           processData: false,
		           contentType: false,
		           cache: false,
		         success:function(res){
					  $('#cityList')
		        	    .find('option')
		        	    .remove()
		        	    .end()
		        	    .append(res);
		    	  },
		          error:function(ress){
					
		    	  }
	  			}); 
	
		}
		
		function getState(){
			$.ajax({
		         url: 'dms/getState',
		         type:'GET',
		         success:function(res){
		        	 $('#state')
		        	    .find('option')
		        	    .remove()
		        	    .end()
		        	    .append(res);
		    	  },
		          error:function(ress){
		    	  }
	  			}); 
		}
		
		function getStateCity(){
		var pincode = $("#pincode").val()
			var stateCode= "";
			if(pincode==""){
				stateCode =  $('#state').val();
				$.ajax({
					 async: false,
			         url: 'dms/getCity',
			         type: 'POST',
			         data: 'state='+stateCode,
			         success:function(res){
			        	  $('#cityList')
			        	    .find('option')
			        	    .remove()
			        	    .end()
			        	    .append(res); 
			    	  },
			          error:function(ress){
			    	  }
		  			}); 
				return  false;
			}
			$.ajax({
				 async: false,
		         url: 'dms/getStateByPinCode',
		         type: 'POST',
		         data: 'pincode='+pincode,
		         success:function(res){
		        	 stateCode=res;
		        	 $('#state').val(res);
		    	  },
		          error:function(ress){
		    	  }
	  			}); 
			
				$.ajax({
					 async: false,
			         url: 'dms/getCity',
			         type: 'POST',
			         data: 'state='+stateCode,
			         success:function(res){
			        	  $('#cityList')
			        	    .find('option')
			        	    .remove()
			        	    .end()
			        	    .append(res); 
			    	  },
			          error:function(ress){
			    	  }
		  			}); 
			
			
			
			
			$.ajax({
				 async: false,
		         url: "dms/getCityByPinCode",
		         type: "POST",
		         data: "pincode="+pincode,
		         success:function(res){
		        	 if(res == "0"){
		        		 $("#cityList")
			        	    .find('option')
			        	    .remove()
			        	    .end()
			        	    .append("<option value =''>Select</option>"); 
		        	 }else{
		        	   $("#cityList").val(res);
		        	 }
		    	  },
		          error:function(ress){
		    	  }
	  			}); 
			 
		}
		
		$("#pincode").on('input', function () {
			getStateCity();
		});
		
		function getPincodeByCity(){
			var city=$("#cityList").val();
			$.ajax({
		         url: 'dms/getPinByCity',
		         type: 'POST',
		         data: 'cityCode='+city,
		         success:function(res){
		        	 $('#pincode')
		        	    .find('option')
		        	    .remove()
		        	    .end()
		        	    .append(res);
		    	  },
		          error:function(ress){
		    	  }
	  			}); 
		}
		
		function workWithMIL() {
			var work = $('#workedWithMSILBefore').val()	;
			
			var div_work =  document.getElementById('divspin');;
			
			if(work == 'Yes'){
				div_work.style.display = 'block';
			}
			if(work == 'No'){
				div_work.style.display = 'none';
			}
			}
		
		function searchMspin(){
			var mspin = $("#old_mspin").val();
	        if(mspin ==""){
	        	return false;
	        }
			$.ajax({
		         url: 'searcOldhMspin',
		         type: 'GET',
		         data: 'mspin='+mspin,
		         success:function(res){
		        	 console.log(res); 
		        	 $("#old_mspin").val(res.msg);
		        	if(res.secondaryLanguage !=null && res.secondaryLanguage !=""){
		        		 $('#secondary_lg').val(res.secondaryLanguage);
		        	}
		        	if(res.primeryLanguage !=null && res.primeryLanguage !=null){
		        		$('#primery_lg').val(res.primeryLanguage);	
		        	}
		        	if(res.qualification != "" && res.qualification != null){
		        		$('#qlt').val(res.qualification);		
		        	} 
		        	if(res.idProof != "" && res.idProof != null){
		        		$('#idProof').val(res.idProof);		
		        	}
		        	 console.log(res.validatyDl);
		        	if(res.validatyDl != "" && res.validatyDl != null){
		        		$('#vd_lc').val(res.validatyDl);		
		        	}
		        	
		        	 $('#div_msg').text('');
		        	 if(res.msg =="0"){
		        		 $('#div_msg').append('The candidate is already working');	 
		        	 }
		        	 if(res.msg =="1"){
		        		 $('#div_msg').append('The searched MSPIN does not exist');	 
		        	 }
		        	 if(res.msg =="2"){
		        		 $('#div_msg').append('The candidate is Inactive');	 
		        	 }
		    		
		    		 $('#div_msg').show();   
		        	
		    	  },
		          error:function(ress){
		    	  }
	  			}); 
		}
		
		function deleteOldMSPIN(){
			
		 $("#old_mspin_hiiden").val("");
         $('#div_msg').text("");			 
		}
		
		function getOldMSPIN(){
			var mspin = $("#mspin").val();
			var accesskey  = $("#accessKey").val();
			if(mspin ==""){
				$('#div_msg').text('');
		       $('#div_msg').append('Please enter MSPIN');
		       $('#div_msg').show();
	        	return false;
	        }
		$.ajax({
		         url: 'getOldMSPIN',
		         type: 'POST',
		         data: 'oldMSPIN='+mspin+"&accesskey="+accesskey,
		         success:function(res){
		         if(res != ""){
					 $('#div_msg').text("");	
					 $('#div_msg').append(res);	
                     $('#div_msg').show(); 	
                  $("#old_mspin_hiden").val(3);					 
				 }else{
				   searchMspin();	 
				 }
		        	
		    	  },
		          error:function(ress){
		    	  }
	  			});
			
		}
		
		function searchMspin(){
			var mspin = $("#mspin").val();
	        if(mspin ==""){
	        	return false;
	        }
			$.ajax({
		         url: 'searcOldhMspin',
		         type: 'GET',
		         data: 'mspin='+mspin,
		         success:function(res){
		        	 console.log(res); 
		        	 $("#old_mspin_hiden").val(res.msg);
		        	if(res.secondaryLanguage !=null && res.secondaryLanguage !=""){
		        		 $('#secondary_lg').val(res.secondaryLanguage);
		        	}
		        	if(res.primeryLanguage !=null && res.primeryLanguage !=null){
		        		$('#primery_lg').val(res.primeryLanguage);	
		        	}
		        	if(res.qualification != "" && res.qualification != null){
		        		$('#ql').val(res.qualification);		
		        	} 
		        	if(res.idProof != "" && res.idProof != null){
		        		$('#idProof').val(res.idProof);		
		        	}
		        	 console.log(res.validatyDl);
		        	if(res.validatyDl != "" && res.validatyDl != null){
		        		$('#vd_lc').val(res.validatyDl);		
		        	}
		        	
		        	 $('#div_msg').text('');
		        	 if(res.msg =="0"){
		        		 $('#div_msg').append('MSPIN Active');	 
		        	 }
		        	 if(res.msg =="1"){
		        		 $('#div_msg').append('MSPIN does not exist');	 
		        	 }
		        	 if(res.msg =="2"){
		        		 $('#div_msg').append('MSPIN is Inactive');	 
		        	 }
		    		
		    		 $('#div_msg').show();   
		        	
		    	  },
		          error:function(ress){
		    	  }
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
