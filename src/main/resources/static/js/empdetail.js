$(document).ready(function () {
	
    $("#submitbtn").click(function () {
    	
    	$('#testForm').validate({
    		// ignore:[],
  		  rules: {	
  			division:"required",
  			finalDesignation:"required",
  			departmentCode:"required",
  			interviewDate:"required",
  			//joiningDate:"required",
  			gender:"required",
  			tehsil:"required",
  			village:"required",
  			ownTwoWheeler:"required",
  			knowDriving:"required",
  			mdsCertified:"required",
		    empSalary: {
			required: true,
		    number: true	 
		    }
			
  		  },
  		  messages: {
  			secondaryLanguage: "<br/>Please select secondary language",
  			division: "<br/>Please select division",
  			finalDesignation: "<br/>Please select designation",
  			departmentCode: "<br/>Please select department",
			//joiningDate: "<br/>Please select joining date",
  			interviewDate: "<br/>Please select interview date",
  			gender: "<br/>Please select gender",
  			tehsil: "<br/>Please Enter the Tehsil",
  			village: "<br/>Please  Enter the Village",
  			ownTwoWheeler: "<br/>Please select an option",
  			knowDriving: "<br/>Please select an option",
  			mdsCertified: "<br/>Please select an option",
			empSalary: "<br/>Please enter salary",

  		  }
    	});
    	
    	
    	
    	$.validator.addMethod("alpha", function(value, element) {
    	    return this.optional(element) || value == value.match(/^[a-zA-Z\s]+$/);
    	});
    	
    	
    	var regx = /^[A-Za-z0-9 _.-]+$/;
    	$.validator.addMethod("loginRegexChar", function(value, element) {
            return this.optional(element) || value == value.match(regx);
        });
    	
    	
    	var alNumRegex = /^[\w.]+$/i;
    	$.validator.addMethod("loginRegex", function(value, element) {
            return this.optional(element) || value == value.match(alNumRegex);
        });
    	
    	$("#btn").val($(this).val());
    	//alert(a);
    	if($("#testForm").valid()){
    	
    	//document.testForm.submit();
    		$("#testForm").submit();
    	}
    	
    });
    
    
 $("#submitnext").click(function () {
    	
    	$('#testForm').validate({
    		// ignore:[],
  		  rules: {	
  			division:"required",
  			finalDesignation:"required",
  			departmentCode:"required",
  			interviewDate:"required",
			//joiningDate:"required",
  			gender:"required",
  			tehsil:"required",
  			village:"required",
  			ownTwoWheeler:"required",
  			knowDriving:"required",
  			mdsCertified:"required",
		    empSalary: {
			required: true,
		    number: true	 
		    }
			
  		  },
  		  messages: {
  			secondaryLanguage: "<br/>Please select secondary language",
  			division: "<br/>Please select division",
  			finalDesignation: "<br/>Please select designation",
  			departmentCode: "<br/>Please select department",
  			interviewDate: "<br/>Please select interview date",
  			//joiningDate: "<br/>Please select joining date",
  			gender: "<br/>Please select gender",
  			tehsil: "<br/>Please Enter the tehsil",
  			village: "<br/>Please  Enter the village",
  			ownTwoWheeler: "<br/>Please select an option",
  			knowDriving: "<br/>Please select an option",
  			mdsCertified: "<br/>Please select an option",		        
			empSalary: "<br/>Please enter salary",
  		  }
    	});
    	
    	
    	
    	$.validator.addMethod("alpha", function(value, element) {
    	    return this.optional(element) || value == value.match(/^[a-zA-Z\s]+$/);
    	});
    	
    	
    	var regx = /^[A-Za-z0-9 _.-]+$/;
    	$.validator.addMethod("loginRegexChar", function(value, element) {
            return this.optional(element) || value == value.match(regx);
        });
    	
    	
    	var alNumRegex = /^[\w.]+$/i;
    	$.validator.addMethod("loginRegex", function(value, element) {
            return this.optional(element) || value == value.match(alNumRegex);
        });
			var work = $('#workedWithMSILBefore').val()	;
		if(work == "Yes"){
		var old_mspin_text  =$("#old_mspin").val();
		var old_mspin = $("#old_mspin_hiiden").val();
    	if(old_mspin_text=="" ){
    		 $('#div_msg').text('');
    		 $('#div_msg').append('Please enter  MSPIN');
    		 $('#div_msg').show(); 
    	    return false;
    	}
		
		var old_mspin = $("#old_mspin_hiiden")												.val();
		if (old_mspin == "0") {
		$('#div_msg').text('');
		$('#div_msg').append('MSPIN is active. You can not proceed with active MSPIN.');
		$('#div_msg').show();
			return false;
		}
		if (old_mspin == "1") {
		$('#div_msg').text('');
		$('#div_msg').append('MSPIN does not exist, You can not proceed.');
		$('#div_msg').show();
			return false;
		}
		
		if (old_mspin == "3") {
			return false;
		}
		if (old_mspin == "") {
		$('#div_msg').text('');
		$('#div_msg').append('Please search MSPIN');
		$('#div_msg').show();
			return false;
		}
		
		}
    	
    	$("#btn").val($(this).val());
    	//alert(a);
    	if($("#testForm").valid()){
    	
    	//document.testForm.submit();
    		$("#testForm").submit();
    	}
    	
    });
    

});