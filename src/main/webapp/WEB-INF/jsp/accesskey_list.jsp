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
	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.12.1/css/jquery.dataTables.min.css">
    <link rel="stylesheet" type="text/css" href="./css/datatable.css">
	
    <script src="./js/jquery-3.4.1.min.js"></script>
    <script src="./js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/fixedcolumns/4.2.1/js/dataTables.fixedColumns.min.js"></script> 
    <script src="./js/datatable.js"></script>

 <style>
        .left-panel > ul > li:nth-child(1) > a, .left-panel > ul > li:nth-child(1) > ul > li:nth-child(1) > a{opacity: 1;}
        .left-panel > ul > li:nth-child(1) > ul > li:nth-child(1) > a::after{content: ''; position: absolute; right: 0; top: 50%; transform: translate(0, -50%); border-right: 6px solid #fff; border-top: 6px solid transparent; border-bottom: 6px solid transparent;}
		.th.sorting.sorting_asc.dtfc-fixed-left{z-index:1 !important;}
		.table.dataTable thead>tr>th.sorting, table.dataTable thead>tr>th.sorting_asc, table.dataTable thead>tr>th.sorting_desc, table.dataTable thead>tr>th.sorting_asc_disabled, table.dataTable thead>tr>th.sorting_desc_disabled, table.dataTable thead>tr>td.sorting, table.dataTable thead>tr>td.sorting_asc, table.dataTable thead>tr>td.sorting_desc, table.dataTable thead>tr>td.sorting_asc_disabled, table.dataTable thead>tr>td.sorting_desc_disabled{z-index: 1 !important;}
		.sorting .dtfc-fixed-left{z-index: 1 !important;}
		.th.sorting.dtfc-fixed-left{z-index: 1 !important;}
		.cancel-btn{color: #DC3545 !important;background-color:#fff !important;}
		#data_paginate a:hover{background-color: #DC3545 !important;}
		.dataTables_scrollBody {overflow-y: hidden !important;overflow-x: auto !important;}  
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

   </style>

<script> 
	function fncGo()
	{
		var noOfKey =	$("#noOfKey").val();
		if(noOfKey == "")
		{
			swal("Please select no. of access key to be generated.");
			return false;
		}       					
		$.ajax({
		         url: 'generateAccesskeyPro',
		         type:'post',
		         data:'noOfKey='+noOfKey,
		         success:function(res){
		        	 if(res =='success'){
						  swal({   
		 					title: "Access Key(s) generated successfully. Activate the Access Key(s) by sending it using 'Communication' button.",     
		 					showCancelButton: false,
		 					confirmButtonColor: "#DC3545",   
		 					confirmButtonText: "OK",   
		 					closeOnConfirm: false },
		 					function(isConfirm){
		 							 location.reload(); 
		 					});	
		        	 }
		    	  },
		          error:function(ress){
		        	  alert(ress);
					window.close();
		    	  }
	  			}); 
	}
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
	function fncRegisterAndSendEmail()
	{		
		var accesskey = $('#accesskey').val();
		var fName = $('#firstName').val();
		var  mName =  $('#middleName').val();
		var lName = $('#lastName').val();
		var email = $('#email').val();
		var mobile = $('#mobile').val();
		var designation = $('#designation').val(); 
		var dealerCode = $('#dealerCode').val(); 
		var profile = $("#profile").val();
		var designationDatascience = $("#designation_datascience").val();
		
		
                 if(status == "B"){
                	 showMSG("This candidate  is blocked");
                	 return;
                 }
				if(fName=="")
					{  
						 showMSG("Please enter the first name.");
						 
						return false;
					}
					
					if(lName == "")
					{  
						 showMSG("Please enter the last name.");  
						return false;
					}
					
					if(!validMobile(mobile)){
					showMSG("Please enter correct mobile number");
					return false;
			        }
					
					if(email == "")
					{
						showMSG("Please enter the email.");
						return false;
					}
					
					 if (!validateEmail(email)) {
						 showMSG("Please enter a valid email address");
				            return false;
				        }
					 
					 var tempcc = email.split(",");
					 
					 if(tempcc.length>1)
						{
							 showMSG("Please enter only one email.");
							 return false;
						}
					
					
					if(mobile=="" || mobile.length<10)
					{
						 showMSG("Please enter valid mobile.");
						return false;
					}
					
					if(designation == "")
					{
						showMSG("Please select designation.");
						return false;
					}
										
					if(designation == "Sales")
					{
						if(profile==""){
							showMSG("Please select location.");
							return false;
						}
						if(designationDatascience == ""){
							showMSG("Please select designation.");
							return false;	
						}
					}
					
					if(dealerCode == "")
					{
						showMSG("Please select dealer code.");
						return false;
					}
	          
							     $('#sendMail').prop('disabled', true);
			    	             $('#sendMail').val('Please wait');
								
								$.ajax({
								         url: 'assignAccesskeyPro',
								         type:'post',
								         data:'accesskey='+accesskey+'&firstName='+fName+'&lastName='+lName+'&email='+email+'&mobile='+mobile+'&designation='+designation+"&middleName="+mName+"&dealerCode="+dealerCode+"&profile="+profile+"&designationDatascience="+designationDatascience,
								         success:function(res){
										
											  $('#sendMail').prop('disabled', false);
			    	                          $('#sendMail').val('Submit');
								        	 if(res !="success"){
								        		 $('#resendkey').val(accesskey);
								        		 $('#reAccesskey').val(res);
								        		 $('#h2').text('');
								        		 $("#h2").append(res);
								        		 $('.communications-popup, .blk-bg').hide();	
								        		 $('.key-popup, .blk-bg').show(); 
								        	 }else{
												  swal({   
								 					title: "Email and SMS has been triggered to the candidate.",     
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
								        	 }
								        	 
								    	  },
								          error:function(ress){
											window.close();
								    	  }
							  			}); 

	}
	
	function remainder(accesskey){
		$.ajax({
	         url: 'assignAccesskeyReminder',
	         type:'post',
	         data:'accesskey='+accesskey,
	         success:function(res){
	        	 var btn1 = document.getElementById("sendMail");
	        	 var btn2 = document.getElementById("reSendMail");
	        	 btn2.style.display = 'block';
	        	 btn1.style.display = 'none'; 
	        	 console.log( "JSON Data: " + res.firstName );
	        	 $("#accesskey").val(accesskey);
	     		 $('#firstName').val(res.firstName);
	     		 $('#middleName').val(res.middleName);
	     		 $('#lastName').val(res.lastName);
	     		 $('#email').val(res.email);
	     		 $('#mobile').val(res.mobile);
	     		 $('#designation').val(res.designation); 
	     		 $('#dealerCode').val(res.dealerCode); 
				 var des = res.designationDatScience;
	     		 if(res.designation =="Sales"){
	     			$.ajax({
	     		         url: 'getDatascienceDesignation',
	     		         type:'post',
	     		         data:'profile='+res.profile,
	     		         success:function(res){
	     		        	 $('#designation_datascience')
	     		        	    .find('option')
	     		        	    .remove()
	     		        	    .end()
	     		        	    .append(res);
								 $('#designation_datascience').val(des);
	     		    	  },
	     		          error:function(ress){
	     					window.close();
	     		    	  }
	     	 			}); 
	     			 $('#profile').val(res.profile);
					// alert(res.designationDatScience);
		     		
		     		 $("#div_profile").show();
		  		     $("#div_designation_datascience").show();
	     		 }
	     		
	     		 $('.communications-popup, .blk-bg').show();
	     		 
	    	  },
	          error:function(ress){
	        	  swal(ress)
				//window.close();
	    	  }
			}); 	
	}
	
	function resendAccesskey(){
		var accesskey = $('#resendkey').val();
		var fName = $('#firstName').val();
		var  mName =  $('#middleName').val();
		var lName = $('#lastName').val();
		var email = $('#email').val();
		var mobile = $('#mobile').val();
		var designation = $('#designation').val(); 
		var dealerCode = $('#dealerCode').val(); 
		
		var profile = $("#profile").val();
		var designationDatascience = $("#designation_datascience").val();
		
		$.ajax({
	         url: 'reAssignAccesskeyPro',
	         type:'post',
	         data:'accesskey='+accesskey+'&firstName='+fName+'&lastName='+lName+'&email='+email+'&mobile='+mobile+'&designation='+designation+"&middleName="+mName+"&dealerCode="+dealerCode+"&profile="+profile+"&designationDatascience="+designationDatascience,
	         success:function(res){
	        	swal({   
								 					title: "Email and SMS has been triggered to the candidate.",     
								 					showCancelButton: false,
								 					confirmButtonColor: "#DC3545",   
								 					confirmButtonText: "Ok",   
								 					closeOnConfirm: false },
								 					function(isConfirm){
								 						if(isConfirm){
								 							 location.reload(); 
								 						}else{
								 							return false;
								 						}
								 					});  
	        	 
	    	  },
	          error:function(ress){
	        	 // alert(ress)
				window.close();
	    	  }
 			}); 
		
	}
	
	function remainderEmail(accesskey){
		
		
		var accesskey = $('#accesskey').val();
		var fName = $('#firstName').val();
		var  mName =  $('#middleName').val();
		var lName = $('#lastName').val();
		var email = $('#email').val();
		var mobile = $('#mobile').val();
		var designation = $('#designation').val(); 
		var dealerCode = $('#dealerCode').val(); 
		var profile = $("#profile").val();
		var designationDatascience = $("#designation_datascience").val();
		
		
                 if(status == "B"){
                	 showMSG("This candidate  is blocked");
                	 return;
                 }
				if(fName=="")
					{  
						swal("Please enter the first name.");						
						return;
					}
					
					if(!validMobile(mobile)){
					showMSG("Please enter correct mobile number");
					return false;
			        }

					if(email=="")
					{
						showMSG("Please enter the email.");						
						return;
					}
					
					 if (!validateEmail(email)) {
						 showMSG("Please enter a valid email address");
				            return false;
				        }
					 
					 var tempcc = email.split(",");
					 
					 if(tempcc.length>1)
						{
						 swal("Please enter only one email.");
						}
					
					
					if(mobile=="" || mobile.length<10)
					{
						showMSG("Please Enter Valid Mobile No.");						
						return;
					}
					
					if(designation.length<0)
					{
						showMSG("Please select profile.");						
						return;
					}
					
					if(designation == "Sales")
					{
						if(profile==""){
							showMSG("Please select location.");
							return;
						}
						if(designationDatascience == ""){
							showMSG("Please select profile.");
							return;	
						}
					}
					
					if(dealerCode.length<0)
					{
						showMSG("Please select dealer code.");						
						return;
					}           
					            $('#reSendMail').prop('disabled', true);
				    	        $('#reSendMail').val('Please wait');
								$.ajax({
								         url: 'remainderEmail',
								         type:'post',
								         data:'accesskey='+accesskey+'&firstName='+fName+'&lastName='+lName+'&email='+email+'&mobile='+mobile+'&designation='+designation+"&middleName="+mName+"&dealerCode="+dealerCode+"&profile="+profile+"&designationDatascience="+designationDatascience,
								         success:function(res){
								        	swal({   
								 					title: "Email and SMS has been triggered to the candidate.",     
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
								          error:function(ress){
											window.close();
								    	  }
							  			}); 

	}
	function fncNum()
	{
		
		if((window.event.keyCode<47 || window.event.keyCode >57))
		{
		 window.event.keyCode = "0";
		}
	}
	
	 function validateEmail(email) 
	 {
	     var re = /\S+@\S+\.\S+/;
	     return re.test(email);
	 }

	 function validMobile(mobile){
			//var mobval =$('#mobile').val();
			if(mobile>5111111111){
				return true;
			}else{
				return false;
			}
		}
	
	
	function openMail(key)
	{
		 $('#accesskey').val(key);
		 $('#firstName').val("");
		  $('#middleName').val("");
		 $('#lastName').val("");
		 $('#email').val("");
		 $('#mobile').val("");
		 $('#designation').val(""); 
		 $('#outlet').val(""); 
		
		 $('.communications-popup, .blk-bg').show();	
		
	}
	function cancle(){
		 $('#reSendMail').prop('disabled', false);
		 $('#reSendMail').val('Submit');
	 $('.communications-popup, .blk-bg').hide();		
	}
	function fncSearch()
	{
		var jobprofile=document.forms[0].jobapplied.value;
		
		if(jobprofile=="")
		{
			showMSG("Please select Job Profile");
			document.forms[0].jobapplied.focus();
			return false;
		}
		document.forms[0].action="generateAccesskeySearch";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
	
	function yes(){
		var key =  $("#reAccesskey").val();
		document.forms[0].action="reAssignOldAccesskey?accesskey="+key;
		document.forms[0].method="post";
		document.forms[0].submit();
		
		 $("#h2").val("");
		 location.reload(); 
		 
	}
	function no(){
		 $('.key-popup, .blk-bg').hide(); 
	}
	
	function deleteKey(key){
		
		   $("#deAccesskey").val(key);
		   $('.delete-popup, .blk-bg').show(); 
	}
	function bock(accesskey,status)
	{
		document.forms[0].action="blockdAccesskey?accesskey="+accesskey+"&status="+status;
		document.forms[0].method="post";
		document.forms[0].submit();	
	}
	
	
	
	function getChar(text)
	{
		if(/^[a-zA-Z0-9- ]*$/.test(text) == false) {
		    swal('Your search string contains illegal characters.');
		}	
	}
	
	function downloadFile(){
		
			    $('#data').table2csv({
			      file_name: 'data.csv',
			      header_body_space: 0
			    });
			 
	}

		function funexport()
			{
				//var dateRange =document.getElementById("reportrange").innerText;
		
				//document.forms[0].action="./newCandidateCSV?date="+dateRange;
				document.forms[0].action="./newCandidateCSV";
				document.forms[0].method="post";
				document.forms[0].submit();
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
        <h1>New Candidate </h1>
        <div class="container-1100">
            <div class="filters">
                <div class="filter">
                    Access Key
                    <select id="noOfKey">
                        <option value="">- Select -</option>
                        <%  for(int count=1; count<=10; count++){%>
                        <option value="<%=count %>"><%=count %></option>
                        <%  }  %>
                    </select>
                    <input type="button" class="gray-btn" onclick="fncGo()" value="Generate" />
                </div>
            </div>

            <div class="table-date">
			<div class="add-remove-columns">
                    <span>Add/Remove Columns</span>
                    <ul>
                 					
						  <li><a class="toggle-vis" data-column="0"><em>Sr.No.</em></a></li>
                        <li><a class="toggle-vis" data-column="1"><em>Candidate Name</em></a></li>
                        <!-- <li><a class="toggle-vis" data-column="2"><em>Designation</em></a></li> -->
                        <li><a class="toggle-vis" data-column="2"><em>Profile</em></a></li>
						<li><a class="toggle-vis" data-column="2"><em>Designation Code</em></a></li>
						<li><a class="toggle-vis" data-column="2"><em>Designation Desc</em></a></li>
                        <li><a class="toggle-vis" data-column="3"><em>Mobile Number</em></a></li>
                        <li><a class="toggle-vis" data-column="4"><em>Email Id</em></a></li>
                        <li><a class="toggle-vis" data-column="5"><em>Access Key</em></a></li>
                        <li><a class="toggle-vis" data-column="6"><em>Registration Date</em></a></li>
                        <li><a class="toggle-vis" data-column="7"><em>Communication</em></a></li>
                        <li><a class="toggle-vis" data-column="8"><em>Status</em></a></li>
                        <li><a class="toggle-vis" data-column="9"><em>Reactivate</em></a></li>
                    </ul>
                </div>
			 <div class="export-to-csv"><input type="button" onclick="funexport()" value="Export To CSV" class="ecsvbutton"></div>
                <table  id="data" cellspacing="0" cellpadding="0" border="0" class="stripe display nowrap cell-border" width="50">
                   <thead>
                            <tr>
                                <th data-head="Sr. No."  class="sorting" style="z-index: 1 !important;" ><em >Sr.No.</em></th>
							 <th data-head="Candidate Name" class="sorting" style="z-index: 1 !important;"><em >Candidate Name</em></th>
                                <!-- <th data-head="Designation" class="sorting"><em>Designation</em></th> -->
                                <th data-head="Profile" class="sorting"><em>Profile</em></th>
								<th data-head="Designation Code" class="sorting"><em>Designation Code</em></th>
								<th data-head="Designation Desc" class="sorting"><em>Designation Desc</em></th>
                                <th data-head="Mobile Number" class="sorting"><em>Mobile Number</em></th>
                                <th data-head="Email Id" class="sorting"><em>Email Id</em></th>
                                <th data-head="Access Key" class="sorting"><em>Access Key</em></th>
                                <th data-head="Registration Date" class="sorting"><em>Registration Date</em></th>
                                <th data-head="Communication" class="sorting"><em>Communication</em></th>
                                <th data-head="Status" class="sorting"><em>Status</em></th>
                                <th data-head="Reactivate" class="sorting"><em>Reactivate</em></th>
                            </tr>
                        </thead>
                    <tbody>
                    <%int p=1; %>
                    <c:forEach items="${participant}" var="participant">
                        <tr>
                            <td><%=p %></td>
                            <td>${participant.name}</td>
							<td>${participant.designation}</td>
							<td>${participant.finalDesignationCode}</td>
							<td>${participant.finalDesignation}</td>
							<td>${participant.mobile}</td>
                            <td>${participant.email}</td>
                            <td>${participant.accesskey}</td>
                            <td>${participant.dateOfApplication}</td>
                               <c:choose>
                                 <c:when test="${participant.testStatus == 'Email Not Send' && participant.reactivateStatus !='1'}">
                                     <td><span class="mail-a-key"><img src="./img/mail-icn.svg" onclick="openMail('${participant.accesskey}')" /></span></td>
                                 </c:when>
                                  <c:when test="${(participant.testStatus == 'Not Started' || participant.testStatus == 'Started') && participant.reactivateStatus !='1'  }"> 
                                   <td><span class="mail-a-key active"><img src="./img/mail-icn.svg" onclick="remainder('${participant.accesskey}')"/></span></td>  
                                  </c:when>
                                   <c:otherwise> <td>--</td> </c:otherwise>
                               </c:choose>
                            <td>${participant.testStatus }</td>
                            <td>
							
                            <c:choose>
                             <c:when test="${ participant.reactivateStatus =='1'}">
                               <input type="button" class="btn btn-sm btn-dark" value="Reactivate" onclick="reactivtePop('${participant.accesskey}')" />
                             </c:when>
                              <c:otherwise>
                                       --
                                     </c:otherwise>
                             </c:choose>
                            </td>
                           
                        </tr>
                       <%p++; %>
                       </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div class="communications-popup">
        <h3>Candidate Communication</h3>
        <form class="form-section" action="">
            <div class="form-block">
               First Name <span style="color:red;">*</span><input type="text" placeholder="First Name"  id="firstName"  maxlength="55" onkeypress="return /^[a-zA-Z ]*$/.test(event.key)"/>
            </div>
            <div class="form-block">
                Middle Name <input type="text" placeholder="Middle Name" id="middleName"  maxlength="55" onkeypress="return /^[a-zA-Z ]*$/.test(event.key)"/>
            </div>
            <div class="form-block">
                Last Name <span style="color:red;">*</span><input type="text" placeholder="Last Name" id="lastName" maxlength="55" onkeypress="return /^[a-zA-Z ]*$/.test(event.key)"/>
            </div>
            <div class="form-block">
                Email ID <span style="color:red;">*</span><input type="email" placeholder="Email ID" maxlength="55"   id="email"/>
            </div>
            <div class="form-block">
			Mobile Number <span style="color:red;">*</span>
                <input type="text" placeholder="Mobile Number" id="mobile"  maxlength="10" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/>
            </div>
            <div class="form-block">
			Profile <span style="color:red;">*</span>
                <select id="designation" onchange="showDataScienceProfile()">
                    <option value="">Select</option>
                      <c:forEach items="${designationList}" var="designation">
                    <option value="${designation}">${designation}</option>
                   
                    </c:forEach>
                </select>
            </div>
            
             <div class="form-block" id="div_profile" style="display:none;">
			Location <span style="color:red;">*</span>
                <select id="profile" onchange="getDesignation()">
                    <option value="">Select</option>                    
                    <option value="URBAN">Urban</option>
                   <option value="RURAL">Rural</option>                   
                </select>
                      
                      
            </div>
            
             <div class="form-block" id="div_designation_datascience" style="display:none;">
			 Designation<span style="color:red;">*</span>
                <select id="designation_datascience">
                    <option value="">Select</option>
                     
                </select>
            </div>
            
              <div class="form-block">
			   Dealer Code <span style="color:red;">*</span>
                <select id="dealerCode">
                    <option value="">Select</option>
					 <c:forEach items="${outletList}" var="outlet">
                    <option value="${outlet.outletCode}">${outlet.outletCode}</option>
                   
                    </c:forEach>
                    
                </select>
            </div>
            <div class="form-button">
                <input type="button" class="cancel-btn" onclick="cancle()" value="Cancel">
                <input type="button" class="submit-btn" onclick="fncRegisterAndSendEmail()" value="Submit" id="sendMail">
                <input type="button" class="submit-btn" onclick="remainderEmail()" value="Submit" style="display:none;" id="reSendMail">
                <input type="hidden"  value="${accesskey }" id="accesskey">
            </div>
        </form>
    </div>

    <div class="key-popup">
        <p>The candidate is already registered and is part of the recruitment process. You may search for more information using the candidate access key.</p>
        <h2 id="h2" class="testClass"></h2>
		  <p>OR do you want to use the new access key to send the communication? 
		</p>
        <div class="form-button">
            <button class="cancel-btn outline-btn" onclick="no()">No</button>
            <button class="submit-btn" onclick="resendAccesskey()">Yes</button>

             <input type="hidden"  value="" id="reAccesskey">
			 <input type="hidden"  value="" id="resendkey">
			  
        </div>
    </div>

    <div class="delete-popup">
        <p>Do you want to reactivate this access key?</p>
        <div class="form-button">
            <button class="cancel-btn outline-btn" onclick="closeDeletePop(event)">No</button>
            <button class="submit-btn" onclick="extendKey()">Yes</button>

              <input type="hidden"  value="" id="deAccesskey">
        </div>
    </div>

    <div class="blk-bg"></div>
	<!--<script src="./js/datatable.js"></script> -->
    <script>
	 
      $(document).ready(function () {
		  
		  
		
      //  $(".left-panel-include").load("./includes/left-panel/left-panel.html");
      //  $(".user-panel-include").load("./includes/user-panel/user-panel.html");

     
    
    $(document).mouseup(function(e) 
    {
        var container = $(".add-remove-columns ul");
        if (!container.is(e.target) && container.has(e.target).length === 0) 
        {
            container.hide();
            $('.add-remove-columns span').removeClass('active');
        }
    });

           

          
            $('.key-popup .submit-btn').on('click', function(){
                $('.key-popup, .blk-bg').hide();
                return false;
            });
      });

     function reactivtePop(key) {
		 $("#deAccesskey").val(key);
        $('.delete-popup, .blk-bg').show();
    } 
   
    function closeDeletePop(event) {
        $('.delete-popup, .blk-bg').hide();
    }
	
	function extendKey()
	{
		var accesskey = $("#deAccesskey").val();
		document.forms[0].action="reactivate?accesskey="+accesskey;
		document.forms[0].method="post";
		document.forms[0].submit();
	}
	
	function showDataScienceProfile()
	{
		var designation = $("#designation").val();
		if(designation =="Sales"){
		    $("#div_profile").show();
		    $("#div_designation_datascience").show();
	    }else{
	    	$("#div_profile").hide();
			$("#div_designation_datascience").hide();
	    }
		
	}
	
	function getDesignation(){
		var profile =$("#profile").val();
		$.ajax({
	         url: 'getDatascienceDesignation',
	         type:'post',
	         data:'profile='+profile,
	         success:function(res){
	        	 
	        	 $('#designation_datascience')
	        	    .find('option')
	        	    .remove()
	        	    .end()
	        	    .append(res);
	    	  },
	          error:function(ress){
				window.close();
	    	  }
 			}); 
			
			 // $("#designation_datascience").append("<option value ='STR'>Sales Trainee</option>");			
	}
    </script>
	<style>
		@media (max-width: 1024px){.sweet-alert{width:43% !important; left:50% !important;}}
		@media (max-width: 820px){.sweet-alert{width: 65% !important; left:50% !important;}}
		@media (max-width: 768px){.sweet-alert{width: 50% !important; left:60% !important;}}
		@media (max-width: 426px){.sweet-alert{width: 70% !important; left:73% !important;}}
		@media (max-width: 400px){.sweet-alert{width: 80% !important; left:70% !important;}}
		@media (max-width: 376px){.sweet-alert{width: 80% !important; left:73% !important;}}
		@media (max-width: 320px){.sweet-alert{width: 80% !important; left:85% !important;}}
	</style>
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