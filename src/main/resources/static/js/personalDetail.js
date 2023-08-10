$(document).ready(function() {
	console.log('Hello');
	$("#submitnext, #submitbtn").click(function() {
		

	
		$('#testForm').validate(
			{
				// ignore:[],
				rules: {
					title: "required",
					firstName: {
						required: true,
						alpha: true,
					},
					lastName: {
						required: true,
						alpha: true
					},
					pin: {
						required: true,
						number: true,
						minlength: 6,
						maxlength: 6
					},
					address: "required",
					state: "required",
					city: "required",
					idProof: "required",
					birthDate: "required",
					mobile: {
						required: true,
						number: true,
						minlength: 10,
						maxlength: 10
					},
					alternateContactNumber: {
						minlength: 10,
						maxlength: 15,
						number: true,
						maxRepeatDigits: true,
						// Regular expression to match Indian mobile numbers
						pattern: /^(\+91[\-\s]?)?[0]?(91)?[6789]\d{9}$/
					},
					email: {
						required: true,
						email: true
					},
					adharNumber: {
						required: true,
						number: true,
						minlength: 12,
						maxlength: 12
					},
					highestQualification: "required",
					primaryLanguage: "required",
					secondaryLanguage: "required"
				},
				messages: {

					title: "<br/>Please select title",
					firstName: {
						required: "<br/>Please enter first name",
						alpha: "<br/>Please enter your name as in Alphabates"
					},

					lastName: {
						required: "<br/>Please enter last name",
						alpha: "<br/>Please Enter your LastName as in Alphabates"
					},
					pin: {
						required: "<br/>Please enter pin code",
						number: "<br/>Please Enter your pin number as a numerical value",
						minlength: "<br/>Minlength should be 6 digit for pin number",
						maxlength: "<br/>Maxlength should be 6 digit  for pin number"
					},
					address: "<br/>Please enter address",
					city: "<br/>Please enter city",
					state: "<br/>Please enter state",
					idProof: "<br/>Please select id proof",
					birthDate: "<br/>Please select date of birth",
					mobile: {
						required: "<br/>Please enter mobile number",
						number: "<br/>Please Enter your mobile number as a numerical value",
						minlength: "<br/>You must be at least 10 digit for mobile number",
						maxlength: "<br/>You enter maximum 10 digit for mobile number"
					},
					email: {
						required: "<br/>Please enter email id",
						email: "<br/>Your email address must be in the format of name@domain.com"
					},
					adharNumber: {
						required: "<br/>Please enter aadhaar number",
						number: "<br/>Please enter aadhaar number as numerical value",
						minlength: "<br/>Minlength should be 12 digit for adharNumber",
						maxlength: "<br/>Maxlength should be 12 digit for adharNumber"
					},
					alternateContactNumber: {
						required: "<br/>Please enter contact number",
						number: "Please enter only digits for your mobile number.",
						minlength: "Please enter a valid mobile number.",
						maxlength: "Please enter a valid mobile number.",
						maxRepeatDigits: "Please enter non repeating mobile number.",
						pattern: "Please enter a valid Indian mobile number."
					},
					highestQualification: "<br/>Please select an option",
					primaryLanguage: "<br/>Please select an option",
					secondaryLanguage: "<br/>Please select an option",
				}
			});
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
		$.validator
			.addMethod(
				"alpha",
				function(value, element) {
					return this
						.optional(element)
						|| value == value
							.match(/^[a-zA-Z\s]+$/);
				});
	});
	});
