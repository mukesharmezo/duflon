

$(document).ready(function () {

	// $('#dateFromm').max = new Date().toLocaleDateString('en-us');
	   /* .toISOString().split("T")[0]; */
	
	$('#dateFromm').click(function (){
		var date = new Date();
		$('#dateFromm').attr('max', date.toLocaleDateString('en-us'));
	});


	// FSDM and TDm
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
	
	$("#status").click(function () {
		var interview = `${interview}`;
		var praraambh = `${praraambh}`;
		if (interview.length >= 6) {
			$("#interview").prop("checked", true);
		}
		if (praraambh.length >= 6) {
			$("#prarambh").prop("checked", true);
		}
	});
	
});

