$(document).ready(function () {
	
    $("#submitbtn").click(function () {

	   
	
    	$('#testForm').validate({
  		  rules: {
  			location: "required",
  			
  			workedWithMSILBefore:"required",
  			title:"required",
  			address:"required",
  			mspin:"required",
			oldMspin:"required",
			DL:"required",
  			city:"required",
  			state:"required",
  			idProof:"required",
  			birthDate:"required",
  			licenseNo:"required",
  			validityOfLicence:"required",
  			highestQualification:"required",
  			twoWheeler: "required",
  			fourWheeler: "required",
  			twoWheelerr: "required",
  			fourWheelerr: "required",
  			primaryLanguage:"required",
  			secondaryLanguage:"required",
  			gender:"required",
  			ownershipOfTwoWheeler:"required",
  			knowDriving:"required",
  			mdsCertified:"required",
  			cname:"required",
  			contactNo:"required",
  			martialStatus:"required",
  			memberName:"required",
  			relationship:"required",
  			workExperiences:"required",
  			autoIndustryExperience:"required",
  			nonAutoIndustryExperience:"required",
  			source:"required",
  			total:"required",
  			
  			previousDesignation:"required",
  			dealerLocation:"required",
  			
  			expInMths:"required",
  		    email: {
  		      required: true,
  		      email: true
  		    },
  		  photograph: {
	  		      required: true,
	  		      filesize : 50000,
	  			  extension: "png|jpeg|gif",
	  		     },
    	
		    pin: {
		          required: true,
			      number: true
			    },
			    
			    adharNumber: {
			          required: true,
				      number: true,
					  min: 111111111119,
				      minlength: 12,
				      maxlength: 12,
					  validateValue : true

				    }, 
		    mobile: {
		          required: true,
			      number: true,
				  min: 10000,
			      minlength: 10,
			      maxlength: 10,
				  validateValue : true
			    },
		    experienceInMonths: {
					          required: true,
						      number: true,
						 
						    },
						    
						    
						    
			firstName: {
						          required: true,
							      alpha: true,
							 
							    },
			middleName: {
							          required: true,
								      alpha: true,
								 
								    },
			lastName: {
								          required: true,
									      alpha: true
									 
									    },
		   employeeCode: {
								          required: true,
								          loginRegex: true
									 
									    },
		  workArea: {
									          required: true,
									          loginRegexChar: true
										 
										    },
		pfNumber: {
										          required: true,
										          loginRegex: true
											 
											    },
		companyName: {
											          required: true,
											          loginRegexChar: true
												 
												    }
										    
					    
  		  },
  		  messages: {
  			location: "<br/>Select location",
  			workedWithMSILBefore: "<br/>Please select option",
  			title: "<br/>Please select title",
  			address: "<br/>Please enter address",
  			mspin: "<br/>Please enter your MSPIN",
			oldMspin:"<br/>Please enter MSPIN",
  			city: "<br/>Please select city",
  			state: "<br/>Please select state",
  			idProof: "<br/>Please select Id proof",
  			birthDate: "<br/>Select your date of birth",
  			licenseNo: "<br/>Please enter your licenseNo",
  			validityOfLicence: "<br/>Please Fill the  Validity Of Licence",
  			highestQualification: "<br/>Please select highest qualification",
  			twoWheeler: "<br/>Please select option",
  			fourWheeler: "<br/>Please select option",
  			twoWheelerr: "<br/>Please elect option",
  			fourWheelerr: "<br/>Please select option",
  			primaryLanguage: "<br/>Please select primary language",
  			secondaryLanguage: "<br/>Please select secondary language",
  			gender: "<br/>Please select gender",
  			ownershipOfTwoWheeler: "<br/>Please select option ",
  			knowDriving: "<br/>Please select option",
  			mdsCertified: "<br/>Please select MDS certified option",
  			cname: "<br/>Please enter your name",
  			contactNo: "<br/>Please enter your contactNumber",
  			martialStatus: "<br/>Please  select the marital status",
  			memberName: "<br/>Please enter family memberName",
  			relationship: "<br/>Please  select the relationship",
			DL: "<br/>Please select option",
  			workExperience: "<span>Please Select the Work Experience</span>",
  			total: "<br/>Please  enter your total experience",
  			autoIndustryExperience: "<br/>Please  enter auto industry experience",
  			nonAutoIndustryExperience: "<br/>Please  enter non auto industry experience",
  			source: "<br/>Please  select your source",
  			companyName: "<br/>Please  Enter the Company Name",
  			previousDesignation: "<br/>Please  enter your Designation",
  			dealerLocation: "<br/>Please select the Dealer_Location",
  			
  			expInMths: "<br/>Please enter your expInMths",
  			 email: {
  	  		      required: "<br/>Enter your email address",
  	  		      email: "<br/>Your email address must be in the format of name@domain.com"
  	  		    },
  	  		photograph: {
  		    required: "<br/>Please upload your photograph",
  		    filesize : "<br/>Please upload file size in 500KB", 
	  		extension: "<br/>Please upload file format in txt , pdf and word only"
  		    },
  		    msilExp: {
  			  required: "<br/>Please enter MSIL experience"
		    },
		    mobile: {
	  			  required: "<br/>Please enter your mobile number",
			      number: "<br/>Please Enter your mobile number ",
				  min: "<br/>Please enter correct mobile number",
			      minlength: "<br/>You must enter least 10 digit for mobile number",
				  validateValue : "<br/>Don't enter repeating number"
			    },
			    pin: {
		  			  required: "<br/>Enter pin code",
				      number: "<br/>Please enter pin number",
				      minlength: "<br/>Should be 6 digit",
				      maxlength: "<br/>Should be 6 digit"
				    },
				    adharNumber: {
			  			  required: "<br/>Please enter aadhaar number",
							min: "<br/>Please enter correct aadhar number",
							validateValue : "<br/>Don't enter repeating number"
					    },
			        experienceInMonths: {
				  			  required: "<br/>Please Enter Numeric Value Only",
						      number: "<br/>Please Enter your Months of Experience as a numerical value"
						    },
					firstName: {
					  			  required: "<br/>Please enter your name",
					  			alpha: "<br/>Please enter your name as in Alphabates"
							    },
					middleName: {
						  			  required: "<br/>Please Enter Alphabates Only",
						  			alpha: "<br/>Please Enter your MiddleName as in Alphabates"
								    },
					lastName: {
							  			required: "<br/>Please Enter Alphabates Only",
							  			alpha: "<br/>Please Enter your LastName as in Alphabates"
									    },
					employeeCode: {
								  			required: "<br/>Please enter your employeeCode",
								  			loginRegex: "<br/>Please Enter your employeeCode as in AlphaNumeric"
										    },
					workArea: {
								  			required: "<br/>Please enyter your workArea",
								  			loginRegexChar: "<br/>Please Enter your Work_Area as in AlphaNumeric or Character"
										    },
				pfNumber: {
									  			required: "<br/>Please Enter AlphaNumeric Only",
									  			loginRegex: "<br/>Please Enter your Pf_Number as in AlphaNumeric"
											    },
				companyName: {
										  			required: "<br/>Please enter your companyName",
										  			loginRegexChar: "<br/>Please Enter your company name as in AlphaNumeric or Character"
												    }
  		  }
  		});
    	
    	
    	
    	$.validator.addMethod("alpha", function(value, element) {
    	    return this.optional(element) || value == value.match(/^[a-zA-Z\s]+$/);
    	});

		$.validator.addMethod("validateValue", function(value, element) {
			var flag = false;
   			var temp = value.charAt(0);
    		for(i=1; i<value.length; i++){
        		if(value.charAt(i) != temp){
            		flag = true;
            		return flag;
        		}
        		temp=value.charAt(i);
    		}
		});
    	
    	
    	var regx = /^[A-Za-z0-9 _.-]+$/;
    	$.validator.addMethod("loginRegexChar", function(value, element) {
            return this.optional(element) || value == value.match(regx);
        });
    	
    	
    	var alNumRegex = /^[\w.]+$/i;
    	$.validator.addMethod("loginRegex", function(value, element) {
            return this.optional(element) || value == value.match(alNumRegex);
        });
		
		var files = $('#phtograph-input')[0].files[0];
    	var files2 = $('#resume-input')[0].files[0];
		if($("#testForm").valid()){
    	if(files ==  undefined){
  		 document.getElementById("upload-section-photo").className += ' error'
  	       return false;
  	     }
    	if(files2 ==  undefined){
     		 document.getElementById("divrmg").className += ' error'
     	       return false;
     	     }
		}
		
		var old_mspin = $("#old_mspin").val();
		var workedWithMSILBefore = $("#msilExp").val();
		 
		
		///
		//if(workedWithMSILBefore == "Yes"){
	     // if(checkMPIN() ==1){
			//  return false;
		 // }
		//}
		//
		
		
		if (!$("#testForm").valid()) {
			
			if( showFiled() == 1){
		   return false;
	   }
		}
		
		if ($("#testForm").valid()) {
			if( showFiled() == 1){
		   return false;
	   }	
		}
		
    	//save();
    	
    });
    function save(){
		document.testForm.action="/reg";
		document.testForm.method="post";
		document.testForm.submit();
	}
	
	
    
    $("#mobile").keypress(function (e) {
        if (String.fromCharCode(e.keyCode).match(/[^0-9]/g)) return false;
    });
    
    $("#alternateContactNumber").keypress(function (e) {
        if (String.fromCharCode(e.keyCode).match(/[^0-9]/g)) return false;
    });
    

	
	
	/*files uploaded js registration uploaded jquery*/
	 
	/* $('.upload-btn').on('click', function(){
         var getInputUploadID = $(this).data('id');
           $(this).parent().parent().find('.upload-tnc .error-tnc').remove();
           $(this).parent().parent().find('.upload-tnc .success-tnc').remove();
           $(this).parent().find('.view-btn').remove();
         if($('#'+getInputUploadID).val() !== ''){
           $(this).parent().parent().removeClass('error').addClass('success');
           $(this).parent().parent().find('.upload-tnc').append('<div class="success-tnc"><img src="./img/check-icn.png" /> Successfully uploaded</div>');
           $(this).parent().prepend('<a href ="C:\ParticipantUploadedFiles"><button class="view-btn gray-btn" type ="button" id="view-'+getInputUploadID+'">View File</button></a>')
         } else{
           $(this).parent().parent().removeClass('success').addClass('error');
           $(this).parent().parent().find('.upload-tnc').append('<div class="error-tnc"><img src="./img/cross-icn.png" /> Please re-upload file</div>');
           $(this).parent().find('.view-btn').remove();
         }
       });*/

});


