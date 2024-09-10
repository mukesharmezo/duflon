<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> 
<%request.setCharacterEncoding("UTF-8");%>
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
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="icon" type="image/x-icon" href="<%=baseServer%>img/iRecruit-favicon.ico"/>   <title>iRecruit</title>
    <link rel="stylesheet" type="text/css" href="./css/instruction.css" />
    <script src="./js/jquery-3.4.1.min.js"></script>
</head>
<style>
    .form#testform { margin-bottom: 50px !important;}
    /* .section ol li span{margin: 0px 0px 0px 15px !important;} */
    .section ol li{list-style: none;}
    .section ol li img{margin: 0px 0px 0px 40px;}
    .instructions ol li{margin-bottom: 5px !important; }
    /* .desk-mob-instr{margin-left:45px;margin-bottom: 0px;} */
    .inst-ol-responsive li{display:flex !important;}

    .inst-const-ol li {
    list-style: disc !important;
    display: list-item;
}
	@media (max-width: 767px) {
    .section ol li img {
        margin: 0;
    }
}
</style>
<body>
    
    <div class="header">
        <div class="container">
            <!-- <div class="logo"><img src="./img/iRecruit-logo.svg" alt="" /></div> -->
        <div class="logo"><h2 class="LOGO" style="color: #fff; font-size: 32px; font-weight: 700;"><b>iRecruit</b></h2></div>

        </div>
    </div>
    <div class="section">
        <h1>Candidate Registration Form</h1>
        <div class="instructions">
           <!-- <h2>Instructions</h2> -->
           <p>Please read the instructions carefully and follow the step-by-step process.</p>
  <ol>
  <li>1.&nbsp; <span>Please ensure your computer/laptop/mobile has stable and high-speed internet.</span></li>
  <li>2.&nbsp; <span>If you are using a Computer/Laptop, please do not change your screen.</span></li>
  <li>3.&nbsp; <span>If you are using a Mobile Phone, do not navigate away from the screen even to receive/see any phone call, SMS, or other App.</span></li>
  <li>4.&nbsp; <span>There are two (02) sections, Candidate Registration and Online Assessment.</span></li></ol>
  <!-- <br> -->
    <ol type="none">
      <li  style="list-style: none;"><b>4.1.</b><b>Candidate Registration:</b>
        <ol class="inst-ol-responsive" type="none">
          <li>4.1.1.&nbsp; <span> Please fill in the details on the registration page and upload your photograph and resume. Your Resume should be the most current.</span></li>
          <li>4.1.2.&nbsp; <span> While uploading the photograph, please make sure you have a passport-size color photograph in 3.5cm X 4.5 cm size ready with you.</span></li>
		  <li>4.1.3.&nbsp; <span> Make sure that your photograph is straightforward with your full face with no background and not with multiple faces in it. Refer to the image below.</span></li>
		   <img src="./img/pimg.png" style="max-width: 100%" />
		  </li>
		  <li>4.1.4.&nbsp; <span>You may upload photographs in either JPEG, PNG, or JPG format.</span></li>
		  <li>4.1.5.&nbsp; <span> Size of the image file should not exceed 500 kb.</span></li>
        </ol>
      </li>
	  <li  style="list-style: none;"><b>4.2.</b><b>Online Assessment:</b>
	   <ol class="inst-ol-responsive" type="none">
	   <!-- <li>4.2.1. &nbsp; <span>You will have a maximum of 1 hour. (i.e, 60 minutes) to complete the assessment.</span></li> -->
	   <li>4.2.1.&nbsp; <span> You will have a maximum of 1 hour. (i.e, 60 minutes) to complete the assessment.</span></li>

	   <li>4.2.2.&nbsp; <span> Please close all applications/programs/windows on your computer/mobile before starting the assessment.</span></li>
	   <li>4.2.3.&nbsp; <span> Please complete these assessments in one-go however, if you get disconnected or see a blank screen then, please close your browser and open the above link again to resume the assessment.</span></li>
	   <li>4.2.4.&nbsp; <span> Please attempt the assessment alone without any disturbance/distractions.</span></li>
	   <li>4.2.5.&nbsp; <span> You must attempt/answer all questions. There are no negative marks.</span></li>
	   <li>4.2.6.&nbsp; <span> During the assessment, the web camera will be activated to click your photograph so, make sure you are in appropriate attire and keep your face in front of the camera at all times.</span></li>
	   <li>4.2.7.&nbsp; <span> You are not allowed to move out of the assessment screen (or change screens) till the time you have not completed the assessment, else your assessment will be blocked.</span></li>
	  </ol>
	  </li>
    </ol>
    <li><span><b>By providing your details, you hereby give consent to use the information for the purpose of:</span> </span></b>
        <ol class="inst-const-ol">
        <li  style="margin-left:60px;"><span> Recruitment process</span></li>
        <li style="margin-left:60px;"><span> Evaluation of candidature</span></li>
        <li style="margin-left:60px;"><span> Checking the integrity of the documents</span></li>
        <li style="margin-left:60px;"><span> Retention as per data provider consent policy</span></li>
        </ol>
      </li>
  
  
</ol>
            <p><b>I understand that any information provided by me that is found to be false, incomplete or misrepresented in any respect will be sufficient cause to
			     (i) eliminate me from further consideration for employment or (ii) may result in my immediate discharge from the employer's service, whenever it is discovered</b></p>
            <p><label>
                <input type="checkbox" id="tnc"/>
                <b>I have read, understood and accept the terms of use, privacy policy and data provider consent policy.</b>
            </label></p>
        </div>
         <div class="btn">
        <form name="testform" id="testform" action="./instructionPro" method="post">
        <input  type="submit" id="submit" class="btn"  disabled value="Proceed" onclick="getTest()"/>
        <input type="hidden" id="accesskey" name="accesskey" value="${accesskey}">
        </form>
        </div>
    </div>
    
     <script>
    $(document).ready(function () {
    	// $('#submit').attr('disabled', true);
    	
        $('#tnc').change(function() {
            if(this.checked) {
                $('#submit').removeAttr('disabled');
            } else{
                $('#submit').attr('disabled', true);
            }
        });
    });
    
    function getTest(){
    	var  accesskey= $("#accesskey").val();
    	//$("#testform").action="intructionPro?accesskey="+accesskey;
    	//$("#testform").method="post";
    	$("#testform").submit();
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