$(document).ready(function () {
	
    $("#submitbtn").click(function () {
    	
    	$('#testForm').validate({
    		// ignore:[],
  		  rules: {
          uan: {
            required: true
          },
          epfo: {
            required: true,
            digits: true
          },
          pfNumber: {
            required: true,
            digits: true
          },
          bankName: {
            required: true
          },
          ifscCode: {
            required: true
          },
          bankAccountNumber: {
            required: true,
            digits: true
          },
          empSalary: {
            required: true,
            number: true
          },
          gender: {
            required: true
          }
        },
  		  messages: {
          uan: {
            required: "Please enter UAN."
          },
          epfo: {
            required: "Please enter EPFO.",
            digits: "EPFO must be a numeric value."
          },
          pfNumber: {
            required: "Please enter PF Number.",
            digits: "PF Number must be a numeric value."
          },
          bankName: {
            required: "Please enter Bank Name."
          },
          ifscCode: {
            required: "Please enter IFSC Code."
          },
          bankAccountNumber: {
            required: "Please enter Account Number.",
            digits: "Account Number must be a numeric value."
          },
          empSalary: {
            required: "Please enter Emp Salary.",
            number: "Emp Salary must be a numeric value."
          },
          gender: {
            required: "Please select Gender."
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
    
    
 $("#submitnext").click(function () {
    	
    	$('#testForm').validate({
    		// ignore:[],
  		  rules: {
          uan: {
            required: true
          },
          epfo: {
            required: true,
            digits: true
          },
          pfNumber: {
            required: true,
            digits: true
          },
          bankName: {
            required: true
          },
          ifscCode: {
            required: true
          },
          bankAccountNumber: {
            required: true,
            digits: true
          },
          empSalary: {
            required: true,
            number: true
          },
          gender: {
            required: true
          }
        },
  		  messages: {
          uan: {
            required: "Please enter UAN."
          },
          epfo: {
            required: "Please enter EPFO.",
            digits: "EPFO must be a numeric value."
          },
          pfNumber: {
            required: "Please enter PF Number.",
            digits: "PF Number must be a numeric value."
          },
          bankName: {
            required: "Please enter Bank Name."
          },
          ifscCode: {
            required: "Please enter IFSC Code."
          },
          bankAccountNumber: {
            required: "Please enter Account Number.",
            digits: "Account Number must be a numeric value."
          },
          empSalary: {
            required: "Please enter Emp Salary.",
            number: "Emp Salary must be a numeric value."
          },
          gender: {
            required: "Please select Gender."
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
    

});