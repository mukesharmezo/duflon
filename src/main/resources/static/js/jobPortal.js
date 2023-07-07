$(document).ready(function() {
	$('#jobPage').validate({

		rules: {
			title: {
				required: true,
				minlength: 6,
				maxlength: 100
			},
			description: {
				required: true,
				minlength: 30,
				maxlength: 300
			},
			salary: {
				required: true,
				number: true,
				min: 0
			},
			education: {
				required: true
			},
			location: {
				required: true
			},
			profileExperience: {
				required: true,
				number: true
			},
			"skills[0].skillName": {
				required: true,
			},
			"skills[0].requiredExperience": {
				required: true,
				number: true,
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
			mobile: {
				minlength: 10,
				maxlength: 15,
				number: true,
				maxRepeatDigits: true,
				// Regular expression to match Indian mobile numbers
				pattern: /^(\+91[\-\s]?)?[0]?(91)?[6789]\d{9}$/
			},
			email: {
				required: true,
				email: true,
				// Regular expression to match valid email domains for India
				pattern: /^[\w\.\-]+@(?:[a-zA-Z\d\-]{2,}\.)+[a-zA-Z]{2,6}$/
			},
			birthDate: {
				required: true,
				date: true
				// Date of birth must be at least 18 years ago
				//maxDate: moment().subtract(18, 'years').format('YYYY-MM-DD')
			},
			resumeFile: {
				required: true,
				extension: "pdf|doc|docx",
				accept: "application/pdf,application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document",
				filesize: 1 // 2 MB
			},
			photoFile: {
				required: true,
				extension: "jpeg|jpg|png",
				accept: "image/jpeg,image/png",
				filesize: 0.5 // 2 MB
			},
			"skills[0].skill": {
				required: true
			},
			"skills[0].experience": {
				required: true,
				number: true
			},
			company: {
				required: true
			},
			region: {
				required: true
			},
			unit: {
				required: true
			},
			business: {
				required: true
			},
			function: {
				required: true
			},
			product: {
				required: true
			},
			hreId: {
				required: true
			},
			designation:{
				required: true
			},
			gender:{
				required: true
			},
			source:{
				required: true
			}
		},
		messages: {
			title: {
				required: "Please enter job title.",
				minlength: "Please enter at least 6 characters.",
				maxlength: "Please enter no more than 100 characters."
			},
			description: {
				required: "Please enter job description.",
				minlength: "Please enter at least 30 characters.",
				maxlength: "Please enter no more than 300 characters."
			},
			salary: {
				required: "Please enter salary.",
				number: "Please enter a valid number.",
				min: "Please enter a positive number."
			},
			education: {
				required: "Please select education."
			},
			location: {
				required: "Please select location."
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
			mobile: {
				required: "Please enter your mobile number.",
				number: "Please enter only digits for your mobile number.",
				minlength: "Please enter a valid mobile number.",
				maxlength: "Please enter a valid mobile number.",
				maxRepeatDigits: "Please enter non repeating mobile number.",
				pattern: "Please enter a valid Indian mobile number."
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
			resumeFile: {
				required: "Please upload your resume",
				extension: "Please upload a valid PDF or Word document",
				filesize: "The file size must be less than 1 MB",
				accept: "Please upload a valid PDF or Word document (doc, docx) file"
			},
			photoFile: {
				required: "Please upload your photo",
				extension: "Please upload a valid JPG/JPEG or PNG image",
				filesize: "The photo size must be less than 500 KB",
				accept: "Please upload a valid JPEG/JPG or PNG file"
			},
			profileExperience: {
				required: "Please enter experience",
				number: "Please enter only numeric value"
			},
			"skills[0].skillName": {
				required: "Please enter a skill name."
			},
			"skills[0].requiredExperience": {
				required: "Please enter the required experience for this skill.",
				number: "Please enter a valid number."
			},
			"skills[0].skill": {
				required: "Please enter a skill name.",
			},
			"skills[0].experience": {
				required: "Please enter the required experience for this skill.",
				number: "Please enter a valid number."
			},
			company: {
				required: "Please select company."
			},
			region: {
				required: "Please select region."
			},
			unit: {
				required: "Please select unit."
			},
			business: {
				required: "Please select business."
			},
			function: {
				required: "Please select function."
			},
			product: {
				required: "Please select product."
			},
			hreId: {
				required: "Please select HRM."
			},
			designation: {
				required: "Please select designation."
			},
			gender:{
				required: "Please select gender."
			},
			source:{
				required: "Please select source."
			}
		},
		errorPlacement: function(error, element) {
			error.insertAfter(element); // Insert the error message after the dropdown
		},
		errorClass: "error"
	});

	$.validator.addMethod("validOption", function(value, element) {
		const validOptions = ["High School", "Associate's Degree", "Bachelor's Degree", "Master's Degree", "Doctoral Degree"];
		return this.optional(element) || validOptions.includes(value);
	});
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
	$.validator.addMethod("notEmpty", function(value, element) {
		return value.trim() !== "";
	}, "This field cannot be empty.");
	/*$.validator.addMethod('filesize', function(value, element, param) {
		// Get file size
		var size = element.files[0].size;
		// Convert size to bytes
		var maxSize = param * 1048576;
		// Check if file size is less than or equal to the max size
		return size <= maxSize;
	}, 'File size must be less than 2 MB.');*/
	
	$.validator.addMethod('filesize', function(value, element, param) {
	// Get file size
	var size = element.files[0].size;
	// Convert size to bytes
	var maxSize = param * 1048576;
	// Check if file size is less than or equal to the max size
	return size <= maxSize;
}, function(param, element) {
	var maxSize = param * 1048576;
	return "File size must be less than " + maxSize + " bytes.";
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
});