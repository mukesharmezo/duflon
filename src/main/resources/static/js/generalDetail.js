$(document).ready(function() {

	$("#submitbtn, #submitnext").click(function() {
		if ($("#testForm").valid()) {
			// Form is valid, perform your action here
			if (this.id === "submitbtn") {
				// Handle "Save" button action
				save();
			} else if (this.id === "submitnext") {
				// Handle "Next" button action
				next();
			}
			$("#testForm").submit();
		}
	});

	$("#testForm").validate({
		rules: {
      martialStatus: "required",
      /*date: {
        required: function(element) {
          return $("#martialStatus").val() === "Married";
        },
        notFutureDate: true
      },*/
      blodgroup: "required"
    },
    messages: {
      martialStatus: "Please select a marital status",
      /*date: {
        required: "Please provide a marriage date",
        notFutureDate: "Marriage date cannot be a future date"
      },*/
      blodgroup: "Please select a blood group"
    },
	});

	$.validator.addMethod("notFutureDate", function(value, element) {
    var selectedDate = new Date(value);
    var currentDate = new Date();
    return selectedDate <= currentDate;
  }, "Marriage date cannot be a future date");


});