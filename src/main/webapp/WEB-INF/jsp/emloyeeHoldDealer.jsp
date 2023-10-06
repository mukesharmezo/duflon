<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import = "java.util.ResourceBundle" %>
<%
try
    {
	ResourceBundle resource = ResourceBundle.getBundle("application");
String baseServer = resource.getString("client.url");String title = resource.getString("app.title");
String assessUrl = resource.getString("client.asseesment");
HttpSession s = request.getSession();
s.setAttribute("remove_final", "final");
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<link rel="icon" type="image/x-icon" href="<%=baseServer%>img/DuflonFavicon.png"/>
    <title><%=title %></title>
    <link rel="stylesheet" type="text/css" href="./css/common.css" />
    <link rel="stylesheet" type="text/css" href="./css/hiring-in-process.css" />
    <link rel="stylesheet" type="text/css" href="css/dashboard-filter.css">
    <link rel="stylesheet" type="text/css" href="./css/sweetalert.css"/>
    <script type="text/javascript" src="./js/sweetalert.min.js"></script>
	<link rel="stylesheet" type="text/css" href="./css/jquery.datatable.min.css"/>
    <link rel="stylesheet" type="text/css" href="./css/datatable.css">
    
    

    <script src="./js/jquery-3.4.1.min.js"></script>
    <script src="./js/jquery.dataTables.min.js"></script>
	<script src="https://cdn.datatables.net/fixedcolumns/4.2.1/js/dataTables.fixedColumns.min.js"></script>
	<script src="./js/datatable.js"></script>
    <style>
		.dataTables_wrapper .dataTables_filter input{padding: 10px 0px 10px 0px !important;}    

        @media (max-width: 320px){
				.page-filters {margin-top: -20px !important;}
				.page-filters-block {display:contents !important; right:0 !important;}
				.add-remove-columns.irc-add-remove-columns{margin: 0 !important;}
                .table-date {margin-top: 55px !important;}
				div#data_filter {margin-top: -30px !important;}
                .export-to-csv {top: 0px !important;left: 0 !important;}
                /* .page-filters-process-block{width:293px !important;top: 70px !important;} */
                .page-filters-filter-block .form-section .form-block{width: calc(100% - 20px) !important;}
                .page-filters-filter-block{width: 320px !important;}
                .page-filters-filter-block .form-section .form-block{width: calc(100% - 20px) !important;}
			}

			@media (max-width: 376px){
				.page-filters {margin-top: -15px !important;display: flex !important;}
				.add-remove-columns.irc-add-remove-columns{margin: 0 !important;} 
				.page-filters-filter{margin-top: 35px !important;}
                .table-date {margin-top: 55px !important;}
                .page-filters-filter-block{width: 320px !important;}
				div#data_filter {margin-top: -30px !important;}
                .export-to-csv {top: 0px !important;left: 0 !important;}
                .page-filters-filter-block .form-section .form-block{width: calc(100% - 20px) !important;}
				
}
@media (max-width: 426px){
	.add-remove-columns {top: -45px !important;}
	.page-filters-filter{margin-top: 0 !important;}
    .page-filters-filter-block .form-section .form-block{width: calc(100% - 20px) !important;}
    .table-date {margin-top: 55px !important;}

}
     @media (max-width: 767px) {
	.add-remove-columns {top: -48px !important;}
    .table-date {margin-top: 55px !important;}}

        @media  (max-width: 768px){
		  .communications-popup {width: 650px !important;}
          .table-date {margin-top: 55px !important;}
        } 
        @media  (max-width: 820px){
				.page-filters-filter-block {width: 465px !important;}
				.table-date {margin-top: 55px !important;}
				.page-filters-process-block {width: 450px !important;left: -242px !important;}
			}
			
    </style>
  </head>
  <body>
    <div class="left-panel-include">
    <%@include file="./header/left-panel.jsp"%> 
    </div>
    <div class="user-panel-include">
	<%@include file="./header/user-panel.jsp"%>
	</div>

        <div class="right-section">
        
        <h1>On Hold</h1>
        <div class="page-filter-include">
		  				<%@include file="./filter/page-filter.jsp"%>
				 </div>

        <!-- <h1>On Hold</h1> -->
        <div class="container-1100">
            <div class="table-date">
			<div class="add-remove-columns">
                    <span>Add/Remove Columns</span>
                    <ul>
                       <!-- <li><a class="toggle-vis" data-column="0"><em>Sr. No.</em></a></li>
                        <li><a class="toggle-vis" data-column="1"><em>Candidate Name</em></a></li> -->
						<li><a class="toggle-vis" data-column="2"><em>Designation</em></a></li>
						<li><a class="toggle-vis" data-column="3"><em>Mobile Number</em></a></li>
						<li><a class="toggle-vis" data-column="4"><em>Access Key</em></a></li>
						<li><a class="toggle-vis" data-column="5"><em>Registration Date</em></a></li>
						<li><a class="toggle-vis" data-column="6"><em>Assessment Date</em></a></li>				
						<li><a class="toggle-vis" data-column="7"><em>Aptitude</em></a></li> 
						<li><a class="toggle-vis" data-column="8"><em>Attitude</em></a></li> 
						<li><a class="toggle-vis" data-column="9"><em>Mechanical</em></a></li> 
                        <li><a class="toggle-vis" data-column="10"><em>Assessment Status</em></a></li>
                        <li><a class="toggle-vis" data-column="11"><em>Assessment Report</em></a></li>
						<li><a class="toggle-vis" data-column="12"><em>Registration Form</em></a></li>
                        <li><a class="toggle-vis" data-column="13"><em>Interview Date</em></a></li>
                        <li><a class="toggle-vis" data-column="14"><em>Interview Form</em></a></li>
                        <li><a class="toggle-vis" data-column="15"><em>Interview 2 Date</em></a></li>
                        <li><a class="toggle-vis" data-column="16"><em>Interview 2 Form</em></a></li>
						<li><a class="toggle-vis" data-column="17"><em>Approval</em></a></li>
						<li><a class="toggle-vis" data-column="17"><em>Status</em></a></li>
						<li><a class="toggle-vis" data-column="18"><em>On-Hold</em></a></li>					
                    </ul>
                </div>
				<div class="export-to-csv"><input type="button" onclick="funexport()" class="ecsvbutton" value="Export To CSV"></div>
                <table id="data" cellspacing="0" cellpadding="0" border="0" class="display nowrap cell-border" width="50">
                    <thead>
                        <tr>
                            <th data-head="Sr. No." style="z-index: 1 !important;"><em>Sr. No.</em></th>
							<th data-head="Candidate Name" class="sorting" style="z-index: 1 !important;"><em>Candidate Name</em></th>
							<th data-head="Designation" class="sorting"><em>Designation</em></th>
							<th data-head="Mobile Number" class="sorting"><em>Mobile Number</em></th>
							<th data-head="Access Key" class="sorting"><em>Access Key</em></th>
							<th data-head="Registration Date" class="sorting"><em>Registration Date</em></th>
							<th data-head="Assessment Date" class="sorting"><em>Assessment Date</em></th>                       
                            <th data-head="Aptitude" class="sorting"><em>Aptitude</em></th>		
                            <th data-head="Attitude" class="sorting"><em>Attitude</em></th>									
                            <th data-head="Mechanical" class="sorting"><em>Mechanical</em></th>									
                            <th data-head="Assessment Status" class="sorting"><em>Assessment Status</em></th>
							<th data-head="Assessment Report" class="sorting"><em>Assessment Report</em></th>
                            <th data-head="Registration Form" class="sorting"><em>Registration Form</em></th>
                            <th data-head="Interview Date" class="sorting"><em>Interview Date</em></th>
                            <th data-head="Interview Form" class="sorting"><em>Interview Form</em></th>
                            <th data-head="Interview 2 Date" class="sorting"><em>Interview 2 Date</em></th>
                            <th data-head="Interview 2 Form" class="sorting"><em>Interview 2 Form</em></th>
							<th data-head="Approval" class="sorting"><em>Approval</em></th>
							<th data-head="Status" class="sorting"><em>Status</em></th>
                            <th data-head="On-Hold" class="sorting"><em>On-Hold</em></th>
                        </tr>
                    </thead>
                    <tbody>
                    <%int i=1; %>
                    <c:forEach items="${participantList}" var="participant">
                        <tr>
                            <td><%=i %></td>
                           <td>${participant.participantName }</td>
							<td>${participant.designation}</td>
							<td>${participant.mobile}</td>
							<td>${participant.accesskey}</td>
							<td>${participant.dateOfRegistration}</td>
							<td>${participant.assessment_Completion_date}</td>
                             <td class="text-center">
							 <c:choose>
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
                               <c:when test="${participant.attitude >= 12 }">
							    <span class="green">${participant.attitude} </span>
								 </c:when>
                               <c:when test="${participant.attitude < 12 }">
							    <span class="red">${participant.attitude} </span>
								</c:when>
							    </c:choose>
							    </td>
							    <td>
							 <c:choose> 
                               <c:when test="${participant.mechanical >= 12 }">
							    <span class="green">${participant.mechanical} </span>
								 </c:when>
                               <c:when test="${participant.mechanical < 12 }">
							    <span class="red">${participant.mechanical} </span>
								</c:when>
							    </c:choose>
							    </td>								
							 <c:choose>
                               <c:when test="${participant.passFailStatus == '1' }">
                                  <td><span class="green">Pass</span></td>
                               </c:when>
                               <c:when test="${participant.passFailStatus == '0' }">
                                  <td ><span class="red" >Fail</span></td>
                               </c:when> 
                               </c:choose>	
                               
                               <td><a href="#"><img src="./img/pdf-icn.svg"  onclick="openReport('${participant.accesskey}','${participant.participantName }','${participant.email }','${participant.mobile }')"/></a></td>
                            
                            <td><a href="#" class="view-btn" onclick="openProfile('${participant.accesskey}')">View</a></td>
                            <td><span class="fixdate"  style="cursor: default !important;">${participant.interViewDate}</span></td>
							<td>
  								<c:choose>
    								<c:when test="${not empty participant.interViewDate}">
                             			<a href="#" class="view-btn green"  onclick="openIterviewForm('${participant.accesskey}',1)">View</a>
    								</c:when>
    								<c:otherwise>
    									<span>--</span>
    								</c:otherwise>
  								</c:choose>
							</td>
                            <td><span class="fixdate"  style="cursor: default !important;">${participant.interViewDate2}</span></td>
                           
                          <td>
  								<c:choose>
    								<c:when test="${not empty participant.interViewDate2}">
                             			<a href="#" class="view-btn green"  onclick="openIterviewForm('${participant.accesskey}',2)">View</a>
    								</c:when>
    								<c:otherwise>
    									<span>--</span>
    								</c:otherwise>
  								</c:choose>
							</td>
                            <td>
								<c:choose>
									<c:when test="${participant.hiredStatus == 'P'}"><span>Approval Pending</span> </c:when>
									<c:otherwise><span>--</span></c:otherwise>
								</c:choose>
							</td>
							<td>
								<c:if test="${participant.partStatus eq 'Assessment'}">
									<span>Assessment Completed</span>
								</c:if>
								<c:if test="${participant.partStatus eq 'Document'}">
									<span>Document Uploaded</span>
								</c:if>
								<c:if test="${participant.partStatus eq 'Final'}">
									<span>Final Submitted</span>
								</c:if>
								<c:if test="${participant.partStatus eq 'Schedule1'}">
									<span>Interview 1 Scheduled</span>
								</c:if>
								<c:if test="${participant.partStatus eq 'pass1'}">
									<span>Interview 1 Cleared</span>
								</c:if>
								<c:if test="${participant.partStatus eq 'fail1'}">
									<span>Interview 1 Not Cleared</span>
								</c:if>
								<c:if test="${participant.partStatus eq 'Schedule2'}">
									<span>Interview 2 Scheduled</span>
								</c:if>
								<c:if test="${participant.partStatus eq 'pass2'}">
									<span>Interview 2 Cleared</span>
								</c:if>
								<c:if test="${participant.partStatus eq 'fail2'}">
									<span>Interview 2 Not Cleared</span>
								</c:if>
							</td>
                            <td>
							 <span class="view-btn re-attempt" style="cursor: pointer; margin-left: 10px;" onclick="openUnholddPopup('${participant.accesskey}')">Release</span>
                            </td>
                           
                        </tr>
                        <%i++; %>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    
  <div class="hold-popup">
        <p>Are you sure you want to release the candidate?</p>
        <div class="form-button">
            <button class="cancel-btn outline-btn" onclick="unHoldNo()">No</button>
            <button class="submit-btn" onclick="unHold()">Yes</button>
            <input type="hidden"  value="" id="reAttempAccesskey">
        </div>
    </div>
    <div class="blk-bg"></div>
    
    <script>
      $(document).ready(function () {
        	  var form = $('#formFilter');
        	  form.attr('action', 'viewHoldHre');
            
            $('.fixdate-popup .submit-btn, .fixdate-popup .cancel-btn').on('click', function(){
                $('.fixdate-popup, .blk-bg, .fixdate-2nd-btn').hide();
                return false;
            });
            
      });
      
 
      function opentInterview(key){
            //var key =   $('#accesskey').val();
  	        mywindow=window.open("interviewForm?accesskey="+key,"detailwindow","resizable=1,scrollbars=1,width=1170,height=600");
  	       mywindow.moveTo(120,90);
       }
	   
	    function openReport(key,name,email,mobile){
	        mywindow=window.open("<%=assessUrl%>player/viewAssessment.jsp?accesskey="+key+"&name="+name+"&email="+email+"&mobile="+mobile+"&testid=44&attemptid=1","detailwindow","resizable=1,scrollbars=1,width=1170,height=600");
	       mywindow.moveTo(120,90);
     }
      
      
      function openProfile(key){
    	  window.location.href="profileDetails?accesskey="+key;
      }
      
      function openIterviewForm(key, count){
    	  mywindow=window.open("printInterviewForm?accesskey="+key+"&interviewCount="+count, "detailwindow","resizable=1,scrollbars=1,width=1170,height=600");
	       mywindow.moveTo(120,90);  
      }
      function openUnholddPopup(key)
  	{
  	    $("#reAttempAccesskey").val(key);
  	    $('.hold-popup, .blk-bg').show();
  	    
  	}
    function unHoldNo(){
  	   $('.hold-popup, .blk-bg').hide();
    }
    
    function  unHold(){
    	var accesskey =   $("#reAttempAccesskey").val();
    	$('.delete-popup, .blk-bg').hide(); 
    	  
	       
	       $.ajax({
			    url: 'holdUnHoldParticpant',
			    type:'post',
				data:'accesskey='+accesskey+'&status=I',
				success:function(res){
					  location.reload(); 				        	 
				 },
				 error:function(ress){
					window.close();
				 }
			});  
     }
     
    function funexport()
	{	
		var dateFrom =$('#dateFromm').val();
		var dateTo =$('#dateToo').val();
		 var form = document.createElement("form");
		 form.method="post";
		 form.action="./onHoldCSV?dateFromm="+dateFrom+"&dateToo="+dateTo;
		 document.body.appendChild(form);
		 form.submit();
	}
    
    
    function search()
	{	
    	var outlet = $('#outlet').val();
		var name =$('#candidateName').val();
		var uniqueCode =$('#uniqueCode').val();
		var desg =$('#desg').val();
		var mspinS =$('#mspinS').val();
		var passFail =$('#passFail').val();
		var dateFrom =$('#dateFromm').val();
		var dateTo =$('#dateToo').val();	
		 var form = document.createElement("form");
		 form.method="post";
		 form.action="./holdFilterParticipant?outlet="+outlet+"&candidateName="+name+"&uniqueCode="+uniqueCode+"&designation="+desg+"&mspin="+mspinS+"&passFailStatus="+passFail+"&dateFromm="+dateFrom+"&dateToo="+dateTo;
		 document.body.appendChild(form);
		 form.submit();
	}
    
    
        </script>
  </body>
  <style>
     @media  (max-width: 820px){
				.page-filters-filter-block {width: 465px !important;}
				.page-filters-process-block {width: 450px !important;}
			}
      
        
        @media (max-width: 767px){
            .page-filters-filter-block, .page-filters-process-block {width: 330px !important;}
            .page-filters-process-block{width: 330px !important; }

          }
          @media (max-width: 426px){
            .page-filters-filter-block, .page-filters-process-block {width: 300px !important;}
            .page-filters-process-block{width: 330px !important;left: -135px !important;}

        }
          @media (max-width: 376px){
            .page-filters-filter-block, .page-filters-process-block {width: 280px !important;}
            .page-filters-process-block{width: 330px !important;left: -125px !important;}}

          @media (max-width: 320px){
            .page-filters-filter-block, .page-filters-process-block {top: 130px !important;width: 255px !important;left: 15px;}              
            .page-filters-process-block {width: 300px !important;top: 130px !important;left: 10px !important;}
            button.page-filters-process {right: -15px !important;}
}
        
  </style>
</html>
<%
 }catch(Exception e)
    {
    	 System.out.println("Errror....."+e);
    	  response.sendRedirect("login");
    }%>
