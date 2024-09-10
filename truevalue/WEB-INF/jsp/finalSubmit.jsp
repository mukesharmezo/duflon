<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import = "java.util.ResourceBundle" %>

<%
try
    {
	ResourceBundle resource = ResourceBundle.getBundle("application");
String baseServer = resource.getString("client.url");
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
<link rel="icon" type="image/x-icon" href="<%=baseServer%>img/iRecruit-favicon.ico"/>
<title>iRecruit</title>
<link rel="stylesheet" type="text/css" href="./css/upload-documents.css" />
<link rel="stylesheet" type="text/css" href="./css/common.css" />
<link rel="stylesheet" type="text/css" href="./css/profile.css" />
<link rel="stylesheet" href="./css/scrolltabs.css">
      // <link rel="stylesheet" type="text/css" href="./css/sweetalert.css"/>
     //  <script type="text/javascript" src="./js/sweetalert.min.js"></script>
<style>

.gray-btn{margin: 0px 10px 0px 0px;}
.view-btn{width: 41px;text-align: center;}
#cancelFeedback {border: 1px solid #2D3393 !important;color: #2D3393 !important;display: inline-block !important;background-color: white !important;}
.upload-input {background: none;padding: 0;border: none;display: flex;align-items: center;justify-content: right !important;width: 390px !important}
input#tnc {margin: 0px 15px 81px 0px}
.viewFeedback {text-align: center;}
#fsdmFeedback2{background: #F7F7F7;border: 1px solid #D0D0D0;border-radius: 7px;color: #4D4D4D;padding: 11px 15px;font-size: 15px;font-family: Arial !important;line-height: 18px;outline: none; box-sizing: border-box;}
#docType{background: #F7F7F7;border: 1px solid #D0D0D0;border-radius: 7px;color: #4D4D4D;padding: 11px 15px;font-size: 15px;font-family: Arial !important;line-height: 18px;outline: none;box-sizing: border-box;}
#reason{background: #F7F7F7; border: 1px solid #D0D0D0;border-radius: 7px;color: #4D4D4D;padding: 11px 15px;font-size: 15px;font-family: Arial !important;line-height: 18px;outline: none;box-sizing: border-box;}
.sa-button-container .cancel{border: 1px solid #2D3393 !important;color: #2D3393 !important;background-color: white !important;}
#feedback_text{background: #F7F7F7;
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

<script src="./js/jquery-3.4.1.min.js" type="text/javascript"></script>


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
				<%--		<form action="upload" method="post" class="form">
					
			        </form> --%>
			        <div class="viewFeedback">
			        	<p>${participant.fsdmFeedback}</p>
			        	<input type="button" class="blue-btn" onclick="hideFeedbckData()" value="&nbsp;&nbsp;Ok&nbsp;&nbsp; "/>
			        </div>
			        <div class="fsdmF" style="text-align: center !important;">
			        	<h2>FSDM Remarks</h2>
			        	<div class="form-block" style="display: contents !important;" id="fsdmFeedback2_div">
					 <select name="fsdmFeedback2" id = "fsdmFeedback2"  onclick="showDocType()">
                     <option value="" >Select</option>
                      <c:forEach items="${feedbackList}" var="list">
                        <option value="${list}" <c:if test="${participant.fsdmFeedback eq list}"> selected</c:if>>${list}</option>
                        </c:forEach>
						<option value="Incorrect details filled in the application form">Incorrect details filled in the application form</option>
						<option value="Submitting more than one application form">Submitting more than one application form</option>
						<option value="Others, pls specify">Others, pls specify</option>
                         </select>
                         </div>						 	 
						 	<div class="form-block" style="display: contents !important;"  id="docType_div">
							<select name="docType" id="docType" onchange="showReason()">
								<option value="">Select</option>
								<option value="Photograph">Photograph</option>
								<option value="Signature">Signature</option>
								<option value="IdProof">Id Proof</option>
								<option value="Address">Address Proof</option>
								<option value="Qualification">Qualification</option>
								<option value="Work Experience">Work Experience</option>
							</select>

						</div>						
						<div class="form-block" style="display: contents !important;" id="reason_div">
							<select name="reason" id="reason">
								<option value="">Select</option>
								<option value="Not Available">Not available</option>
								<option value="Not clearly visible">Not clearly visible</option>
								<option value="Wrong details provided">Wrong details provided</option>
							</select>

						</div>
						    <div class="feedback" style="margin-top: 30px !important;">
						<textarea id="feedback_text" placeholder="Comments" maxlength="150">${participant.fsdmRejectionComment}</textarea>
						</div>
                         <div class="btns" style="margin-top: 30px !important;">
			<!-- 	<div class="cancel-btn cancel-popup"  style="width: 62px !important; text-align: center;">Cancel</div> -->
			<%if(role.equalsIgnoreCase("FS")) { %>
				<input type ="button" class="blue-btn" onclick="hideDropdown()" id="cancelFeedback" value="Cancel"/>
				<input type="button" class="blue-btn submit-feedback" onclick="saveFeedbck()" id="save_feedback" value="Submit"/>
				
			<%}if(role.equalsIgnoreCase("DL")) { %>
				<input type ="button" class="blue-btn" onclick="viewFeedbackClose()()" id="cancelFeedback" value="Cancel"/>
				<%}%>
			</div>
			        </div>			
		
			<%if(role.equalsIgnoreCase("DL")) { %>
			
						
			<c:if test="${participant.documents_status != 'final' && participant.fsdmApprovalStatus != '2' && participant.status != 'H'}">
                      
			<c:if test="${ ((participant.fsdmCounter < 10 ||  empty participant.fsdmCounter) )
			 }">
				<div id="div_dealer">
			<div class="form-btn wtnc" style="border-top:none !important;" >
				<input type="checkbox" id="tnc"/>

					<div class="acc-tnc">
					<!-- <p class="tnc"></p><input type="checkbox" id="tnc" />By submitting, I certify that the candidate details provided here is true and complete to the best of my knowledge and belief.
					I further declare that I have verified all the information and documents submitted by the candidate, in this connection.
					I promise to extend total cooperation and furnish relevant documents if required.
				</div> -->

                                       <!-- 				
					<input type="checkbox" id="tnc"/> -->
					
						
					<h3></h3>
					<p><label>
					    By submitting, I certify that the candidate details provided here is true and complete to the best of my knowledge and belief.<br><br>
						I further declare that I have verified all the information and documents submitted by the candidate, in this connection.<br><br>
						I promise to extend total cooperation and furnish relevant documents if required.
				</label></p>
				</div>
				<!-- <div class="acc-tnc">
					<input type="checkbox" id="tnc" /><label for="tnc">	By submitting, I certify that the candidate details provided here is true and complete to the best of my knowledge and belief.</label>
					<br><br><label for="tnc">I further declare that I have verified all the information and documents submitted by the candidate, in this connection.</label>
					<br><br><label for="tnc">I promise to extend total cooperation and furnish relevant documents if required.</label><br>
				</div> -->				
			</div>
			<div class="btns">
				<c:if test="${participant.fsdmApprovalStatus == '1'}">
				<button class="btn" onclick="viewFeedback()">View Remark</button>
				</c:if>
					<!--<input type="button" class="btn" onclick="saveDacoment('save')" value="Save"> -->
					<input  type="button" id="submit" class="btn blue-btn" onclick="saveDacoment('final')"  disabled value="Submit" />
				</div>
			</c:if>	
        </c:if>			
			<c:if test="${participant.fsdmApprovalStatus == '3'}">
				<div class="msgAfterSubmit" style="text-align: center;font-weight: 900;">
					<p id="msg">FSDM approval is pending. </p> 
					<!--<p>Candidate's job application has been sent for FSDM approval</p> -->
				</div>
			</c:if>
			
			
						
						<c:if test="${participant.documents_status == 'final' && participant.finalDesignation eq 'STR' && participant.prarambhStatus eq '2' }">
			<div class="msgAfterSubmit" style="text-align: center;font-weight: 900;">
						<p>Please change the sales designation of STR.</p>
						</div>
						</c:if>
						
			<c:if test="${participant.documents_status == 'final' && participant.finalDesignation eq 'STR' && participant.prarambhStatus eq '1'}">
			<div class="msgAfterSubmit" style="text-align: center;font-weight: 900;">
						<p>Induction Course completion status is awaited.</p>
						</div>
						</c:if>
			</div>
			<%} %>
		
       
     <%if(role.equalsIgnoreCase("FS")){%>
		<div class="fsdm-feedback"  id="fs-div" >		
			<div class="fsdm-feedback-content"></div>
			<div class="feedback-btns">
			 <%if(role.equalsIgnoreCase("FS") && session.getAttribute("fsdm_approvel") != null) { %>
			<c:if test="${participant.fsdmApprovalStatus != '2'  && participant.fsdmApprovalStatus == '3'}">
				<span type="button" class="btn blue-btn" onclick="approve()" style="font-size:14px; background-color: #ffffff !important;color: #009F06 !important; border: 1px solid #009F06 !important;">Approve</span>
			</c:if>
			 <%}%>
			<c:if test="${participant.fsdmFeedback != null && participant.fsdmApprovalStatus != '2'}">
		<button class="outline-btn" id="fsdm-feedback" onclick="showDropdown()" style="font-size:14px; background-color: #ffffff !important;color: #FF0000 !important; border: 1px solid #FF0000 !important;">Edit Remarks</button>
		</c:if>
		 <%if(role.equalsIgnoreCase("FS") && session.getAttribute("fsdm_approvel") != null) { %>
		<c:if test="${participant.fsdmFeedback == null && participant.fsdmApprovalStatus != '2'}">
				<button class="btn red-btn" id="fsdm-feedback" onclick="showDropdown()" style="font-size:14px; background-color: #ffffff !important;color: #FF0000 !important; border: 1px solid #FF0000 !important;">Reject</button>
				
			</div>
		</div>
		</c:if>
<%}} %>
	
	<%if(role.equalsIgnoreCase("FS")) { %>
		<div class="feedback-popup">
			<h3>FSDM Remarks</h3>
			<p id="feedback-text">${participant.fsdmFeedback}</p>
			<div class="btns">
				<div class="cancel-btn"  style="width: 62px !important; text-align: center;">Cancel</div>
			</div>

		</div>
		<div class="key-popup">
			<p>Are you sure you want to approve the candidate's application ?</p>
			<h2 id="h2" class="testClass"></h2>
			<div class="form-button">
				<button class="cancel-btn outline-btn" onclick="no()" >No</button>
				<input type="button" class="submit-btn" onclick="yes()" id="btn_approve" value="Yes" />
				
				<input type="hidden" value="" id="reAccesskey">
			</div>
		</div>
		
	
	<%} 
	 if(role.equalsIgnoreCase("DL")) { %>
	<div class="feedback-popup">
			<h3>FSDM's Feedback</h3>
			<textarea id="feedback-text">${participant.fsdmFeedback}</textarea>
			<div class="btns">
				<div class="cancel-btn cancel-popup"  style="width: 62px !important; text-align: center;" onclick="viewFeedbackClose()">Close</div>				
			</div>
		</div>
	<%} %>
	
	<div class="blk-bg" style="z-index: 6 !important"></div>
	<input type="hidden" id="accesskey" value="${participant.accessKey}">
	<input type="hidden" id="fsdmFeedback_fs" value="${participant.fsdmFeedback}">
	<input type="hidden" id="fsdmRejectionType_fs" value="${participant.fsdmRejectionType}">
	<input type="hidden" id="fsdmRejectionReason_fs" value="${participant.fsdmRejectionReason}">
	


</div>
	</div>
		</div>
		</div>
<script src="./js/jquery.scrolltabs.js"></script>
	<script>
      $(document).ready(function () {
               document.getElementsByClassName('viewFeedback')[0].style.display = 'none';
                        document.getElementsByClassName('fsdmF')[0].style.display = 'none';
                        document.getElementById('docType')[0].style.display = 'none';
                        document.getElementById('reason')[0].style.display = 'none';
                
		  <% if(role.equalsIgnoreCase("DL")) { %>
                     var ab = $('textarea#message').val();
		    if( ab == ''){
				//$("#feedback_text").hide();
                               var link = document.getElementById('feedback_text');
                               link.style.display = 'none'; //or
                               link.style.visibility = 'hidden';
			}
			 if(ab  != ""){
			 $('#feedback_text').prop('disabled', true);	
			}
		  <%}%>
		  $('#tabs').scrollTabs();
		
		    var profile = document.getElementById("profile");
		    var final_submit = document.getElementById("final_submit");
		
		   profile.className -= 'tab-btn tab_selected scroll_tab_first';
                   final_submit.className += 'tab-btn tab_selected scroll_tab_first';
		
                        
    	                //$('.viewFeedback').hide();
    	                //$('.fsdmF').hide();
		 	//$('#docType').hide();
			//$('#reason').hide();

    	  <%if(role.equalsIgnoreCase("FS")) { %>
		  $('#save_feedback').prop('disabled', false);
		  $('#btn_approve').prop('disabled', false);
	
		  /* $('#fsdmFeedback2').hide();
		  $('.btns').hide(); */
		   
    	  <%}%>
      
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

       
        
        
        });
      
      function showDropdown(){
		  
		  var fsdmFeedback_fs = $("#fsdmFeedback_fs").val();
		  var fsdmRejectionType_fs = $("#fsdmRejectionType_fs").val();
		  var fsdmRejectionReason_fs = $("#fsdmRejectionReason_fs").val();
		
    	  $('.fsdmF').show();
		   $('#fs-div').hide();
		   if(fsdmFeedback_fs != ""){
			    
			   $("#fsdmFeedback2_div").show();
			   $("#fsdmFeedback2").val(fsdmFeedback_fs);
		   }
		   if(fsdmRejectionType_fs != ""){
			   $("#docType").show();
			   $("#docType").val(fsdmRejectionType_fs);
		   }
		   if(fsdmRejectionReason_fs != ""){
			   $("#reason").show();
			   $("#reason").val(fsdmRejectionReason_fs);
		   }
      }
      function hideDropdown(){
    	  $('.fsdmF').hide();
		  $('#fs-div').show();
      }
      
      function viewFeedback(){
    	 // $('.viewFeedback').show();
    	  // $('.blk-bg, .feedback-popup').show(); 
		  $("#div_dealer").hide();
		   var fsdmFeedback_fs = $("#fsdmFeedback_fs").val();
		  var fsdmRejectionType_fs = $("#fsdmRejectionType_fs").val();
		  var fsdmRejectionReason_fs = $("#fsdmRejectionReason_fs").val();
		
    	  $('.fsdmF').show();
		   $('#fs-div').hide();
		   if(fsdmFeedback_fs != ""){
			    
			   $("#fsdmFeedback2_div").show();
			   $("#fsdmFeedback2").val(fsdmFeedback_fs);
		   }
		   if(fsdmRejectionType_fs != ""){
			   $("#docType").show();
			   $("#docType").val(fsdmRejectionType_fs);
		   }
		   if(fsdmRejectionReason_fs != ""){
			   $("#reason").show();
			   $("#reason").val(fsdmRejectionReason_fs);
		   }
		   $( "#fsdmFeedback2" ).prop( "disabled", true );
		   $( "#docType" ).prop( "disabled", true );
		   $( "#reason" ).prop( "disabled", true );
      }
	  function viewFeedbackClose(){
    	 // $('.viewFeedback').hide();
    	 //  $('.blk-bg, .feedback-popup').hide(); 
		   $("#div_dealer").show();
		    $("#fsdmF").hide();
			  $('.fsdmF').hide();
      }
	  
      function hideFeedbckData(){
    	  $('.viewFeedback').hide();
      }
	  function showDocType(){
			var docData = document.querySelector('#fsdmFeedback2').value;
			if(docData.localeCompare('Documents Incomplete')==0){	
			$('#docType').show();
			}else{
				$('#docType').val("");
				$('#reason').val("");
				$('#docType').hide();
				$('#reason').hide();
			}
		}
		function showReason(){
			$('#reason').show();
		}
      function approve(){
    	 
    	  $('.blk-bg, .key-popup').show(); 
      }
      
      function no(){
    	  $('.blk-bg, .key-popup').hide();   
      }
      
      function yes(){  
    	 // var accesskey =  $("#accesskey").val();
		  var accesskey = document.getElementById('accesskey').value;
		 //$('#btn_approve').prop('disabled', true);
               document.getElementById("btn_approve").disabled = true;
   	     $('#btn_approve').val('Please wait');
			 $.ajax({
			  type: "get",
			  url:  "approvel",
			  data: "accesskey="+accesskey,
			  success: function(data){
				  $('.key-popup').hide();
				   //$('#btn_approve').prop('disabled', false);
                                      document.getElementById("btn_approve").disabled = false;
				    if(data =="success"){
				   swal({   				   
					  title: "You have approved the application of the candidate.",     
					  showCancelButton: false,
					  confirmButtonColor: "#2d3393",   
					  confirmButtonText: "OK",  				  
					  closeOnConfirm: false },
					  function(isConfirm){
					  $('.blk-bg, .key-popup').hide(); 
				     //  window.location.reload();
					   window.location.href="viewParticapant";
					}); 
					 }else{
				  swal({   				   
					  title: data,     
					  showCancelButton: false,
					  confirmButtonColor: "#2d3393",   
					  confirmButtonText: "OK",  				  
					  closeOnConfirm: false },
					  function(isConfirm){
					  $('.blk-bg, .key-popup').hide(); 
					   window.location.href="viewParticapant";
					});   
			  }
				   
			  },
			  error: function(errorThrown){
			  }
		  });  
			
		  
    	
    	    
      }
      
      function saveFeedbck(){
		 
    	var feedback =  $("#fsdmFeedback2").val();
		var docType =  $("#docType").val();
		var reason =  $("#reason").val();
    	var accesskey =  $("#accesskey").val();
		var feedback_text = $("#feedback_text").val();
		if(feedback == ""){
			showMSG("Please select feedback option ");
							
           return false ;					
			
		}
		if(feedback == "Others, pls specify" &&  feedback_text ==""){
		showMSG("Please leave a comment");
							
           return false ;	
			
		}
		$('#save_feedback').prop('disabled', true);
   	    $('#save_feedback').val('Please wait');
		  $('.blk-bg, .feedback-popup').hide();
		  swal({   
					  title: "Are you sure you want to reject the candidate's application.",     
					  showCancelButton: true,
					  confirmButtonColor: "#2d3393",   
					  confirmButtonText: "OK", 
                      cancelButtonText: "Cancel",					  
					  closeOnConfirm: false },
					  function(isConfirm){
					  if(isConfirm){
						 var fd = new FormData();
						    
				          fd.append('accesskey',accesskey);
				          fd.append('feedback',feedback);
				          fd.append('fsdmRejectionType',docType);
				          fd.append('fsdmRejectionReason',reason); 
                          fd.append('fsdmRejectionComment',feedback_text);   
						  
    	  $.ajax({
			  type: "post",
			  url:  "feedback",
			  enctype: 'multipart/form-data',
				data:fd,
				processData: false,
		        contentType: false,
		        cache: false,
		        timeout: 600000,
			  success: function(data){
			$('#btndDate').prop('disabled', false);
			 $('#btndDate').val('OK');
				 swal({   
					  title: "You have rejected candidate's application.",     
					  showCancelButton: false,
					  confirmButtonColor: "#2d3393",   
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
      
      function saveDacoment(status){
    		
    		 //var accessKey = $('#accesskey').val(); 
                        var accessKey = document.getElementById('accesskey').value;
                                console.log(accessKey );
						swal({   
				 					// title: "Are you sure submit, you will not able to change.",
				 					//title: "Candidate Registration Completed. All details of the candidate are successfully filled.",     
                                                                        title:"Are you sure you want to submit the details?",
				 					showCancelButton: true,
				 					confirmButtonColor: "#2d3393",   
				 					confirmButtonText: "OK",   
				 					closeOnConfirm: false },
				 					function(isConfirm){
				 						if(isConfirm){
                                                                               document.getElementById("submit").disabled = true;
				 						//$('#submit').prop('disabled', true);
 	                                   // $('#submit').val('Please wait');
                                            $('.confirm').prop('disabled', true);			 
    		  $.ajax({
				         url: 'savedocuments',
				         type:'post',
				         data:'accesskey='+accessKey+'&status='+status,
				         success:function(res){
                                                document.getElementById("submit").disabled = false;	
						 //$('#submit').prop('disabled', false);
 	                                       // $('#submit').val('OK');
						 $('.confirm').prop('disabled', false)
							if(res =="success"){
							  showMSGSave("The candidate's application has been successfully submitted.");   									
							 }
							 
							 //if(res == "1" || res == "2" || res == '3'){
							  //showMSGSave('Please fill in the mandatory fields and upload mandatory documents.')        									
							 //}
							  if(res == "1" ){
								 showMSGSave('Please fill in the mandatory fields and upload mandatory documents.','1',accessKey)   
							 }
							 
							 if( res == "2" ){
								 showMSGSave('Please fill in the mandatory fields and upload mandatory documents.','2',accessKey)   
							  }
							 if( res == '3'){
								 showMSGSave('Please fill in the mandatory fields and upload mandatory documents.','3',accessKey)   
							  }
							 
							  if(res != "1" && res != "2" && res != '3' && res !="success"){
								  showMSGSave(res)        									
							}
				    	  },
				          error:function(ress){
							window.close();
				    	  }
			  			}); 
						}else{
				 							return false;
				 						}
				 					});	 
    	}
      function showMSGSave(msg){
		  
		  swal({   
				 					//title: "The candidate's application was successfully submitted for FSDM approval.",     
                                     title:msg,
				 					showCancelButton: false,
				 					confirmButtonColor: "#2d3393",   
				 					confirmButtonText: "OK",   
				 					closeOnConfirm: false },
				 					function(isConfirm){
				 						if(isConfirm){
				 						location.reload();
										}
									});	
	  }	

  function showMSGSave(msg,res,accessKey){	  
          swal({   
               title:msg,
				showCancelButton: false,
				confirmButtonColor: "#2d3393",   
				confirmButtonText: "OK",   
				closeOnConfirm: false },
				function(isConfirm){
					if(isConfirm){
						 if( res == "1" )
						 {
						  window.location.href="getPersonalDetails?accesskey="+accessKey;
						 }
						 
						 else if( res == "2" )
						 {						
							  window.location.href="getempdetails?accesskey="+accessKey;
					         }
						else  if( res == '3')
						 {
							 window.location.href="uploadDocoment?accesskey="+accessKey;
						 }else {
                                                  location.reload();
                                                }
					}
				});	
}		
	  
									
      function showView(){
		 	if($('#viewsign').is(':visible') && old_mspin=="1" ){
            }				  
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
