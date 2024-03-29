$(document).ready(function () {
	$('#cname, #memberName, #name, #memnber').keydown(function(e) {
			var keyCode = e.keyCode || e.which;
			if (keyCode === 8) {
                    return;
                }
                if (keyCode >= 96 && keyCode <= 105) {
                e.preventDefault();
            }
            var pattern = /[a-zA-Z\s]/;
            if (!pattern.test(String.fromCharCode(keyCode))) {
                e.preventDefault();
            }
    		});
	
    $("#submitbtn").click(function () {
    	
    	$('#testForm').validate({
    		 ignore:[],
  		  rules: {	
  			cname:"required",
  			memberName:"required",
  			relationship:"required",
  			contactNo : {
				required : true,
				number : true,
				minlength : 10,
				maxlength : 10
			}	
  		  },
  		  messages: {
  			cname: "<br/>Please enter name",
  			memberName: "<br/>Please enter name",
  			relationship: "<br/>Please select relationship",
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