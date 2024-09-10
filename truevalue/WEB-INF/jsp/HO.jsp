<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import = "java.util.ResourceBundle" %>

<%
try
    {
	ResourceBundle resource = ResourceBundle.getBundle("application");
String baseServer = resource.getString("client.url");
HttpSession s = request.getSession();
s.setAttribute("remove_final", "final");
String assessUrl = resource.getString("client.asseesment");
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<link rel="icon" type="image/x-icon" href="<%=baseServer%>img/iRecruit-favicon.ico"/>  <title>iRecruit</title>
    <link rel="stylesheet" type="text/css" href="./css/common.css" />
    <link rel="stylesheet" type="text/css" href="./css/fsdm.css" />
    <link rel="stylesheet" type="text/css" href="css/dashboard-filter.css">
      <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.12.1/css/jquery.dataTables.min.css">
    <link rel="stylesheet" type="text/css" href="./css/datatable.css">
    <style>
        .left-panel > ul > li:nth-child(1) > a, .left-panel > ul > li:nth-child(1) > ul > li:nth-child(1) > a{opacity: 1;}
        .left-panel > ul > li:nth-child(1) > ul > li:nth-child(1) > a::after{content: ''; position: absolute; right: 0; top: 50%; transform: translate(0, -50%); border-right: 6px solid #fff; border-top: 6px solid transparent; border-bottom: 6px solid transparent;}
        /* .th.sorting.sorting_asc.dtfc-fixed-left{z-index:1 !important;}
		.table.dataTable thead>tr>th.sorting, table.dataTable thead>tr>th.sorting_asc, table.dataTable thead>tr>th.sorting_desc, table.dataTable thead>tr>th.sorting_asc_disabled, table.dataTable thead>tr>th.sorting_desc_disabled, table.dataTable thead>tr>td.sorting, table.dataTable thead>tr>td.sorting_asc, table.dataTable thead>tr>td.sorting_desc, table.dataTable thead>tr>td.sorting_asc_disabled, table.dataTable thead>tr>td.sorting_desc_disabled{z-index: 1 !important;}
		.sorting .dtfc-fixed-left{z-index: 1 !important;}
		.th.sorting.dtfc-fixed-left{z-index: 1 !important;} */
        /* .dataTables_scroll{padding: 5px 0px 0px 0px;} */
		.dataTables_scrollBody {overflow-y: hidden !important;overflow-x: auto !important;}
		.dataTables_wrapper .dataTables_filter input{padding: 10px 0px 10px 0px !important;}
    </style>

    <script src="./js/jquery-3.4.1.min.js"></script>
    <script src="./js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/fixedcolumns/4.2.1/js/dataTables.fixedColumns.min.js"></script>
	<script src="./js/datatable.js"></script>
  </head>
  <body>
    <div class="left-panel-include">
     <%@include file="./header/left-panel.jsp"%> 
    </div>
    <div class="user-panel-include">
      <%@include file="./header/user-panel.jsp"%>
    </div>

        <div class="right-section">
			<h1>In Progress</h1>
			    <div class="page-filter-include">
        		<%@include file="./filter/ho-filter.jsp" %>
        </div>

        <!-- <h1>In Progress</h1> -->
        <div class="container-1100">
            <div class="table-date">
			<div class="add-remove-columns">
                    <span>Add/Remove Columns</span>
                    <ul>
                        <li><a class="toggle-vis" data-column="0"><em>Sr. No.</em></a></li>
						<li><a class="toggle-vis" data-column="1"><em>Region</em></a></li>
						<li><a class="toggle-vis" data-column="2"><em>Dealer Code</em></a></li>
						<li><a class="toggle-vis" data-column="3"><em>Dealer Name</em></a></li>
                        <li><a class="toggle-vis" data-column="4"><em>Candidate Name</em></a></li>
						<li><a class="toggle-vis" data-column="5"><em>Profile</em></a></li>
						<li><a class="toggle-vis" data-column="6"><em>Designation Code</em></a></li>
						<li><a class="toggle-vis" data-column="7"><em>Designation Desc</em></a></li>
						<li><a class="toggle-vis" data-column="8"><em>Mobile Number</em></a></li>
						<li><a class="toggle-vis" data-column="9"><em>Access Key</em></a></li>
						<li><a class="toggle-vis" data-column="10"><em>Registration Date</em></a></li>
						<li><a class="toggle-vis" data-column="11"><em>Assessment Date</em></a></li>				
                       <!-- <li><a class="toggle-vis" data-column="10"><em>Total Marks</em></a></li>
                        <li><a class="toggle-vis" data-column="11"><em>Marks Obtained</em></a></li>
                        <li><a class="toggle-vis" data-column="12"><em>Percentage</em></a></li>-->
						<li><a class="toggle-vis" data-column="12"><em>Aptitude</em></a></li> 
						<li><a class="toggle-vis" data-column="13"><em>Attitude</em></a></li> 
                        <li><a class="toggle-vis" data-column="14"><em>Assessment Status</em></a></li>
                        <li><a class="toggle-vis" data-column="15"><em>Assessment Report</em></a></li>
						<li><a class="toggle-vis" data-column="16"><em>Assessment Sheet</em></a></li>
                        <li><a class="toggle-vis" data-column="17"><em>Interview Date</em></a></li>
                        <li><a class="toggle-vis" data-column="18"><em>Interview Score</em></a></li>
						<li><a class="toggle-vis" data-column="19"><em>Registration Form</em></a></li>
						<li><a class="toggle-vis" data-column="20"><em>MSPIN</em></a></li>
						<li><a class="toggle-vis" data-column="21"><em>Induction Course Status</em></a></li>
						<li><a class="toggle-vis" data-column="22"><em>FSDM Approval</em></a></li>
						
                    </ul>
                </div>
                 <div class="export-to-csv"><input type="button" onclick="funexport()" class="ecsvbutton" value="Export To CSV"></div>
                <table id="data" cellspacing="0" cellpadding="0" border="0" class="display nowrap cell-border" width="50">
                    <thead>
                        <tr>
                          <th data-head="Sr. No."  class="sorting" style="z-index: 1 !important;" ><em >Sr.No.</em></th>
						  <th data-head="Region" class="sorting" style="z-index: 1 !important;"><em>Region</em></th>  
                            <th data-head="Dealer Code	" class="sorting" ><em>Dealer Code</em></th>  			  
                            <th data-head="Dealer Name" class="sorting" ><em>Dealer Name</em></th>					  
							<th data-head="Candidate Name" class="sorting" ><em>Candidate Name</em></th>
							<!--<th data-head="Profile" class="sorting"><em>Profile</em></th> -->
							<th data-head="Designation Code" class="sorting"><em>Designation Code</em</span></th>
							<!--<th data-head="Designation Desc" class="sorting"><em>Designation Desc</em></th>-->
							<th data-head="Mobile Number" class="sorting"><em>Mobile Number</em></th>
							<th data-head="Access Key" class="sorting"><em>Access Key</em></th>
							<th data-head="Registration Date" class="sorting"><em>Registration Date</em></th>
							<th data-head="Assessment Date" class="sorting"><em>Assessment Date</em></th>                       
                           <!-- <th data-head="Total Marks" class="sorting"><em>Total Marks</em></th>
                            <th data-head="Marks Obtained" class="sorting"><em>Marks Obtained</em></th>
                            <th data-head="Percentage Scored" class="sorting"><em>Percentage</em></th>	 -->	
                            <th data-head="Aptitude" class="sorting"><em>Aptitude</em></th>		
                            <th data-head="Attitude" class="sorting"><em>Attitude</em></th>										
                            <th data-head="Assessment Status" class="sorting"><em>Assessment Status</em></th>
							<th data-head="Assessment Report" class="sorting"><em>Assessment Report</em></th>
							<th data-head="Assessment Sheet" class="sorting"><em>Assessment Sheet</em></th>
                            <th data-head="Interview Date" class="sorting"><em>Interview Date</em></th>
                            <th data-head="Interview Score" class="sorting"><em>Interview Score</em></th>
                            <th data-head="Registration Form" class="sorting"><em>Registration Form</em></th>
                            <th data-head="MSPIN" class="sorting"><em>MSPIN</em></th>
                            <th data-head="Induction Course Status" class="sorting"><em>Induction Course Status</em></th>
							<th data-head="FSDM Approval" class="sorting"><em>FSDM Approval</em></th>
                           
                        </tr>
                    </thead>
                    <tbody>
                    <%int i=1; %>
                    <c:forEach items="${participantList}" var="participant">
                        <tr>
                            <td><%=i %></td>
							<td>${participant.regionCode }</td>
							
							<td>${participant.outletCode }</td> 
							<td>${participant.dealerName }</td>
								<td> ${fn:replace(participant.participantName, "null", "")}</td>
							<!--<td>${participant.designation}</td>-->
							 <td>
							   <span>  ${participant.finalDesignationCode}  </span>
							 </td> 
							 <!-- <td>
							   <span>  ${participant.finalDesignation}  </span>
							 </td>-->
							<td>${participant.mobile}</td>
							<td>${participant.accesskey}</td>
							<td>${participant.dateOfRegistration}</td>
							<td>${participant.assessment_Completion_date}</td>
							<!--<td class="text-center"><center><span class="text-center">${participant.totalMark}</span></center></td>
                              <td><span>${participant.testScore}</span></td>
                            <td><span>${participant.percentageScore}%</span></td> -->
							 <td class="text-center">
							 <c:choose>
							  <c:when test="${participant.designation eq 'Sales Support'}">
							    <span>NA</span>
								</c:when> 
                               <c:when test="${participant.aptitude >= 12 }">
							    <span class="green">${participant.aptitude} </span>
								 </c:when>
                               <c:when test="${participant.aptitude < 12 }">
							    <span class="red">${participant.aptitude} </span>
								</c:when>
							    </c:choose>							
							</td>
							<td>
							 <c:choose>
							  <c:when test="${participant.designation eq 'Sales Support'}">
							    <span>NA</span>
								</c:when> 
                               <c:when test="${participant.attitude >= 12 }">
							    <span class="green">${participant.attitude} </span>
								 </c:when>
                               <c:when test="${participant.attitude < 12 }">
							    <span class="red">${participant.attitude} </span>
								</c:when>
							    </c:choose>
							    </td>	
                            <c:choose>
							 <c:when test="${participant.designation eq 'Sales Support'}">
							    <td><span>NA</span></td>
								</c:when>
                               <c:when test="${participant.passFailStatus == '1' }">
                                  <td><span class="green">Pass</span></td>
                               </c:when>
                               <c:when test="${participant.passFailStatus == '0' }">
                                  <td ><span class="red" >Fail</span></td>
                               </c:when> 
                               </c:choose> 
							   
							   		
                            <td><a href="#"><img src="./img/pdf-icn.svg" onclick="openReport('${participant.accesskey}','${participant.participantName }','${participant.email }','${participant.mobile }')" /></a></td >
                             
							
									
							<td> <a href="#" class="view-btn green"  onclick="openAnswerReport('${participant.accesskey}','${participant.participantName }','${participant.email }')">View</a></td >
							
							<c:choose>
                               <c:when test="${participant.interViewStatus == 'final' }">
                                 <td ><span class="fixdate" >${participant.interViewDate}</span></td>
                               </c:when>  
                                <c:otherwise>
                                <td>--</td>
                               </c:otherwise>
                               </c:choose> 
							  
                             <td>
                             <c:choose>
                               <c:when test="${participant.interViewStatus == 'final' }">
                                <a href="#" class="view-btn green"  onclick="openIterviewForm('${participant.accesskey}')">View</a>
                               </c:when>
                               <c:otherwise>
                               --
                               </c:otherwise>
                               </c:choose>
                             </td>
                              <td>
							  
							 
							  <c:choose>
                               <c:when test="${participant.interViewPassFailStatus == 'pass' }">
                                <a href="#" class="view-btn" onclick="openProfile('${participant.accesskey}')">View</a>
                               </c:when>
                               <c:otherwise>
                               --
                               </c:otherwise>
                               </c:choose>
							  </td> 
                             <td>${participant.mspin }</td>
                             <td>
							 <c:choose>
                               <c:when test="${participant.prarambhStatus == '0' }">
							    <span class="green"></span>
							    </c:when>
								  <c:when test="${participant.prarambhStatus == '1' }">
							    <span></span>
							    </c:when>
								  <c:when test="${participant.prarambhStatus == '2' }">
							    <span class="green">Completed</span>
							    </c:when>
								 <c:otherwise>
                               <span></span>
                               </c:otherwise>
							    </c:choose>
							 </td>
							 
                             <td>
							<c:choose>
                               <c:when test="${participant.fsdmApprovalStatus == 'Rejected' }">
                               <span class="red">
							<div title=" ${participant.fsdmReason}">${participant.fsdmApprovalStatus }</div>
							   </span>
                               </c:when>
                                 <c:when test="${participant.fsdmApprovalStatus == 'Pending'}">
                                <span class="blue">${participant.fsdmApprovalStatus}</span>
                                 </c:when>
                               <c:otherwise>
                               <span class="green">${participant.fsdmApprovalStatus}</span>
                               </c:otherwise>
							   </c:choose>
							 
							 </td>  
                           
                            
                           
                        </tr>
                        <%i++; %>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
 
    <div class="blk-bg"></div>
    <script>
      $(document).ready(function () {
 
            
      });
      
      function openDateTime(key,temp)
  	{
  		
  		$('#accesskey').val(key);
  	    $('.fixdate-popup, .blk-bg').show();
  	    if(temp=='2'){
  	    $('.fixdate-2nd-btn').show();	
  	    }
  	}
      
      function submit(key)
    	{    	 
    	   var date =  $('#date').val()
    	   var time =  $('#time').val()
    	   var accesskey = $('#accesskey').val();
    	   document.forms[0].action="fixedInterViewDate?date="+date+"&time="+time+"&accesskey="+accesskey;
  		   document.forms[0].method="post";
  		   document.forms[0].submit();
    	  $('.fixdate-popup, .blk-bg, .fixdate-2nd-btn').hide();
    	}
      
      
      function opentInterview(key){
          //  var key =   $('#accesskey').val();
  	        mywindow=window.open("intrviwForm?accesskey="+key,"detailwindow","resizable=1,scrollbars=1,width=1170,height=600");
  	       mywindow.moveTo(120,90);
       }
      
      function openReport(key,name,email,mobile){
	        mywindow=window.open("<%=assessUrl%>player/viewAssessment.jsp?accesskey="+key+"&name="+name+"&email="+email+"&mobile="+mobile+"&testid=41&attemptid=1","detailwindow","resizable=1,scrollbars=1,width=1170,height=600");
	       mywindow.moveTo(120,90);
     }
	 
	  function openAnswerReport(key,name,email,){
	        mywindow=window.open("<%=assessUrl%>pa/viewTest.do?accesskey="+key+"&name="+name+"&email="+email+"&testid=41&attemptid=1","detailwindow","resizable=1,scrollbars=1,width=1170,height=600");
	       mywindow.moveTo(120,90);
     }
      
      
      function openProfile(key){
    	  window.location.href="profileDetails?accesskey="+key;
      }
      
      function openIterviewForm(key){
    	  mywindow=window.open("printInterviewForm?accesskey="+key, "detailwindow","resizable=1,scrollbars=1,width=1170,height=600");
	       mywindow.moveTo(120,90);  
      }
      
     function funexport() {
			
        	var regionCode = $('#regionCode').val();
			var stateCode = $('#stateCode').val();
			var cityCode = $('#cityCode').val();
			var parentDealerCode = $('#parentDealerCode').val();
			var fsdmId = $('#fsdmId').val();
			var dealerId = $('#dealerId').val();
    	 	var dateFrom =$('#dateFromm').val();
 			var dateTo =$('#dateToo').val();
       		var form = document.createElement("form");   
       	        form.method="post";
       		form.action="inProgressHOCSV?regionCode="+regionCode+"&stateCode="+stateCode+"&cityCode="+cityCode+"&parentDealerCode="+parentDealerCode+"&fsdmId="+fsdmId+"&dealerId="+dealerId+"&dateFromm="+dateFrom+"&dateToo="+dateTo;
       		document.body.appendChild(form);
   		form.submit();

                swal({   
					title: "Please wait your request is being processed.",     
					showCancelButton: false,
					confirmButtonColor: "#2d3393",   
					confirmButtonText: "OK",   
					showConfirmButton: false,
					closeOnConfirm: false },
					function(isConfirm){

					});	 
     		 
     		// Example: Handling the response (using fetch API)
     		 fetch(form.action, {
     		     method: form.method,
     		     body: new FormData(form)
     		 })
     		 .then(response => {
     		     if (!response.ok) {
     		         throw new Error('Network response was not ok');
     		     }
     			// $("#search-overlay").hide();
     		    swal.close();
     		     console.log('Response from server:...........q');
     		     //return response.json(); // Assuming server returns JSON
     		 })
     		 .then(data => {
     		     console.log('Response from server fff:');
     		     // Process the response data as needed
     		 })
     		 .catch(error => {
     		     console.error('Error:', error);
     		     // Handle errors
     		 });
	}
    </script>
  </body>
</html>
<%
 }catch(Exception e)
    {
    	 System.out.println("Errror....."+e);
    	  response.sendRedirect("login");
    }%>