function checkMPIN(){
	
	 var mspin  =$("#mspin").val();
    	if(mspin=="" ){
    		 $('#div_msg').text('');
    		 $('#div_msg').append('Please enter  MSPIN');
    		 $('#div_msg').show(); 
    	    return 1;
    	}
		
		var old_mspin_hiden = $("#old_mspin_hiden").val();
		if (old_mspin_hiden == "0") {
		$('#div_msg').text('');
		$('#div_msg').append('MSPIN is active. You can not proceed with active MSPIN.');
		$('#div_msg').show();
			return 1;
		}
		if (old_mspin_hiden == "1") {
		$('#div_msg').text('');
		$('#div_msg').append('MSPIN does not exist, You can not proceed.');
		$('#div_msg').show();
			return 1;
		}
		
		if (old_mspin_hiden == "3") {
			return 1;
		}
		if (old_mspin_hiden == "") {
		$('#div_msg').text('');
		$('#div_msg').append('Please search MSPIN');
		$('#div_msg').show();
			return 1;
		}
}

function showFiled(){
	
	var ownTwoWheeler  = $("#ownTwoWheeler").val();
	var ownFourWheeler  = $("#ownFourWheeler").val();
	
	if(ownTwoWheeler == ""){
		$("#ownTwoDiv").show();			
	}else{
	  $("#ownTwoDiv").hide();	
	}
	
	if(ownFourWheeler == ""){
		$("#fourTwoDiv").show();		
	}else{
	$("#fourTwoDiv").hide();	
	}
	
	
	var twoWheeler  = $("#twoWheeler").val();
	var fourWheeler  = $("#fourWheeler").val();
		if(twoWheeler == ""){
			$("#twoWheelerDiv").show();
		}else{
         $("#twoWheelerDiv").hide();
		}
			
        if(fourWheeler == ""){
			$("#fourWheelerDiv").show();
		}else{
           $("#fourWheelerDiv").hide();
		}	
       
        var licence = $("#licence").val();	
		 if(licence == ""){
			$("#dlDiv").show();
		   }else{
            $("#dlDiv").hide();
		  }
		 
		var certified = $("#certified").val();
		//if ((twoWheeler == "Yes") || (fourWheeler =="Yes")) {
		 
		
		 if(certified == ""){
			$("#certifiedDiv").show();
		   }else{
            $("#certifiedDiv").hide();
		  }
		//}
		
    var temp_fresher = $("#temp_fresher").val();	
    var temp_experience = $("#temp_experience").val();
    if(	temp_fresher == "" && temp_experience == ""){
	   $("#expDiv").show();
	   return 1;
    }else{
      $("#expDiv").hide();
    }

    if(temp_experience != ""){
		var msil = $("#msilExp").val();
		if(msil == ""){
			$("#msilDiv").show();
			return 1;
		}else{
		$("#msilDiv").hide();	
		}  
	}

       if(ownTwoWheeler == ""){
			 return 1;
	    }
	   if(ownFourWheeler == ""){
			 return 1;
	    }	
		if(twoWheeler == ""){
			 return 1;
		}
			
        if(fourWheeler == ""){
			 return 1;
		}	
		if(licence == ""){	
			 return 1;
		   }
		if ((twoWheeler == "Yes") || (fourWheeler =="Yes")) {
		  
		
		 if(certified == ""){
			 return 1;
		   }
		}
		
		
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
	    case 'jpeg':
	      return true;
	  }
	  return false;
	}
	
	function getExtensionResume(filename) {
		  var parts = filename.split('.');
		  return parts[parts.length - 1];
		}

		function isRsume(filename) {
		  var ext = getExtension(filename);
		  switch (ext.toLowerCase()) {
		   case 'txt':
		    case 'pdf':
		    case 'docx':
		    case 'doc':
		      return true;
		  }
		  return false;
		}
	
	
	
	function formatFileSize(bytes) {
		/* alert(bytes);
		   if(bytes == 0) return '0 Bytes';
		   var k = 1000,
		       dm =  2,
		       sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],
		       i = Math.floor(Math.log(bytes) / Math.log(k)); */
		       
		       var c=bytes/1024;
		       if(c>=1000){
		    	   return false;
		       }  
		   return   true;
		  // return parseFloat((bytes / Math.pow(k, i)).toFixed(dm)) + ' ' + sizes[i];
		}





