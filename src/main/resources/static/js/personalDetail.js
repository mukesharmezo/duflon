$(document)
		.ready(
				function() {
					$("#submitnext")
							.click(
									function() {
										$('#testForm')
												.validate(
														{
															// ignore:[],
															rules : {
																location : "required",
																licenseNo : "required",
																workedWithMSILBefore : "required",
																validityOfLicence:"required",
																title : "required",
																address : "required",
																mspin : "required",
																status : "required",
																city : "required",
																state : "required",
																idProof : "required",
																//birthDate : "required",
																highestQualification : "required",
																twoWheeler : "required",
																fourWheeler : "required",
																twoWheelerr : "required",
																fourWheelerr : "required",
																primaryLanguage : "required",
																secondaryLanguage : "required",
																division : "required",
																designation : "required",
																departmentCode : "required",
																interviewDate : "required",
																joiningDate : "required",
																empProductivityRefId : "required",
																gender : "required",
																bankAccountNumber : "required",
																esiNumber : "required",
																tehsil : "required",
																village : "required",
																ownershipOfTwoWheeler : "required",
																knowDriving : "required",
																mdsCertified : "required",
																aptitudeScore : "required",
																attitudeScore : "required",
																interviewScore : "required",
																psychometricScore : "required",
																cname : "required",
																contactNo : "required",
																telephoneNo : "required",
																anniversaryDate : "required",
																bloodGroup : "required",
																martialStatus : "required",
																memberName : "required",
																relationship : "required",
																workExperiences : "required",
																autoIndustryExperience : "required",
																nonAutoIndustryExperience : "required",
																source : "required",
																total : "required",
																previousDesignation : "required",
																dealerLocation : "required",

																expInMths : "required",
																email : {
																	required : true,
																	email : true
																},
																photograph : {
																	required : true,
																},
																oldMspin : {

																	number : true
																},
																pin : {
																	required : true,
																	number : true,
																	minlength : 6,
																	maxlength : 6
																},

																adharNumber : {
																	required : true,
																	number : true,
																	minlength : 12,
																	maxlength : 12
																},
																mobile : {
																	required : true,
																	number : true,
																	minlength : 10,
																	maxlength : 10
																},
																alternateContactNumber : {
																	required : true,
																	number : true,
																	minlength : 10,
																	maxlength : 10
																},

																empSalary : {
																	required : true,
																	number : true,

																},
																experienceInMonths : {
																	required : true,
																	number : true,

																},

																firstName : {
																	required : true,
																	alpha : true,

																},

																lastName : {
																	required : true,
																	alpha : true

																},
																
																workArea : {
																	required : true,
																	loginRegexChar : true

																},
																pfNumber : {
																	required : true,
																	loginRegex : true

																},
																companyName : {
																	required : true,
																	loginRegexChar : true

																}

															},
															messages : {
																location : "<br/>Select Location",
																
																licenseNo : "<br/>Please Enter license No",
																validityOfLicence:"<br/>Please Select",
																workedWithMSILBefore : "<br/>Please select an option",
																title : "<br/>Please select Title",
																address : "<br/>Please enter address",
																mspin : "<br/>Please enter your MSPIN",
																status : "<br/>Please select the status",
																city : "<br/>Select City",
																state : "<br/>Select State",
																idProof : "<br/>Please select id proof",
																//birthDate : "<br/>Please select date of birth",
																alternateContactNumber : "<br/>Please Enter Numeric Value Only",
																highestQualification : "<br/>Please select an option",
																twoWheeler : "<br/>Select option",
																fourWheeler : "<br/>Select option",
																twoWheelerr : "<br/>Select option",
																fourWheelerr : "<br/>Select option",
																primaryLanguage : "<br/>Please select an option",
																secondaryLanguage : "<br/>Please select an option",
																division : "<br/>Please Select Division",
																designation : "<br/>Please Select Designation",
																departmentCode : "<br/>Please Select DepartmentCode",
																interviewDate : "<br/>Please Fill the Inteview Date",
																joiningDate : "<br/>Please Fill the Joining Date",
																empProductivityRefId : "<br/>Please Enter the Employee Productivity RefId",
																gender : "<br/>Select Gender",
																bankAccountNumber : "<br/>Please Enter the Bank AccountNumber",
																esiNumber : "<br/>Please Enter the ESI Number",
																tehsil : "<br/>Please enter tehsil",
																village : "<br/>Please enter village",
																ownershipOfTwoWheeler : "<br/>Please select Option First",
																knowDriving : "<br/>Please select Option First",
																mdsCertified : "<br/>Please select MDS CertifiedOption First",
																aptitudeScore : "<br/>Please  Enter the AptitudeScore",
																attitudeScore : "<br/>Please  Enter the AttitudeScore",
																interviewScore : "<br/>Please  Enter the InterviewScore",
																psychometricScore : "<br/>Please  Enter the PsychometricScore",
																cname : "<br/>Please enter your name",
																contactNo : "<br/>Please enter your contactNumber",
																telephoneNo : "<br/>Please  Enter the Telephone Number",
																anniversaryDate : "<br/>Please  Fill the Anniversary Date",
																bloodGroup : "<br/>Please  Select the Blood Group",
																martialStatus : "<br/>Please  Select the Martial Status",
																memberName : "<br/>Please enter family memberName",
																relationship : "<br/>Please  select the relationship",
																workExperience : "<span>Please Select the Work Experience</span>",
																total : "<br/>Please  enter your total experience",
																autoIndustryExperience : "<br/>Please  enter your autoIndustryExperience",
																nonAutoIndustryExperience : "<br/>Please  enter your nonauto industry experience",
																source : "<br/>Please  select your source",
																companyName : "<br/>Please  Enter the Company Name",
																previousDesignation : "<br/>Please  enter your Designation",
																dealerLocation : "<br/>Please select the Dealer_Location",
															
																																
																expInMths : "<br/>Please enter your expInMths",
																email : {
																	required : "<br/>Please enter email id",
																	email : "<br/>Your email address must be in the format of name@domain.com"
																},
																photograph : {
																	required : "<br/>Please upload your photograph"
																},
																oldMspin : {
																	required : "<br/>Please enter your OldMSPIN",
																	number : "<br/>Please Enter your OldMspin as a numerical value"
																},
																mobile : {
																	required : "<br/>Please enter mobile number",
																	number : "<br/>Please Enter your mobile number as a numerical value",
																	minlength : "<br/>You must be at least 10 digit for mobile number",
																	maxlength : "<br/>You enter maximum 10 digit for mobile number"
																},
																pin : {
																	required : "<br/>Please enter pin code",
																	number : "<br/>Please Enter your pin number as a numerical value",
																	minlength : "<br/>Minlength should be 6 digit for pin number",
																	maxlength : "<br/>Maxlength should be 6 digit  for pin number"
																},
																adharNumber : {
																	required : "<br/>Please enter aadhaar number",
																	number : "<br/>Please enter aadhaar number as numerical value",
																	minlength : "<br/>Minlength should be 12 digit for adharNumber",
																	maxlength : "<br/>Maxlength should be 12 digit for adharNumber"
																},
																alternateContactNumber : {
																	required : "<br/>Please enter contact number",
																	number : "<br/>Please enter alternate mobile number as numerical value",
																	maxlength : "<br/>You must be at least 10 digit for mobile number"
																},

																empSalary : {
																	required : "<br/>Please Enter Numeric Value Only",
																	number : "<br/>Please Enter your Employee salary as a numerical value"
																},
																experienceInMonths : {
																	required : "<br/>Please Enter Numeric Value Only",
																	number : "<br/>Please Enter your Months of Experience as a numerical value"
																},
																firstName : {
																	required : "<br/>Please enter first name",
																	alpha : "<br/>Please enter your name as in Alphabates"
																},

																lastName : {
																	required : "<br/>Please enter last name",
																	alpha : "<br/>Please Enter your LastName as in Alphabates"
																},
																
																
																workArea : {
																	required : "<br/>Please enyter your workArea",
																	loginRegexChar : "<br/>Please Enter your Work_Area as in AlphaNumeric or Character"
																},
																pfNumber : {
																	required : "<br/>Please Enter AlphaNumeric Only",
																	loginRegex : "<br/>Please Enter your Pf_Number as in AlphaNumeric"
																},
																companyName : {
																	required : "<br/>Please enter your companyName",
																	loginRegexChar : "<br/>Please Enter your Pf_Number as in AlphaNumeric or Character"
																}
															}

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

										var regx = /^[A-Za-z0-9 _.-]+$/;
										$.validator
												.addMethod(
														"loginRegexChar",
														function(value, element) {
															return this
																	.optional(element)
																	|| value == value
																			.match(regx);
														});

										var alNumRegex = /^[\w.]+$/i;
										$.validator
												.addMethod(
														"loginRegex",
														function(value, element) {
															return this
																	.optional(element)
																	|| value == value
																			.match(alNumRegex);
														});
										
										var empCode = $("#empcode").val();
										
										if (!$("#testForm").valid()) {											
											if( $('#div_emp').is(":visible")){
												$('#div_emp').show();
												$('#div_emp').text('');
												$('#div_emp').append('This Employee Code already exist');
										       return false;
									         }
											
											if(empCode == ""){
												$('#div_emp').show();
												$('#div_emp').text('');
												$('#div_emp').append('Please enter employee code');
										       return false;	
											}
										}
										

										if ($("#testForm").valid()) {
											if( $('#div_emp').is(":visible")){
												$('#div_emp').show();
												$('#div_emp').text('');
												$('#div_emp').append('This Employee Code already exist');
										       return false;
									         }
											
											if(empCode == ""){
												$('#div_emp').show();
												$('#div_emp').text('');
												$('#div_emp').append('Please enter employee code');
										       return false;	
											}

											$("#testForm").submit();
										}

									});
				});