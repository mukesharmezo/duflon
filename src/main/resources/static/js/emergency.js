$(document).ready(function () {
	
    $("#submitbtn").click(function () {
    	
    	$('#testForm').validate({
    		 ignore:[],
  		  rules: {	
  			cname:"required",
  			contactNo : {
				required : true,
				number : true,
				minlength : 10,
				maxlength : 10
			}	
  		  },
  		  messages: {
  			cname: "<br/>Please enter name",
  			contactNo : {
				required : "<br/>Please enter mobile number",
				minlength : "<br/>Please enter 10 digit mobile number",
				maxlength : "<br/>Please enter 10 digit mobile number"
			 },			
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