function uploadFile(name)
{
 var fd = new FormData();
 var files = $('#phtograph-input')[0].files[0];
 var accessKey = $('#accessKey').val();
 var vewphoto = document.getElementById("vewphoto");
 var success = document.getElementById("successphoto");
 var error = document.getElementById("errorphoto");
 var div = document.getElementById("upload-section-photo");
 
 
 if(files ==  undefined){
	   error.style.display = 'block';
	   div.className += ' error'
     return false;
 }
 
  if (!isImage(document.getElementById("phtograph-input").value)) {
   	swal('Document / file type is not valid. Please upload valid document/file as per the specifications.');
       return ;
   }
  if(!formatFileSize(files.size)){
    swal("File size cannot be greater than 500 KB. \n Please try again.");
	 return ;
  }
     fd.append('file',files);
     fd.append('name',name);
     fd.append('accessKey',accessKey);
     fd.append('identity_proof','');
     fd.append('address_proof','');
	 $("#loader_photo").show();
	 	vewphoto.style.display = 'none';
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
      	vewphoto.style.display = 'block';
      	success.style.display = 'block';
      	 error.style.display = 'none';
      	div.classList.remove("error");
      	div.className += ' success'
		vewphoto.href= data;
		 $("#loader_photo").hide();
		
      },
      
  });
}


