

$(document).ready(function () {

	// $('#dateFromm').max = new Date().toLocaleDateString('en-us');
	   /* .toISOString().split("T")[0]; */
	$('#dateFromm').click(function (){
		var date = new Date();
		$('#dateFromm').attr('max', date.toLocaleDateString('en-us'));
	});

$('#formFilter').validate({
	rules: {
      dateFromm: {
        required: true,
       // lessThan: '#dateToo'
      },
      dateToo: {
        required: true,
        greaterThanOrEqualTo: "#dateFromm"
      }
    },
    messages: {
      dateFromm: {
        required: 'Please select a from date'
      },
      dateToo: {
        required: 'Please select a to date'
      }
    },
    errorPlacement: function(error, element) {
			error.insertAfter(element); // Insert the error message after the dropdown
		},
    errorClass: "error"
    });
    
    $.validator.addMethod('lessThan', function(value, element, param) {
    var fromDate = new Date(value);
    var toDate = new Date($(param).val());
    return fromDate < toDate;
  }, 'From date should be less than to date');
  
  $.validator.addMethod("greaterThanOrEqualTo", function(value, element, param) {
  var fromDate = new Date($("#dateFromm").val());
  var toDate = new Date(value);
  return fromDate <= toDate;
}, "To date should be the same as or greater than from date");
    
    
    
    
    
    
    
	/*
	$('#formFilter').submit(function(e){
		
		var dateT2 =$('#dateToo').val();
		var dateF2 = $('#dateFromm').val();
		if((dateT2.length==0 && dateF2.length==0) || (dateT2.length>4 && dateF2.length>4)){
	 }else	if(dateF2.length>4 && dateT2.length<4){
		$('#spanTo').show();
		$('#spanTo').html('Select Date');
		$('#spanTo').css('color','red');
		$('#spanFrom').hide();
		e.preventDefault();
		return;
	}else if(dateT2.length>4 && dateF2.length<4){
		$('#spanFrom').show();
		$('#spanFrom').html('Select Date');
		$('#spanFrom').css('color','red');
		$('#spanTo').hide();
		e.preventDefault();
		return;
	}else if(new Date(dateT2).getTime() <= new Date(dateF2).getTime()){
		$('#spanTo').html('Select Another Date');
		$('#spanTo').css('color','red');
		e.preventDefault();
		return;
	} 
		$('formFilter').submit();
	
	});

	$('#formButton').click(function(e){
		
		var dateT2 =$('#dateToo').val();
		var dateF2 = $('#dateFromm').val();

		if((dateT2.length==0 && dateF2.length==0) || (dateT2.length>4 && dateF2.length>4)){
	 }else	if(dateF2.length>4 && dateT2.length<4){
		$('#spanTo').html('Select Date');
		$('#spanTo').css('color','red');
		e.preventDefault();
		return;
	}else if(dateT2.length>4 && dateF2.length<4){
		$('#spanFrom').html('Select Date');
		$('#spanFrom').css('color','red');
		e.preventDefault();
		return;
	}else if(new Date(dateT2).getTime() <= new Date(dateF2).getTime()){
		$('#spanTo').html('Select Another Date');
		$('#spanTo').css('color','red');
		e.preventDefault();
		return;
	} 	
	});



	$("#reset").click(function() {
		$("#outlet").find('option:selected').removeAttr("selected");
		$('#candidateName').attr("value", "");
		$('#uniqueCode').attr("value", "");
		$("#desg").find('option:selected').removeAttr("selected");
		$('#mspinS').attr("value", "");
		$("#passFail").find('option:selected').removeAttr("selected");
		$("#regionCode").find('option:selected').removeAttr("selected");
		$("#stateCode").find('option:selected').removeAttr("selected");
		$("#cityCode").find('option:selected').removeAttr("selected");
		$("#parentDealerCode").find('option:selected').removeAttr("selected");
		$("#fsdmId").find('option:selected').removeAttr("selected");
		$("#dealerId").find('option:selected').removeAttr("selected");
		$("#outletCode").find('option:selected').removeAttr("selected");
		$('#reportrange').html('Select Date');
	});
	*/
	
});

