$(document).ready(function () {
	
    $("#submitbtn").click(function () {
    	
    	$('#testForm').validate({
    		// ignore:[],
  		  rules: {
  			martialStatus: "required",
  			date:"required",
  			blodgroup:"required"    
  		  },
  		  messages: {
  			martialStatus: "<br/>Select Location",
  			date: "<br/>Please Enter Your Alphanumeric Code",
  			blodgroup: "<br/>Select option"
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
    	
    	
    	if($("#testForm").valid()){
    	
    	//document.testForm.submit();
    		$("#testForm").submit();
    	}
    	
    });
    
    
    
 $("#submitnext").click(function () {
    	
    	$('#testForm').validate({
    		// ignore:[],
  		  rules: {
  			location: "required",
  			//employeeCode:"required",
  			workedWithMSILBefore:"required",    
  		  },
  		  messages: {
  			location: "<br/>Select Location",
  			//employeeCode: "<br/>Please Enter Your Alphanumeric Code",
  			workedWithMSILBefore: "<br/>Select option"
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
    	
    	
    	if($("#testForm").valid()){
    		
    		$("#testForm").submit();
    	}
    	
    });
});