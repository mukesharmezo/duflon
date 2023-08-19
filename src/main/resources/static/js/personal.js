$(document).ready(function() {
    $("#testForm").validate({
        rules: {
			title: {
				required:true
			},
            firstName: {
				required: true,
				minlength: 3,
				maxlength: 15,
				lettersOnly: true,
				notEqual: "#lastName"
			},
			middleName: {
				minlength: 3,
				maxlength: 15,
				lettersOnly: true
			},
			lastName: {
				required: true,
				minlength: 3,
				maxlength: 15,
				lettersOnly: true,
				notEqual: "#firstName"
			},
			pin: {
				required: true,
				number: true,
				minlength: 6,
				maxlength: 6
			},
			address: {
				required:true
			},
			state: {
				required:true
			},
			city:{
				required:true
			},
			mobile: {
				minlength: 10,
				maxlength: 15,
				number: true,
				maxRepeatDigits: true,
				notEqual: "#alternateContactNumber",
				// Regular expression to match Indian mobile numbers
				pattern: /^(\+91[\-\s]?)?[0]?(91)?[6789]\d{9}$/
			},
			alternateContactNumber: {
				minlength: 10,
				maxlength: 15,
				number: true,
				maxRepeatDigits: true,
				notEqual: "#mobile",
				pattern: /^(\+91[\-\s]?)?[0]?(91)?[6789]\d{9}$/
			},
			email: {
				required: true,
				email: true,
				pattern: /^[\w\.\-]+@(?:[a-zA-Z\d\-]{2,}\.)+[a-zA-Z]{2,6}$/
			},
			birthDate: {
				required: true,
				date: true
			},
			adharNumber:{
				required:true
			},
			idProof:{
				required:true
			},
			highestQualification:{
				required:true
			},
			primaryLanguage:{
				required:true
			},
			secondaryLanguage:{
				required:true
			}
        },
        messages: {
			title: {
				required:"Please select title."
			},
            firstName: {
				required: "Please enter your first name.",
				minlength: "Your first name must be at least 3 characters long.",
				maxlength: "Your first name cannot be more than 15 characters long.",
				lettersOnly: "Please enter only letters (A-Z) in your first name.",
				notEqual: "Your first name and last name cannot be the same."
			},
			middleName: {
				minlength: "Your first name must be at least 3 characters long.",
				maxlength: "Your first name cannot be more than 15 characters long.",
				lettersOnly: "Please enter only letters (A-Z) in your first name."
			},
			lastName: {
				required: "Please enter your last name.",
				minlength: "Your last name must be at least 3 characters long.",
				maxlength: "Your last name cannot be more than 15 characters long.",
				lettersOnly: "Please enter only letters (A-Z) in your last name.",
				notEqual: "Your first name and last name cannot be the same."
			},
			pin: {
						required: "<br/>Please enter pin code",
						number: "<br/>Please Enter your pin number as a numerical value",
						minlength: "<br/>Min. length should be 6 digit for Pin Code",
						maxlength: "<br/>Max. length should be 6 digit  for Pin Code"
					},
			address: {
				required:"Please enter address."
			},
			state: {
				required:"Please enter state."
			},
			city: {
				required:"Please enter city."
			},
			mobile: {
				required: "Please enter your mobile number.",
				number: "Please enter only digits for your mobile number.",
				minlength: "Please enter a valid mobile number.",
				maxlength: "Please enter a valid mobile number.",
				maxRepeatDigits: "Please enter non repeating mobile number.",
				pattern: "Please enter a valid Indian mobile number.",
				notEqual: "Mobile number can't be same as alternate."
			},
			alternateContactNumber: {
				required: "Please enter your mobile number.",
				number: "Please enter only digits for your mobile number.",
				minlength: "Please enter a valid mobile number.",
				maxlength: "Please enter a valid mobile number.",
				maxRepeatDigits: "Please enter non repeating mobile number.",
				pattern: "Please enter a valid Indian mobile number.",
				notEqual: "Alternate number can't be same as mobile."
			},
			email: {
				required: "Please enter your email address.",
				email: "Please enter a valid email address.",
				pattern: "Please enter a valid email address with a valid domain."
			},
			birthDate: {
				required: "Please enter your date of birth",
				date: "Please enter a valid date"
			},
			adharNumber:{
				required:"Please enter aadhar number."
			},
			idProof:{
				required:"Please select id proof."
			},
			highestQualification:{
				required:"Please select qualification."
			},
			primaryLanguage:{
				required:"Please select primary language."
			},
			secondaryLanguage:{
				required:"Please select secondary language."
			}
        }
    });
    //Validation methods
    $.validator.addMethod("pattern", function(value, element, pattern) {
		if (pattern instanceof RegExp) {
			return pattern.test(value);
		} else {
			return new RegExp(pattern).test(value);
		}
	}, "Please enter a valid value.");

	$.validator.addMethod("notEqual", function(value, element, param) {
		return this.optional(element) || value !== $(param).val();
	}, "First name and last name cannot be the same.");
	$.validator.addMethod("lettersOnly", function(value, element) {
		return this.optional(element) || /^[a-zA-Z]+$/i.test(value);
	}, "Please enter only letters (A-Z) in this field.");
	$.validator.addMethod("maxRepeatDigits", function(value, element) {
		var repeatCount = 0;
		var maxRepeat = 5;
		var i;
		for (i = 0; i < value.length - 1; i++) {
			if (value.charAt(i) === value.charAt(i + 1)) {
				repeatCount++;
				if (repeatCount >= maxRepeat) {
					return false;
				}
			} else {
				repeatCount = 0;
			}
		}
		return true;
	});
	
	
	  $("#submitbtn").click(function() {
		savePersonal('save');
	});
	  
	  
    $("#submitnext").click(function() {
        if ($("#testForm").valid()) {
            // Form is valid, perform your action here
                // Handle "Next" button action
                save('next');
        }
    });
});
