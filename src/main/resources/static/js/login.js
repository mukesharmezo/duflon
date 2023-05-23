$(document).ready(function () {
 $("#btnsubmit").click(function () {
	 
	 	
    	$('#testForm').validate({
    		// ignore:[],
  		   rules: {
  			 user: "required",
  			password:"required",			    
  		  },
  		  messages: {
  			user: "Select Location",
  			password: "Select option",
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
    	
    	alert($("#testForm").valid());
    	
    	if($("#testForm").valid()){
    		
    		//$("#testForm").submit();
    	}
    	
    });
});