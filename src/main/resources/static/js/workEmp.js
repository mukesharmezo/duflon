$(document).ready(function () {
	
    $("#submitnext").click(function () {
    	
    	$('#testForm').validate({
    	   ignore:[],
  		  rules: {	
  			autoIndustryExperience:"required",
  			companyName:"required",
  			expInMths:"required",
  			previousDesignation:"required",
  			workArea:"required",
  			
			
  		  },
  		  messages: {
  			autoIndustryExperience: "<br/>Please select ",
  			companyName: "<br/>Please enter company Name",
  			expInMths: "<br/>Please enter experience",
  			previousDesignation: "<br/>Please enter designation",
  			workArea: "<br/>Please enter work area"
			 		
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
    
    

    

});