function uploadFile8(name)
{
var fd = new FormData();
var files = $('#resume-input')[0].files[0];
var accessKey = $('#accessKey').val();

var vewrsm = document.getElementById("vewrsm");
var successrsm = document.getElementById("successrsm");
var errorrsm = document.getElementById("errorrsm");
var divrmg = document.getElementById("divrmg");


if(files ==  undefined){
	
	errorrsm.style.display = 'block';
	divrmg.className += ' error'  
  return false;
}


if (!isRsume(document.getElementById("resume-input").value)) {
	swal('Document / file type is not valid. Please upload valid document/file as per the specifications.');
   return ;
  }

if(!formatFileSize(files.size)){
  swal("File size cannot be greater than 500 KB. \n Please try again.");
   return ;
}

  fd.append('file',files);
  fd.append('name',name);
  fd.append('accessKey',accessKey);
  fd.append('identity_proof','');
  fd.append('address_proof','');
  $("#resume_photo").show();
   vewrsm.style.display = 'none';
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
  	 vewrsm.style.display = 'block';
  	 successrsm.style.display = 'block';
  	 errorrsm.style.display = 'none';
  	 divrmg.classList.remove("error");
  	 divrmg.className += ' success'
	 vewrsm.href= data;
	  $("#resume_photo").hide();
   },
   
});

}

