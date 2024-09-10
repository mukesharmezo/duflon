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
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <link rel="icon" type="image/x-icon" href="<%=baseServer%>img/iRecruit-favicon.ico"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>iRecruitsdfsdf</title>
    <link rel="stylesheet" type="text/css" href="./css/common.css" />
    <link rel="stylesheet" type="text/css" href="./css/profile.css" />
    <link rel="stylesheet" href="/css/scrolltabs.css">
    <link rel="stylesheet" type="text/css" href="./css/upload-documents.css" />
    <style>
        .left-panel > ul > li:nth-child(2) > a, .left-panel > ul > li:nth-child(2) > ul > li:nth-child(2) > a{opacity: 1;}
        .left-panel > ul > li:nth-child(2) > ul > li:nth-child(2) > a::after{content: ''; position: absolute; right: 0; top: 50%; transform: translate(0, -50%); border-right: 6px solid #fff; border-top: 6px solid transparent; border-bottom: 6px solid transparent;}
        /* .upload-input {justify-content: none !important;}
        .upload-input .ir-view{margin-left: auto !important;} */
   </style>

    <script src="./js/jquery-3.4.1.min.js"></script>
    <script src="./js/jquery.dataTables.min.js"></script>
    <script src="/js/jquery.scrolltabs.js"></script>
    <script>
    function uploadFile(f,name)
    {
    var fd = new FormData();
    var files = $('#adhar')[0].files[0];
    var accessKey = $('#accessKey').val();
    if(files ==  undefined){
        alert("Please Select File");
        return false;
    }
        fd.append('file',files);
        fd.append('name',name);
        fd.append('accessKey',accessKey);

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
         	/* this "data" return our handler return type */
             //alert(data);
          //   alert("File Uploading successfully ");
             
         },
         
     });

    }
    </script>
  </head>
  <body>
    

    <div >
        <h1>Personal Details</h1>
        <div class="container-1100">
            <div class="profile-container">
            

              <div class="profile-content">
                <form action="" class="form">
        <div class="upload-section no-bor-mar-pad">
          <h5>Photograph <span>*</span></h5>
          <div class="upload-tnc">
            <p>Upload file in JPEG, PNG and PDF under 500KB in 252x252PX</p>
          </div>
          <div class="upload-input">
            <div class="file-upload">
              <div class="file-upload-select" onclick="$(this).parent().find('input[type=file]').click();">
                <div class="file-select-button btn">Choose File</div>
                <div class="file-select-name">No file chosen</div>
            </div>
            <input type="file" name="phtographt" id="phtograph-input" onchange="$(this).parent().find('.file-select-name').html($(this).val().split(/[\\|/]/).pop());" style="display: none;">
            </div>
            <button class="gray-btn upload-btn" data-id="phtograph-input" type="button" onclick="uploadFile($('#phtographt')[0].files[0]','sdf')">Upload</button>
          </div>
        </div>
        <div class="upload-section">
          <h5>Signature <span>*</span></h5>
          <div class="upload-tnc">
            <p>Upload file in JPEG, PNG and PDF under 500KB</p>
          </div>
          <div class="upload-input">
            <div class="file-upload">
              <div class="file-upload-select" onclick="$(this).parent().find('input[type=file]').click();">
                <div class="file-select-button btn">Choose File</div>
                <div class="file-select-name">No file chosen</div>
            </div>
            <input type="file" name="signature-input" id="signature-input" onchange="$(this).parent().find('.file-select-name').html($(this).val().split(/[\\|/]/).pop());" style="display: none;">
            </div>
            <button class="gray-btn upload-btn" data-id="signature-input" type="button">Upload</button>
          </div>
        </div>
        <div class="upload-section">
          <h5>Identity Proof <span>*</span></h5>
          <div class="upload-tnc">
            <select>
              <option>Select</option>
              <option>Aadhaar Card</option>
              <option>Votar ID</option>
              <option>Driving Licence</option>
            </select>
            <p>Upload file in JPEG, PNG and PDF under 500KB</p>
          </div>
          <div class="upload-input">
            <div class="file-upload">
              <div class="file-upload-select" onclick="$(this).parent().find('input[type=file]').click();">
                <div class="file-select-button">Choose File</div>
                <div class="file-select-name">No file chosen</div>
            </div>
            <input type="file" name="identity-input" id="identity-input" onchange="$(this).parent().find('.file-select-name').html($(this).val().split(/[\\|/]/).pop());" style="display: none;">
            </div>
            <button class="gray-btn upload-btn" data-id="identity-input" type="button">Upload</button>
          </div>
        </div>
        <div class="upload-section">
          <h5>Address Proof <span>*</span></h5>
          <div class="upload-tnc">
            <select>
              <option>Select</option>
              <option>Aadhaar Card</option>
              <option>Votar ID</option>
              <option>Driving Licence</option>
            </select>
            <p>Upload file in JPEG, PNG and PDF under 500KB</p>
          </div>
          <div class="upload-input">
            <div class="file-upload">
              <div class="file-upload-select" onclick="$(this).parent().find('input[type=file]').click();">
                <div class="file-select-button">Choose File</div>
                <div class="file-select-name">No file chosen</div>
            </div>
            <input type="file" name="address-input" id="address-input" onchange="$(this).parent().find('.file-select-name').html($(this).val().split(/[\\|/]/).pop());" style="display: none;">
            </div>
            <button class="gray-btn upload-btn" data-id="address-input" type="button">Upload</button>
          </div>
        </div>
        <div class="upload-section">
          <h5>Qualification <span>*</span></h5>
          <div class="upload-tnc">
            <select>
              <option>Select</option>
              <option>10th</option>
              <option>12th</option>
              <option>Graduation</option>
            </select>
          </div>
          <div class="upload-input">
            <div class="file-upload">
              <div class="file-upload-select" onclick="$(this).parent().find('input[type=file]').click();">
                <div class="file-select-button btn">Choose File</div>
                <div class="file-select-name">No file chosen</div>
            </div>
            <input type="file" name="qualification-input" id="qualification-input" onchange="$(this).parent().find('.file-select-name').html($(this).val().split(/[\\|/]/).pop());" style="display: none;">
            </div>
            <button class="gray-btn upload-btn" data-id="qualification-input" type="button">Upload</button>
          </div>
        </div>
        <div id="extra-field"></div>
        <a id="add-qualification">+ Add Qualification</a>

        <div class="upload-section">
          <h5>Work Experience <span>*</span></h5>
          <div class="upload-tnc">
            <p>Upload Resignation Letter</p>
            <p>File in JPEG, PNG and PDF under 500KB</p>
          </div>
          <div class="upload-input">
            <div class="file-upload">
              <div class="file-upload-select" onclick="$(this).parent().find('input[type=file]').click();">
                <div class="file-select-button">Choose File</div>
                <div class="file-select-name">No file chosen</div>
            </div>
            <input type="file" name="resignation-input" id="resignation-input" onchange="$(this).parent().find('.file-select-name').html($(this).val().split(/[\\|/]/).pop());" style="display: none;">
            </div>
            <button class="gray-btn upload-btn" data-id="resignation-input" type="button">Upload</button>
          </div>
        </div>
        <div class="upload-section">
          <h5>Work Experience <span>*</span></h5>
          <div class="upload-tnc">
            <p>Upload Experience /Relieving Letter</p>
            <p>Upload file in JPEG, PNG and PDF under 500KB</p>
          </div>
          <div class="upload-input">
            <div class="file-upload">
              <div class="file-upload-select" onclick="$(this).parent().find('input[type=file]').click();">
                <div class="file-select-button">Choose File</div>
                <div class="file-select-name">No file chosen</div>
            </div>
            <input type="file" name="experience-input" id="experience-input" onchange="$(this).parent().find('.file-select-name').html($(this).val().split(/[\\|/]/).pop());" style="display: none;">
            </div>
            <button class="gray-btn upload-btn" data-id="experience-input" type="button">Upload</button>
          </div>
        </div>
        <div class="upload-section">
          <h5>Work Experience <span>*</span></h5>
          <div class="upload-tnc">
            <p>Upload Salary Slip</p>
            <p>Upload file in JPEG, PNG and PDF under 500KB</p>
          </div>
          <div class="upload-input">
            <div class="file-upload">
              <div class="file-upload-select" onclick="$(this).parent().find('input[type=file]').click();">
                <div class="file-select-button">Choose File</div>
                <div class="file-select-name">No file chosen</div>
            </div>
            <input type="file" name="salary-input" id="salary-input" onchange="$(this).parent().find('.file-select-name').html($(this).val().split(/[\\|/]/).pop());" style="display: none;">
            </div>
            <button class="gray-btn upload-btn" data-id="salary-input" type="button">Upload</button>
          </div>
        </div>
        <div class="upload-section">
          <h5>Resume <span>*</span></h5>
          <div class="upload-tnc">
            <input type="text" placeholder="cv_2_jun_2022.pdf" disabled />
          </div>
          <div class="upload-input">
            <button class="view-btn gray-btn ir-view">View</button><div class="file-upload">
              <div class="file-upload-select" onclick="$(this).parent().find('input[type=file]').click();">
                <div class="file-select-button">Choose File</div>
                <div class="file-select-name">No file chosen</div>
            </div>
            <input type="file" name="cv-input" id="cv-input" onchange="$(this).parent().find('.file-select-name').html($(this).val().split(/[\\|/]/).pop());" style="display: none;">
            </div>
            <button class="gray-btn upload-btn" data-id="cv-input" type="button">Upload</button>
          </div>
        </div>
        <div class="upload-section">
          <h5>Aadhaar Details <span>*</span></h5>
          <div class="upload-tnc">
            <input type="text" placeholder="aur_aadhaar.pdf" disabled />
          </div>
          <div class="upload-input">
            <button class="view-btn gray-btn ir-view">View</button><div class="file-upload">
              <div class="file-upload-select" onclick="$(this).parent().find('input[type=file]').click();">
                <div class="file-select-button">Choose File</div>
                <div class="file-select-name">No file chosen</div>
            </div>
            <input type="file" name="aadhaar-input" id="aadhaar-input" onchange="$(this).parent().find('.file-select-name').html($(this).val().split(/[\\|/]/).pop());" style="display: none;">
            </div>
            <button class="gray-btn upload-btn" data-id="aadhaar-input" type="button">Upload</button>
          </div>
        </div>
        <div class="upload-section">
          <h5>Any other document</h5>
          <div class="upload-tnc">
            <p>Upload Any other document</p>
					  <p>Upload file in PDF, JPEG, PNG and JPG under 1MB</p>
          </div>
          <div class="upload-input">
            <div class="file-upload">
              <div class="file-upload-select" onclick="$(this).parent().find('input[type=file]').click();">
                <div class="file-select-button">Choose File</div>
                <div class="file-select-name">No file chosen</div>
            </div>
            <input type="file" name="any-input" id="any-input" onchange="$(this).parent().find('.file-select-name').html($(this).val().split(/[\\|/]/).pop());" style="display: none;">
            </div>
            <button class="gray-btn upload-btn" data-id="any-input" type="button">Upload</button>
          </div>
        </div>
        <div class="form-btn wtnc">
          <div class="acc-tnc">
            <input type="checkbox" id="tnc" /><label for="tnc"
              >I have checked all date and Uploaded documents</label
            >
          </div>
          <div class="btns">
            <button class="btn">Save</button>
            <button id="submit" class="btn blue-btn" type="submit" disabled>Submit</button>
          </div>
        </div>
                </form>
              </div>

             
    </div>
    </div>
    </div>
    
 <input type="hidden" id="accesskey" value="${participant.accessKey}">
    <script>
      $(document).ready(function () {
      
        $('#tabs').scrollTabs();
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


            var quali_count = 1;
            function extra_quali(){
                var extra_quali_field = `
                <div class="upload-section">
                    <h5>Qualification ${quali_count}<span>*</span></h5>
                    <div class="upload-tnc">
                        <select>
                        <option>Select</option>
                        <option>10th</option>
                        <option>12th</option>
                        <option>Graduation</option>
                        </select>
                    </div>
                    <div class="upload-input">
                        <div class="file-upload">
                          <div class="file-upload-select" onclick="$(this).parent().find('input[type=file]').click();">
                    <div class="file-select-button">Choose File</div>
                    <div class="file-select-name">No file chosen</div>
                </div>
                <input type="file" name="quali${quali_count}-input" id="quali${quali_count}-input" onchange="$(this).parent().find('.file-select-name').html($(this).val().split(/[\\|/]/).pop());" style="display: none;">
                        </div>
                        <button class="gray-btn upload-btn" data-id="quali${quali_count}-input" type="button">Upload</button>
                    </div>
                    </div>
                `
                $('#extra-field').append(extra_quali_field);
            }
                $('#add-qualification').on('click', function(){
                    quali_count++;
                    console.log(quali_count)
                    extra_quali()
                });


        $('.form').on('click', '.upload-btn', function(){
          var getInputUploadID = $(this).data('id');
            $(this).parent().parent().find('.upload-tnc .error-tnc').remove();
            $(this).parent().parent().find('.upload-tnc .success-tnc').remove();
            $(this).parent().find('.view-btn').remove();
          if($('#'+getInputUploadID).val() !== ''){
            $(this).parent().parent().removeClass('error').addClass('success');
            $(this).parent().parent().find('.upload-tnc').append('<div class="success-tnc"><img src="./img/check-icn.png" /> Successfully uploaded</div>');
            $(this).parent().prepend('<button class="view-btn gray-btn" id="view-'+getInputUploadID+'">View</button>');
            $(this).parent().find('.file-select-name').text('No file chosen');
          } else{
            $(this).parent().parent().removeClass('success').addClass('error');
            $(this).parent().parent().find('.upload-tnc').append('<div class="error-tnc"><img src="./img/cross-icn.png" /> Please re-upload file</div>');
            $(this).parent().find('.view-btn').remove();
          }
        });

        $('#fsdm-feedback').click(function(){
          $('.blk-bg, .feedback-popup').show();
        });
        $('.cancel-popup').click(function(){
          $('.blk-bg, .feedback-popup').hide();
        });
        $('.submit-feedback').click(function(){
          $('.blk-bg, .feedback-popup').hide();
          var ftv = $('#feedback-text').val();
          $('.fsdm-feedback-content').text(ftv);
          $('#fsdm-feedback').remove();
          $('.fsdm-feedback').append(`
            <div class="feedback-btns">
              <button class="outline-btn">Edit Feedback</button>
              <button class="blue-btn">Approve Feedback</button>
            </div>
          `);
        });
        });
    </script>
  </body>
</html>
<%
 }catch(Exception e)
    {
    	 System.out.println("Errror....."+e);
    	  response.sendRedirect("login");
    }%>