<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import = "java.util.ResourceBundle" %>
<%
   try
    {
		
		ResourceBundle resource = ResourceBundle.getBundle("application");
    		  String baseServer = resource.getString("client.url");String title = resource.getString("app.title");
   /*   String userid=(String)session.getAttribute("userId");
	 String clientName = (String)session.getAttribute("clientName"); 
	 String roleId = (String)session.getAttribute("userType");   	
    	if(userid.length()>0 )
    	{   	 */	
    %>

<!DOCTYPE html>
<html>
<head>
 <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <link rel="icon" type="image/x-icon" href="<%=baseServer%>img/DuflonFavicon.png"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title><%=title %></title>
    <link rel="stylesheet" type="text/css" href="./css/common.css" />
    <link rel="stylesheet" type="text/css" href="./css/hiring-new.css" />
	<link rel="stylesheet" type="text/css" href="./css/sweetalert.css"/>
    <script type="text/javascript" src="./js/sweetalert.min.js"></script>
	<!-- <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.12.1/css/jquery.dataTables.min.css"> -->
	<link rel="stylesheet" type="text/css" href="./css/jquery.datatable.min.css"/>
    <link rel="stylesheet" type="text/css" href="./css/datatable.css">
    
    <link rel="stylesheet" type="text/css" href="./css/select2-4.0.13.min.css" />
	
    <script src="./js/jquery-3.4.1.min.js"></script>
    <script src="./js/select2-4.0.13.min.js"></script>
    <script src="./js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/fixedcolumns/4.2.1/js/dataTables.fixedColumns.min.js"></script> 
    <script src="./js/datatable.js"></script>
    
    <!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.4/css/bootstrap-select.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.4/js/bootstrap-select.min.js"></script> -->
    

 <style>
        .left-panel > ul > li:nth-child(1) > a, .left-panel > ul > li:nth-child(1) > ul > li:nth-child(1) > a{opacity: 1;}
        .left-panel > ul > li:nth-child(1) > ul > li:nth-child(1) > a::after{content: ''; position: absolute; right: 0; top: 50%; transform: translate(0, -50%); border-right: 6px solid #fff; border-top: 6px solid transparent; border-bottom: 6px solid transparent;}
		.th.sorting.sorting_asc.dtfc-fixed-left{z-index:1 !important;}
		.table.dataTable thead>tr>th.sorting, table.dataTable thead>tr>th.sorting_asc, table.dataTable thead>tr>th.sorting_desc, table.dataTable thead>tr>th.sorting_asc_disabled, table.dataTable thead>tr>th.sorting_desc_disabled, table.dataTable thead>tr>td.sorting, table.dataTable thead>tr>td.sorting_asc, table.dataTable thead>tr>td.sorting_desc, table.dataTable thead>tr>td.sorting_asc_disabled, table.dataTable thead>tr>td.sorting_desc_disabled{z-index: 1 !important;}
		.sorting .dtfc-fixed-left{z-index: 1 !important;}
		.th.sorting.dtfc-fixed-left{z-index: 1 !important;}
		.cancel-btn{color: #DC3545 !important;background-color:#fff !important;}
		#data_paginate a:hover{background-color: #DC3545 !important;}
		.dataTables_scrollBody {overflow-y: hidden !important;overflow-x: auto !important;max-height: 825px !important;}  
		.dataTables_wrapper .dataTables_filter input{padding: 10px 0px 10px 0px !important;}
		.dataTables_wrapper .dataTables_scroll div.dataTables_scrollBody>table>tbody>tr>td {vertical-align: middle;z-index: 1;}
		@media (max-width:1024px){
			.communications-popup{width: 850px !important;}}
		@media (max-width:820px){
			.table-date {margin-top: 55px !important;}
			.communications-popup{width: 800px !important;}}
		@media (max-width: 768px){
			.table-date {margin-top: 50px !important;}
  			.communications-popup{width: 750px !important;}}
  
  		@media (max-width: 426px){
			.communications-popup{width: 415px !important;} 
			.sweet-alert{width: 80% !important; left:65% !important;}
			.add-remove-columns{left: 0 !important;top: -45px !important;}
  			/* .table-date {top: 50px !important;} */
  			}
		@media (max-width: 400px){
			.communications-popup{width: 350px !important;} 
			.sweet-alert{width: 80% !important; left:70% !important;}
  			.communications-popup .form-section .form-block{width: calc(50% - 20px) !important;}
		}
  
	@media (max-width: 376px){
			.communications-popup{width: 300px !important;} 
			.add-remove-columns{top:-12px !important;left: 0;}
			.table-date{top:-30px !important;}
			.sweet-alert{width: 80% !important; left:73% !important;}

		}
		
		@media (max-width: 320px){
			.communications-popup{width: 300px !important;} 
			.table-date{top:-35px !important;}
			.add-remove-columns{top:-10px !important;left: 0;}
			.sweet-alert{width: 80% !important; left:85% !important;}
			.gray-btn{margin-left: 0px !important;}
			
	}
	
	
	.rate-block {  position: absolute;  top: 0;  left: 0;  opacity: 0;  margin: 0;  width: 30px;  height: 25px;  cursor: pointer;}
.label {  width: 30px;  height: 25px;  font-size: 12px;  line-height: 25px;  text-align: center;  color: #333;  background-color: #CCCCCC;  border-radius: 5px;  cursor: pointer;  display: block;  margin: 0;}
.rate-block span {  margin-right: 5px;  position: relative;}
    .green-address {        background-color: green;    }
	.table-responsive{margin: 20px 0;}
        .table-responsive table{border-left: 1px solid #ccc; border-top: 1px solid #ccc; width: 100%; box-sizing: border-box;}
.table-responsive table tr th{border-right: 1px solid #fff; border-bottom: 1px solid #fff; font-size: 14px; line-height: 18px; font-weight: bold; color: #fff; background-color: #dc3545; padding: 10px; text-align: center;}
        .table-responsive table tr td{border-right: 1px solid #ccc; border-bottom: 1px solid #ccc; font-size: 14px; line-height: 18px; color: #333; padding: 10px; text-align: center;}
       .form-section .form-block input[type="datetime-local"] {    font-family: 'Roboto', sans-serif;    width: 100%;    background: #F7F7F7;    border: 1px solid #D0D0D0;    border-radius: 7px;    color: #4D4D4D;    padding: 11px 15px;    font-size: 13px;    line-height: 18px;    outline: none;    box-sizing: border-box;    /* margin-left: 10%; */}

#add-datetime {    background-color: #DC3545;    color: #fff;    border: none;    border-radius: 30px;    padding: 10px 30px;    margin-bottom: 20px;    height: 40px;}
.extra-input span{font-size: 12px; line-height: 15px; border-radius: 30px; padding: 5px 15px; border: 1px solid #DC3545; display: inline-block; color: #DC3545; cursor: pointer; position: absolute; right: 0; bottom: 10px;}
.extra-input span:hover{background-color: #DC3545; color: #fff;}


   </style>

<script> 
	 function showMSG(msg){
		  swal({   
				  title: msg,     
				  showCancelButton: false,
				  confirmButtonColor: "#DC3545",   
				  confirmButtonText: "OK",   
				  closeOnConfirm: true },
				  function(isConfirm){			  
					  return false; 
				}); 
	 }
	
	function cancle(){
		 $('#reSendMail').prop('disabled', false);
		 $('#reSendMail').val('Submit');
	 $('.communications-popup, .blk-bg').hide();		
	}
	</script>
</head>
<body>

  <div class="left-panel-include">
   <%@include file="./header/left-panel.jsp"%> 
  </div>
    <div class="user-panel-include">
	  <%@include file="./header/user-panel.jsp"%>
	</div>

    <div class="right-section">
        <h1>Interview Request </h1>
        <div class="container-1100">
            <div class="filters">
                
            </div>

            <div class="table-date">
			
		
                <!-- <table  id="data" cellspacing="0" cellpadding="0" border="0" class="stripe display nowrap cell-border" width="50" style="width:100%"> -->
                <table  id="data" cellspacing="0" cellpadding="0" border="0" class="cell-border" width="100" style="width: 100% !important">
                   <thead>
                            <tr>
                                <th data-head="Sr. No."  class="sorting" style="z-index: 1 !important;" ><em >Sr. No.</em></th>
							    <th data-head="Access key" class="sorting" style="z-index: 1 !important;"><em >Access key</em></th>
                                <th data-head="HRE Name" class="sorting"><em>HRE Name</em></th>							
                                <th data-head="Candidate Name" class="sorting"><em>Candidate Name</em></th>							
                                <th data-head="View Dates" class="sorting"><em>View Dates</em></th>
                            </tr>
                        </thead>
                    <tbody>
                    <c:forEach items="${participantList}" var="participant" varStatus="status">
                        <tr>
                            <td>${status.count}</td>
							<td>${participant.accesskey}</td>
                            <td>${participant.hreName}</td>
                            <td>${participant.name}</td>
							<td>
                               <input type="button" class="btn btn-sm btn-dark" value="View" onclick="openMail('${participant.accesskey}','${participant.lmId }')" />
                            </td>
                        </tr>
                       </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
<!--     <div class="communications-popup" style="width: 580px;"> -->
    <div class="communications-popup" style="width: 880px;">
        <h3>Select Date</h3>
        <div class="table-responsive">
				<table cellspacing="0" cellpadding="0" >
					<thead>
						<tr>
								<th >Sr. No.</th>
							    <th>LM Name</th>
                                <th>Date 1</th>							
                                <th>Date 2</th>							
                                <th>Date 3</th>							
                                <th>Date 4</th>							
                                <th>Date 5</th>								
						</tr>
					</thead>
					<tbody id="dateBody">
					</tbody>
				</table>
			</div>
        <form class="form-section" action="" style="justify-content: center;">
				<div class="form-block" style="display: contents !important;">
			<div id="select2DropdownContainer"  style="width: inherit"></div>
			</div>
			<div class="form-block" id="newDateDiv">
				<div id="datetime-container ">
					<div class="datetime-input ">
						<!-- <h5>Date Time</h5> -->
						<input type="datetime-local" name="datetime" id="inviteDate">
					</div>
				</div>
			<input type="button" id="add-datetime" onclick="addDateTimeInput()" value="+">
			</div>
			<div class="form-block">
				<input type="button" class="cancel-btn" onclick="showDateInput()" value="Add New Date">
			</div>
			<div class="form-button">
                <input type="button" class="cancel-btn" onclick="cancle()" value="Cancel">
                <input type="button" class="submit-btn" onclick="submitLm()" value="Submit" >
              <input type="hidden"   value="" id="lmId"/>
					  <input type="hidden"   value="" id="accesskey"/>
            </div>
        </form>
        
    </div>
    <div class="blk-bg"></div>
    <script>
    function addDateTimeInput() {
        const numDateTimeInputs = $(".datetime-input").length;

        if (numDateTimeInputs < 3) {
            const currentDate = new Date();
            const nextMonthDate = new Date();
            nextMonthDate.setMonth(nextMonthDate.getMonth() + 1);
            const valueDate = new Date(currentDate);
            valueDate.setDate(valueDate.getDate() + numDateTimeInputs); // Add days

            const minDate = currentDate.toISOString().slice(0, 16); // Format: 'YYYY-MM-DDTHH:MM'
            const maxDate = nextMonthDate.toISOString().slice(0, 16); 
            const valDate = valueDate.toISOString().slice(0, 16); 
            
            const newDateTimeInput = `
                <div class="datetime-input extra-input">
                    <input type="datetime-local" name="datetime" id="inviteDate" required value="`+valDate+`" min="`+minDate+`" max="`+maxDate+`" onkeydown="return false;">
                    <span class="remove-btn">Remove</span>
                </div>`;

            $("#datetime-container").append(newDateTimeInput);

            // Add an event listener to the newly created "Remove" button
            $(".remove-btn").last().on("click", function () {
                $(this).parent(".datetime-input").remove(); // Remove the corresponding input
            });
        } else {
            swal({
                title: "You can add only 3 date and time.",
                showCancelButton: false,
                confirmButtonColor: "#DC3545",
                confirmButtonText: "OK",
                closeOnConfirm: true
            });
        }
    }
    function openMail(key,lmId)	{
		$("#lmId").val(lmId);
		$("#accesskey").val(key);
		$.ajax({
	         url: 'getDate',
	         type:'post',
	         data:'accesskey='+key,
	         success:function(jsonObject){
	        	 var jsonRes = JSON.parse(jsonObject);
	        	 $("#select2DropdownContainer").html(jsonRes.select2Date);
                 // Initialize the select2 dropdown
               //  $("#dateSelect").select2();
                 $("#dateSelect option:first").prop("selected", true);
                 //Now set for table
                 //$("#dateBody").html(jsonRes.tableData)
                 if (jsonRes.tableData && jsonRes.tableData.trim() !== "") {
            	// Table data is not empty or contains rows, so populate the table
            	$("#dateBody").html(jsonRes.tableData);
            	$('#dateBody').closest('.table-responsive').show(); // Show the table div
        	} else {
            	// Table data is empty or doesn't contain rows, so hide the table div
            	$('#dateBody').closest('.table-responsive').hide();
            	// Show the communication popup
        	}
		$('.communications-popup, .blk-bg').show();	
	    	  },
	          error:function(ress){
				window.close();
	    	  }
 			}); 
	}
    
    $(document).ready(function () {
    	$("#newDateDiv").hide();
    	// Get the current date to set for invitation date
	    var currentDate = new Date();
	    // Set the 'min' attribute to today's date
	    var minDate = currentDate.toISOString().slice(0, 16); // Format: 'YYYY-MM-DDTHH:MM'
	    $('#inviteDate').prop('min', minDate);
	    $('#inviteDate').prop('value', minDate);
	    // Calculate the date for next month
	    currentDate.setMonth(currentDate.getMonth() + 1);
	    // Set the 'max' attribute to next month's date
	    var maxDate = currentDate.toISOString().slice(0, 16); // Format: 'YYYY-MM-DDTHH:MM'
	    $('#inviteDate').prop('max', maxDate);
	  
	    //Stop to enter date by keyboard
	    $("#inviteDate").on("keydown", function(e) {
            e.preventDefault();
        });
	    
  	 /*  $('#select-email').select2({
  	        tags: false, // Allow custom tags
  	        tokenSeparators: [','], // Specify token separators for custom tags
  	        placeholder: 'Select Interviewer', // Default placeholder text
  	        width: '300px' // Width of the dropdown
  	      });    	 */
    });
    function showDateInput() {
		$("#newDateDiv").show();
	}
    function isSelect2Empty() {
        // Check if the Select2 dropdown has any selected values.
        return $('#select2DropdownContainer').select2('data').length === 0;
    }
  	  function submitLm(){
		    var lmId = $("#lmId").val();
		    var accesskey = $("#accesskey").val();
		    var dates = $('#dateSelect').val();
		    var dateTimes = $('input[name="datetime"]').map(function() {
		        return this.value;
		    }).get();
		    var isEmpty = dateTimes.some(function(date) {
		        return date.trim() === '';
		    });
		    var hasDuplicates = dateTimes.some(function(date, index, array) {
	            return array.indexOf(date) !== index;
	        });
		    //if(dates.length < 1){
		    if ($('#newDateDiv').is(':visible') && newDate.trim() === ''){
		    	showMSG('Please choose a date.');
		    }else if(!$('#newDateDiv').is(':visible') && dates.length < 1){
		    	showMSG('Please select atleast one date.');
		    }
		    /* 
		    if(dates.length < 1){
		    	showMSG('Please select atleast one date.');
		    } */else{
		    var data = {
		        'dateId': dates,
		        'accesskey':accesskey,
		        'lmId':lmId,
		        'newDate':newDate
		    };
		   
		    $.ajax({
		        type: 'POST',
		        url: 'save', 
		        data: JSON.stringify(data),
		        contentType: 'application/json',
		        success: function(response) {
		        	 swal({   
						  title: "Dates are saved successfully.",     
						  showCancelButton: false,
						  confirmButtonColor: "#DC3545",   
						  confirmButtonText: "OK",   
						  closeOnConfirm: false },
						  function(isConfirm){
						  if(isConfirm){
						  location.reload(); 
						 }else{
						 return false;
						}
						}); 
		        },
		        error: function(xhr, status, error) {
		            console.error(xhr.responseText);
		        }
		    });
		    }//Else
	  }
</script>
   
</body>
</html>

<%
    	/* }else
    	{
    		 response.sendRedirect("login");
        }	 */
    	
     }catch(Exception e)
    {
    	 System.out.println("Errror....."+e);
    	  response.sendRedirect("login");
    }
   %>