$(document).ready(function () {
	
    $("#submitbtn").click(function () {
    	$('#testForm').validate({
    		// ignore:[],
  		  rules: {
          uan: {
            customUAN: 10
          },
          epfo: {
            digits: true,
            customEPFO: true
          },
          pfNumber: {
            customPF : true
          },
          bankName: {
            minlength: 4,
    		maxlength: 80
          },
          ifscCode: {
            customIFSC: true,
            minlength: 11,
    		maxlength: 11
          },
          bankAccountNumber: {
            digits: true,
            minlength: 9,
			maxlength: 18
          },
          empSalary: {
            number: true,
            minlength: 4,
			maxlength: 12
          }
        },
  		  messages: {
          uan: {
            customUAN:"UAN must be 12 digits long and ppppconsist only of numbers."
          },
          epfo: {
            digits: "EPFO must be a numeric value.",
            customEPFO: "EPFO number must have at least 7 digits."
          },
          pfNumber: {
            customPF: "PF number must be alphanumeric and have a minimum of 7 characters."
          },
          ifscCode: {
    		customIFSC: "IFSC Code must start with 4 alphabetic characters, followed by '0' and then 6 digits.",
    		minlength: "IFSC Code must be exactly 11 characters long.",
        	maxlength: "IFSC Code must be exactly 11 characters long."
          },
          bankName:{
			minlength: "Bank name must be at least 4 characters.",
        	maxlength: "Bank name cannot exceed 80 characters."
			},
          bankAccountNumber: {
            digits: "Bank account number must be a numeric value.",
            minlength: "Bank account number must be at least 9 digits long.",
        	maxlength: "Bank account number cannot exceed 18 digits."
          },
          empSalary: {
            number: "Emp Salary must be a numeric value.",
            minlength: "Emp salary must be 4 digits.",
			maxlength: "Emp salary cannot exceed 12 digits. "
          }
        }
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
          uan: {
            customUAN: 10
          },
          epfo: {
            digits: true,
            customEPFO: true
          },
          pfNumber: {
            customPF : true
          },
          bankName: {
            minlength: 4,
    		maxlength: 80
          },
          ifscCode: {
            customIFSC: true,
            minlength: 11,
    		maxlength: 11
          },
          bankAccountNumber: {
            digits: true,
            minlength: 9,
			maxlength: 18
          },
          empSalary: {
            required: true,
            number: true,
            minlength: 4,
			maxlength: 12
          },
          gender: {
            required: true
          }
        },
  		  messages: {
          uan: {
            customUAN: "UAN must be 12 digits long and consist only of numbers."
          },
          epfo: {
            digits: "EPFO must be a numeric value.",
            customEPFO: "EPFO number must have at least 7 digits."
          },
          pfNumber: {
            customPF: "PF number must be alphanumeric and have a minimum of 7 characters."
          },
          bankName: {
            minlength: "Bank name must be at least 4 characters.",
        	maxlength: "Bank name cannot exceed 80 characters."
          },
          ifscCode: {
    		customIFSC: "IFSC Code must start with 4 alphabetic characters, followed by '0' and then 6 digits.",
    		minlength: "IFSC Code must be exactly 11 characters long.",
        	maxlength: "IFSC Code must be exactly 11 characters long."
          },
          bankAccountNumber: {
            digits: "Bank account number must be a numeric value.",
            minlength: "Bank account number must be at least 9 digits long.",
        	maxlength: "Bank account number cannot exceed 18 digits."
          },
          empSalary: {
            required: "Please enter emp salary.",
            number: "Emp Salary must be a numeric value.",
            minlength: "Emp salary must be 4 digits.",
			maxlength: "Emp salary cannot exceed 12 digits. "
          },
          gender: {
            required: "Please select gender."
          }
        },
    	});
    	
    	

    	
    	$("#btn").val($(this).val());
    	//alert(a);
    	if($("#testForm").valid()){
    	
    	//document.testForm.submit();
    		$("#testForm").submit();
    	}
    	
    });

$.validator.addMethod("customIFSC", function(value, element) {
    var pattern = /^[A-Z]{4}0\d{6}$/;
    return this.optional(element) || pattern.test(value);
}, "IFSC Code must start with 4 alphabetic characters, followed by '0' and then 6 digits.");

$.validator.addMethod("customPF", function(value, element) {
    var pattern = /^[A-Za-z0-9]{7,20}$/; // PF number can be alphanumeric, with a minimum of 7 characters
    return this.optional(element) || pattern.test(value);
}, "PF number must be alphanumeric and have a minimum of 7 characters.");
$.validator.addMethod("customEPFO", function(value, element) {
    var pattern = /^[0-9]{7,}$/; // EPFO number must start with at least 7 digits
    return this.optional(element) || pattern.test(value);
}, "EPFO number must start with at least 7 digits.");
$.validator.addMethod("customUAN", function(value, element) {
    var pattern = /^[0-9]{12}$/; // UAN is typically 12 digits long and consists only of numbers
    return this.optional(element) || pattern.test(value);
}, "UAN must be 12 digits long and consist only of numbers.");

});