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
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	 <link rel="icon" type="image/x-icon" href="<%=baseServer%>img/DuflonFavicon.png"/>   <title><%=title %></title>
   <link rel="stylesheet" type="text/css" href="./css/intructionUpload.css" />
   <script src="./js/jquery-3.4.1.min.js"></script>
</head>
<body>
    <div class="header">
        <div class="container">
            <!-- <div class="logo"><img src="./img/duRecruit-logo.svg" alt="" /></div> -->
        <div class="logo"><h2 class="LOGO" style="color: #fff; font-size: 32px; font-weight: 700;"><b><%=title %></b></h2></div>

            <!-- <div class="logo"><h2><b>iRecruit</b></h2></div> -->

        </div>
    </div>
    <div class="section instructions">
        <h1>Upload Documents</h1>
       <!-- <div class="instructions"> -->
            <h2>Guidelines for uploading your documents in the duRecruit portal</h2>
            <ol type="1">
                <li>Check the documents which are to be uploaded</li>
                <li>Keep these documents in one place before uploading them</li>
                <li>Documents need to be uploaded in one go</li>
                <li>All documents must be scanned properly and clearly. Please avoid blurred, faded and hazy images.</li>
                <li>All documents must be within the file size limit.</li>
                <li>All documents must be in the required file format.</li>
                <li>You will not be able to upload the documents if the file size exceeds or the file format does not match.</li>
                <li>Click on the browse button of the document type you are uploading.</li>
                <li>Browse and Select the location where the document/file has been saved.</li>
                <li>Once the document is selected, click OK and then click on the upload button.</li>
                <li>On uploading each document, you will get a confirmation message.</li>
                <li>You need to repeat the process every time for uploading all documents.</li>
                <li>Please reach out to your respective recruiter/dealer if you face any issues while uploading documents
                    <h4>Govt ID Card</h4>
                    <ul class="sublist">
                        <li>Upload the full image of your Govt. ID Card</li>
                        <li>Do NOT upload a copy with the surrounding background</li>
                        <li>Do NOT upload a poor quality photocopy</li>
                        <li>Do NOT upload a copy with the glare of the camera flash</li>
                        <li>Please make sure to CROP & UPLOAD only the PAN Card image, if you have a ePAN Card</li>
                    </ul>
                    <div class="udimg"><img src="./img/udimg.png" /></div>
                    <div class="innerli">
                        <p><b>List of joining documents to be uploaded (Table below)</b></p>
                        <table cellspacing="0" cellpadding="0" border="0">
                            <tbody><tr>
                                <th><b>Document Type</b></th>
                                <th><b>File Size</b></th>
                                <th><b>File Format</b></th>
                            </tr>
                            <tr>
                                <td><b>Self-Passport Colour Photo</b><span>(Allowed Photo Size - 3.5 cm x 4.5 cm)</span></td>
                                <td>500 KB</td>
                                <td>JPEG, PNG, JPG</td>
                            </tr>
                            <tr>
                                <td><b>Your Signature</b><span>(Must be on white paper with current date)<br>
                                    (Allowed Size 3.5 cm x 1.5cm)</span></td>
                                <td>500 KB</td>
                                <td>JPEG, PNG, JPG</td>
                            </tr>
                            <tr>
                                <td><b>Identity Proof (Any one)</b>
                                    <ol type="1">
                                        <li>1. Aadhar Card, 2. PAN Card, 3. Voter ID Card, 4. Driving License, 5. Passport, 6. Others</li>
                                    </ol>
                                </td>
                                <td>1 MB</td>
                                <td>PDF, JPEG, PNG, JPG</td>
                            </tr>
                            <tr>
                                <td><b>Identity Proof (Any one)</b>
                                    <ol type="1">
                                        <li>1. Aadhar Card, 2. Voter ID 
                                            Card, 3. Passport, 4. Ration Card with address, 5. Bank Passbook, 6. 
                                            Electricity Bill (not older than the last three months), 7. Telephone Bill 
                                            (not older than last three months), 8. Water Bill (not older than the last 
                                            three months), 9. Registered Sale/ Rent Agreement, 10. Others</li>
                                    </ol>
                                </td>
                                <td>1 MB</td>
                                <td>PDF, JPEG, PNG, JPG</td>
                            </tr>
                            <tr>
                                <td><b>Educational Documents</b><span>(Upload up to your higher education possible)</span>
                                    <ol type="1">
                                        <li>Class 10th (SSC / Matriculation), Diploma/Class 12th (HSC / Intermediate), Diploma, Graduation, Post-Graduation, Others (if any)</li>
                                    </ol>
                                </td>
                                <td>&nbsp;<br>&nbsp;<br>1 MB</td>
                                <td>PDF, JPEG, PNG,  JPG</td>
                            </tr>
                            <tr>
                                <td><b>Work Experience</b><span>(Resignation Letter)</span>
                                </td>
                                <td>1 MB</td>
                                <td>PDF, JPEG, PNG, JPG</td>
                            </tr>
                            <tr>
                                <td><b>Work Experience</b><span>(Experience /Relieving Letter)</span>
                                </td>
                                <td>1 MB</td>
                                <td>PDF, JPEG, PNG, JPG</td>
                            </tr>
                            <tr>
                                <td><b>Work Experience</b><span>(Salary Slip)</span>
                                </td>
                                <td>1 MB</td>
                                <td>PDF, JPEG, PNG, JPG</td>
                            </tr>
                            <tr>
                                <td><b>Any other document</b>
                                </td>
                                <td>1 MB</td>
                                <td>PDF, JPEG, PNG, JPG</td>
                            </tr>
                        </tbody></table>
                    </div>
                </li>
            </ol>
            <p style="margin-top: 20px;">
                <b>By uploading the documents and providing your details, you hereby give consent to use the given information for the purpose of:</b><br>
                <li>Recruitment process</li><br>
                 <li>Evaluation of candidature</li><br>
                 <li>Checking the intergrity of the documents</li><br>
                 <li>Retention as per data provider consent policy</li>
            </p>
            <p><b>I understand that any information provided by me that 
is found to be false, incomplete or misrepresented in any respect will 
be sufficient cause to 
			(i) eliminate me from further consideration for employment or (ii) 
may result in my immediate discharge from the employer's service, 
whenever it is discovered.</b></p>
            <p><label>
                <input type="checkbox" id="tnc">
                <b>I have read, understood and accepted terms of use, privacy policy and data provider consent policy.</b>
            </label></p>
        </div>
       <div class="btn"><!-- <a href="#">Proceed</a> -->
        <form name="testform" id="testform" action="./instructionUploadFilePro" method="get">
        <input  type="submit" id="submit" class="btn"  disabled value="Proceed" onclick="getTest()"/>
        <input type="hidden" id="accesskey" name="accesskey" value="${accesskey}">
        </form>
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