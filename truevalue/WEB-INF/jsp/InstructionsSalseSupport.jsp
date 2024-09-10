 <%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page import = "java.util.ResourceBundle" %>
<%try{ 
ResourceBundle resource = ResourceBundle.getBundle("application");
String baseServer = resource.getString("client.url");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="icon" type="image/x-icon" href="<%=baseServer%>img/iRecruit-favicon.ico"/>
    <title>iRecruit</title>
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
            <!-- <div class="logo"><img src="https://www.irecruit.org.in/irecruit/img/iRecruit-logo.svg" alt="" /></div> -->
        <div class="logo"><h2 class="LOGO" style="color: #fff; font-size: 32px; font-weight: 700;"><b>iRecruit</b></h2></div>

        </div>
    </div>
    <div class="section">
        <h1>Candidate Registration Form</h1>
        <div class="instructions">
           <!-- <h2>Instructions</h2> -->
           <p>Please read the instructions carefully and follow the step-by-step process.</p>
 
    <ol type="none">
    
          <li>1.&nbsp; <span> Please fill in the details on the registration page and upload your photograph and resume. Your Resume should be the most current.</span></li>
          <li>2.&nbsp; <span> While uploading the photograph, please make sure you have a passport-size color photograph in 3.5cm X 4.5 cm size ready with you.</span></li>
		  <li>3.&nbsp; <span> Make sure that your photograph is straightforward with your full face with no background and not with multiple faces in it. Refer to the image below.</span></li>
		   <img src="https://www.irecruit.org.in/irecruit/img/pimg.png" style="max-width: 100%" />
		  </li>
		  <li>4.&nbsp; <span>You may upload photographs in either JPEG, PNG, or JPG format.</span></li>
		  <li>5.&nbsp; <span> Size of the image file should not exceed 500 kb.</span></li>
        
	  
    </ol>
	 <ol type="none">
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

 <%}catch(Exception e){
	  // out.print(e);
   }   
  %>