function uploadFile1(name)
{
var fd = new FormData();
var files = $('#signature-input')[0].files[0];
var accessKey = $('#accessKey').val();

console.log(files);
if(files ==  undefined){
    //alert("Please Select File");
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
        // alert("File Uploading successfully ");
         
     },
     
 });
}

 function uploadFile2(name)
 {
 var fd = new FormData();
 var files = $('#identity-input')[0].files[0];
 var accessKey = $('#accessKey').val();
 //alert(files);
 console.log(files);

 if(files ==  undefined){
    // alert("Please Select File");
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
          //alert("File Uploading successfully ");
          
      },
      
  });

 }
 
 function uploadFile3(name)
 {
 var fd = new FormData();
 var files = $('#address-input')[0].files[0];
 var accessKey = $('#accessKey').val();
 //alert(files);
 console.log(files);

 if(files ==  undefined){
    // alert("Please Select File");
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
        //  alert("File Uploading successfully ");
          
      },
      
  });

 }
 function uploadFile4(name)
 {
 var fd = new FormData();
 var files = $('#qualification-input')[0].files[0];
 var accessKey = $('#accessKey').val();
 //alert(files);
 console.log(files);

 if(files ==  undefined){
    // alert("Please Select File");
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
         // alert("File Uploading successfully ");
          
      },
      
  });

 }
 
 function uploadFile5(name)
 {
 var fd = new FormData();
 var files = $('#resignation-input')[0].files[0];
 var accessKey = $('#accessKey').val();
 //alert(files);
 console.log(files);

 if(files ==  undefined){
    // alert("Please Select File");
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
         // alert("File Uploading successfully ");
          
      },
      
  });

 }
 
 function uploadFile6(name)
 {
 var fd = new FormData();
 var files = $('#experience-input')[0].files[0];
 var accessKey = $('#accessKey').val();
 //alert(files);
 console.log(files);

 if(files ==  undefined){
    // alert("Please Select File");
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
         // alert("File Uploading successfully ");
          
      },
      
  });

 }
 
 function uploadFile7(name)
 {
 var fd = new FormData();
 var files = $('#salary-input')[0].files[0];
 var accessKey = $('#accessKey').val();
 //alert(files);
 console.log(files);

 if(files ==  undefined){
    // alert("Please Select File");
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
        //  alert("File Uploading successfully ");
          
      },
      
  });

 }
 
 function uploadFile88(name)
 {
 var fd = new FormData();
 var files = $('#resume-input')[0].files[0];
 var accessKey = $('#accessKey').val();
 //alert(files);
 console.log(files);

 if(files ==  undefined){
    // alert("Please Select File");
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
 
 function uploadFile9(name)
 {
 var fd = new FormData();
 var files = $('#adhar')[0].files[0];
 var accessKey = $('#accessKey').val();
 //alert(files);
 console.log(files);

 if(files ==  undefined){
   //  alert("Please Select File");
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
 
 function uploadFile10(name)
 {
 var fd = new FormData();
 var files = $('#any-input')[0].files[0];
 var accessKey = $('#accessKey').val();
 //alert(files);
 console.log(files);

 if(files ==  undefined){
     //alert("Please Select File");
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
        //  alert("File Uploading successfully ");
          
      },
      
  });

 }

 
 function updateParticipant(fid)
 {
	debugger;
	var fd = new FormData();
 	  if(confirm('do you want to update?')){
 		$.ajax({
 			  type: "POST",
 			  url:  "updateFamily",
 			  data: fd,
			  processData: false,
	          contentType: false,
	          cache: false,
	          timeout: 600000,
 			  success: function(data){
 				// alert("update successfully !!")
 				 //fetchData(1);
 			  },
 			  error: function(errorThrown){
 				  alert("something Went Wrong");
 			  }
		  });
 	  }  
 }
 
 
 function deleteParticipant(fid)
 {
	 alert(fid);
	//debugger;
	var fd = new FormData();
 	  if(confirm('do you want to delete?')){
 		$.ajax({
 			  type: "POST",
 			  url:  "deleteFamily",
 			  data: fd,
 			  processData: false,
 	          contentType: false,
 	          cache: false,
 	          timeout: 600000,
 			  success: function(data){
 				// alert("Delete successfully !!")
 				  //fetchData(1);
 			  },
 			  error: function(errorThrown){
 				  alert("something Went Wrong");
 			  }
 		  });
 	  }  
 }





 