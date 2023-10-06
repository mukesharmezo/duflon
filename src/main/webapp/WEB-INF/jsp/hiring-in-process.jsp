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
    String baseServer = resource.getString("client.url");String title = resource.getString("app.title");
	String assessUrl = resource.getString("client.asseesment");
HttpSession s = request.getSession();
s.removeAttribute("remove_final");
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
    <link rel="stylesheet" type="text/css" href="css/dashboard-filter.css">
	 <link rel="stylesheet" type="text/css" href="./css/sweetalert.css"/>
	<link rel="stylesheet" type="text/css" href="./css/jquery.datatable.min.css"/>
    <link rel="stylesheet" type="text/css" href="./css/datatable.css">
    <link rel="stylesheet" type="text/css" href="./css/select2-4.0.13.min.css" />
    <link rel="stylesheet" type="text/css" href="./css/hiring-in-process.css" />
    <script src="./js/jquery-3.7.0-min.js"></script>
	<script src="./js/select2-4.0.13.min.js"></script> 
    <script type="text/javascript" src="./js/sweetalert.min.js"></script>
    <script src="./js/jquery.dataTables.min.js"></script>
	<script src="https://cdn.datatables.net/fixedcolumns/4.2.1/js/dataTables.fixedColumns.min.js"></script>
	<script src="./js/datatable.js"></script>
		<style>
			.dataTables_scrollBody {overflow-y: hidden !important;overflow-x: auto !important;}
			.dataTables_wrapper .dataTables_filter input{padding: 10px 0px 10px 0px !important;}

			@media  (max-width: 820px){
				.table-date {top: 55px !important;}
			}
			@media  (max-width: 768px){
          .page-filters-filter-block .form-section .form-block{width: calc(100% - 20px) !important;}
          .page-filters-filter-block {width: 400px !important;}
		  .communications-popup {width: 650px !important;}
		  .table-date{top: 50px !important;}
        } 
		
        @media  (max-width: 767px)  {
          .page-filters-filter-block .form-section .form-block{width: calc(100% - 20px) !important;}
          .page-filters-filter-block {width: 390px !important;}
        }
		@media  (max-width: 426px)  {
			.fixdate-popup{width: 350px !important;}
			textarea#addressarea {width: 290px !important;}
			.communications-popup .form-section .form-block{width: calc(100% - 20px) !important;}
			.communications-popup {width: 385px !important;}
			.page-filters-process-block {
    width: 350px !important;
    left: -135px !important;}
		  }
		  @media  (max-width:400px){
			.communications-popup .form-section .form-block{width: calc(100% - 20px) !important;}
    		.page-filters-filter-block {width: 350px !important;}
			.page-filters-process-block{width: 320px !important; left: -150px !important;}
			
  		}
		  @media (max-width: 376px){
			.add-remove-columns.irc-add-remove-columns{margin: 0 !important;} 
			.fixdate-popup{width: 300px !important;}
			textarea#addressarea {width: 240px !important;}
			.communications-popup .form-section .form-block{width: calc(100% - 20px) !important;}
			div#data_filter {margin-top: -30px !important;}
            .export-to-csv {top: 0px !important;left: 0 !important;}
			.page-filters-process-block{width: 320px !important; left: -150px !important;}
  			.page-filters-filter-block .form-section .form-block, .page-filters-process-block .form-section .form-block {width: calc(100% - 20px) !important;}
  			.page-filters-filter-block {width: 350px !important;}}
			

			@media (max-width: 320px){
				button.page-filters-filter {margin-right: 30px !important;}
				.page-filters-block {display:contents !important; right:30px !important;}
				.table-date {top: 50px !important;}
				div#data_filter {margin-top: -30px !important;}
                .export-to-csv {top: 0px !important;left: 0 !important;}
				.user-panel {right: 4px !important;}
				.communications-popup {width: 300px !important;}
				.communications-popup .form-section .form-block{width: calc(100% - 20px) !important;}
				.fixdate-popup{width: 300px !important;}
				.add-remove-columns{top:-45px !important;left: 0;}
  				.page-filters-filter-block .form-section .form-block, .page-filters-process-block .form-section .form-block {width: calc(100% - 20px) !important;}
  				.page-filters-filter-block {width: 300px !important; top: 152px !important;left: -20px !important;}
				.page-filters-filter-block, .page-filters-process-block{margin-left: 35px;width: 255px !important;top: 145px !important;}
				.page-filters-process-block {
    margin-left: 200px;
    width: 255px !important;
    top: 145px !important;
}
        }
        
        .table-responsive{margin: 20px 0;}
        .table-responsive table{border-left: 1px solid #ccc; border-top: 1px solid #ccc; width: 100%; box-sizing: border-box;}
.table-responsive table tr th{border-right: 1px solid #fff; border-bottom: 1px solid #fff; font-size: 14px; line-height: 18px; font-weight: bold; color: #fff; background-color: #dc3545; padding: 10px; text-align: center;}
        .table-responsive table tr td{border-right: 1px solid #ccc; border-bottom: 1px solid #ccc; font-size: 14px; line-height: 18px; color: #333; padding: 10px; text-align: center;}
        .sweet-alert{left: 51% !important;}
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
			<h1  >In Progress</h1>
       		 <div class="page-filter-include">
		  				<%@include file="./filter/page-filter.jsp"%>
				 </div>
        <div class="container-1100">
            <div class="table-date">
				<div class="add-remove-columns irc-add-remove-columns">
                    <span>Add/Remove Columns</span>
                    <ul>
                       <!--  <li><a class="toggle-vis" data-column="0"><em>Sr. No.</em></a></li>
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
                        <li><a class="toggle-vis" data-column="13"><em>LM Invitation</em></a></li>
                        <li><a class="toggle-vis" data-column="14"><em>Interview Date</em></a></li>
                        <li><a class="toggle-vis" data-column="15"><em>Interview Form</em></a></li>
                        <li><a class="toggle-vis" data-column="16"><em>Interview 2 Date</em></a></li>
                        <li><a class="toggle-vis" data-column="17"><em>Interview 2 Form</em></a></li>
						<li><a class="toggle-vis" data-column="18"><em>Approval</em></a></li>
						<li><a class="toggle-vis" data-column="19"><em>Status</em></a></li>
						<li><a class="toggle-vis" data-column="20"><em>On-Hold</em></a></li>						
                    </ul>
                </div>
				 <div class="export-to-csv"><input type="button" onclick="funexport()" class="ecsvbutton" value="Export To CSV"></div>
                <table id="data" cellspacing="0" cellpadding="0" border="0" class="stripe display nowrap cell-border" width="50" >
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
                            <th data-head="LM Invitation" class="sorting"><em>LM Invitation</em></th>
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
							<td>
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
							<td>
							 <c:choose>
                               <c:when test="${participant.passFailStatus == '1' }">
                                  <span class="green">Pass</span>
                               </c:when>
                               <c:when test="${participant.passFailStatus == '0' }">
                                  <span class="red" >Fail</span>
                                  <c:choose>
                                  	<c:when test="${participant.reAttempCount < 10 }">
                                  		<span class="view-btn re-attempt" style="cursor: pointer; margin-left: 10px;" onclick="showReAttempPop('${participant.accesskey}')">Re-attempt</span>
                                  	</c:when>
                                  	<c:otherwise> <span class="fixdate" >Max attempts reached</span></c:otherwise>
                                  </c:choose>
                                </c:when> 
                               </c:choose>	
							</td>
                            <td>
							<Span><a href="#"><img src="./img/pdf-icn.svg"  onclick="openReport('${participant.accesskey}','${participant.participantName }','${participant.email }','${participant.mobile }')"/></a></span>
							</td>
							<td>
							<c:choose>
                            	<c:when test="${participant.passFailStatus == '1' }">
                            		<span> <a href="#" class="view-btn" onclick="openProfile('${participant.accesskey}')">View</a></span>
                            	</c:when>
                            	<c:when test="${participant.passFailStatus == '0' }">
                            		<span>--</span>
                            	</c:when>
                            </c:choose>
							</td>
							<td>
							<c:choose>
							<c:when test="${participant.docStatus != 'final' }">
							<span>--</span>
							</c:when>
							<c:when test="${participant.docStatus == 'final' && participant.interViewStatus == ''  }">
								<span> <a href="#" class="view-btn" onclick="openInvitation('${participant.accesskey}','${participant.participantName}')">Invite</a></span>
							</c:when>
							<c:otherwise>                                
                                    <span >Invited</span>
                                 </c:otherwise>
							</c:choose>
							</td>
							
						<!-- Interview 1 -->
							<c:choose>
							  <%--   <c:when test="${ participant.passFailStatus == '0'  }"> --%>
							    <c:when test="${participant.docStatus != 'final' }">
                                  <td><span>--</span></td>
                               </c:when>
							   <c:when test="${participant.interViewStatus == 'final' }">
                                 <td ><span class="fixdate" style="cursor: default !important;">${participant.interViewDate}</span></td>
                               </c:when>
                               <c:when test="${participant.interViewDate == '' }">
                                  <td onclick="openDateTime('${participant.accesskey}','','${participant.participantName }','',1)"><span class="fixdate" >Fix Date</span></td>
                               </c:when>
							    <c:when test="${participant.interViewDate != '' }">
                                  <td onclick="openDateTime('${participant.accesskey}','${participant.interviewAddress}','${participant.participantName }','${participant.interViewDate}',1)"><span class="fixdate" >${participant.interViewDate}</span></td>
                               </c:when>
                                 <c:otherwise>                                
                                    <td ><span class="fixdate" >--</span></td>
                                 </c:otherwise>
                               </c:choose>
                               
                               <c:set var = "trimDate" value="${fn:substring(participant.interViewDate, 0, 10)}"/>
                           		<fmt:parseDate value="${trimDate}" var="parsedDate" pattern="dd/MM/yyyy" />
                               <fmt:formatDate var="intDate" value="${parsedDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
    					 		<c:set var="today" value="<%=new java.util.Date()%>"/>
								<fmt:formatDate var="todayDate" value="${today}" pattern="yyyy-MM-dd HH:mm:ss"/>   
                           <td>				
                            <c:choose>
                               <c:when test="${participant.interViewStatus == 'final'}">
                               <span> <a href="#" class="view-btn green"  onclick="opentInterview('${participant.accesskey}' , 1)">View</a> </span>
                               </c:when>
                               <c:when test="${not empty participant.interViewDate && intDate le todayDate}">
                               <span> <a href="#" class="view-btn green"  onclick="opentInterview('${participant.accesskey}' , 1)">Fill</a> </span>
                               </c:when>
								  <c:when test="${participant.interViewDate == ''}">
                                      <Span>--</span>
                                 </c:when>
                               <c:otherwise>
                                    <span> --</span>
                               </c:otherwise>
							   </c:choose>
							</td>

							<!-- Interview 2 -->
							<c:choose>
							    <c:when test="${ participant.interViewStatus == ''  }">
                                  <td><span>--</span></td>
                               </c:when>
							   <c:when test="${participant.interViewStatus2 == 'final' }">
                                 <td ><span class="fixdate" style="cursor: default !important;">${participant.interViewDate}</span></td>
                               </c:when>
                               <c:when test="${participant.interViewDate2 == '' && participant.interViewStatus == 'final'}">
                                  <td onclick="openDateTime('${participant.accesskey}','','${participant.participantName }','',2)"><span class="fixdate" >Fix Date</span></td>
                               </c:when>
							    <c:when test="${participant.interViewDate2 != '' }">
                                  <td onclick="openDateTime('${participant.accesskey}','${participant.interviewAddress2}','${participant.participantName }','${participant.interViewDate2}',2)"><span class="fixdate" >${participant.interViewDate2}</span></td>
                               </c:when>
                                 <c:otherwise>                                
                                    <td ><span class="fixdate" >--</span></td>
                                 </c:otherwise>
                               </c:choose>
                               
                               <c:set var = "trimDate2" value="${fn:substring(participant.interViewDate2, 0, 10)}"/>
                           		<fmt:parseDate value="${trimDate2}" var="parsedDate2" pattern="dd/MM/yyyy" />
                               <fmt:formatDate var="intDate2" value="${parsedDate2}" pattern="yyyy-MM-dd HH:mm:ss"/>
    					 		<c:set var="today2" value="<%=new java.util.Date()%>"/>
								<fmt:formatDate var="todayDate2" value="${today2}" pattern="yyyy-MM-dd HH:mm:ss"/>   
								
								
                           <td>
                            <c:choose>
                               <c:when test="${participant.interViewStatus2 == 'final'}">
                               <%-- <Span> <a href="#" class="view-btn green"  onclick="opentInterviewForm('${participant.accesskey}' , 2)">View</a> </span> --%>
                               <Span> <a href="#" class="view-btn green"  onclick="opentInterview('${participant.accesskey}' , 2)">View</a> </span>
                               </c:when>
							    <c:when test="${(participant.interViewDate2 != '') && (intDate2 le todayDate2)}">
                                 <span><a href="#" class="view-btn green" onclick="opentInterview('${participant.accesskey}' , 2)">Fill</a></span>
                                 </c:when>
								  <c:when test="${(participant.interViewStatus2 == 'save' || participant.interViewDate2 != ''  ) && ( participant.passFailStatus == '1')
								&& (participant.regStatus == '1' && participant.passFailStatus == '1' && participant.intterviewFormStatus2  eq '1') && participant.interViewPassFailStatus2 == 'fail' }">
                                 <span><a href="#" class="view-btn red" onclick="opentInterview('${participant.accesskey}' , 2)">Fill</a></span>
                                 </c:when>
                                 <c:when test="${(participant.interViewStatus2 == 'save' || participant.interViewDate2 != '') 
								 && (participant.regStatus == '1' && participant.passFailStatus == '1')  
                                   && (participant.intterviewFormStatus2  eq '1')}">
                                 <span><a href="#" class="view-btn" onclick="opentInterview('${participant.accesskey}' , 2)">Fill</a></span>
                                 </c:when>
								  <c:when test="${empty participant.interViewDate2}">
                                      <span>--</span>
                                 </c:when>
                               <c:otherwise>
                                    <span> ---</span>
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
							 <span class="view-btn re-attempt" style="cursor: pointer; margin-left: 10px;" onclick="openOnholdPopup('${participant.accesskey}')">On Hold </span>
							</td>
                        </tr>
                        <%i++; %>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
 <div class="fixdate-popup" style="width: 60%;">
        <h2>Interview Date</h2>
        <div class="form-section">
            
            <div class="form-block">
                <h5>Date</h5>
                <input type="date" value="" id="date" style="text-transform: uppercase !important;" />
            </div>
            <div class="form-block">
                <h5>Time</h5>
				<input type="time" id="time" name="time" value="10:00" min="09:00" max="21:00" required>
            </div>
			 <div class="form-block">
			 <br>
			 <h5>Address</h5>
       	<textarea rows="4" cols="50" name="addressarea" id="addressarea" placeholder="Address/Meeting Link" maxlength="200" required="required">${participant.interviewAddress}</textarea>
        <input type="hidden" id="intCounter" name="intCounter"  value="0">
        </div>
			<div class="form-block">
				<br>
				<h5>Line Manager</h5>
				<select id="select-email" multiple="multiple"  style="width: 100% !important;" class="form-block">
					<%-- <c:forEach items="${map}" var="entry">
						<option value="${entry.key}">${entry.value}</option>
					</c:forEach> --%>
				</select>
			</div> 
		</div>
		 <div class="table-responsive">
				<table cellspacing="0" cellpadding="0"  >
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
        <div class="text-center">
            <input class="cancel-btn outline-btn" onclick="btndDateCancel()" value="Cancel" type="button">
            <button class="submit-btn" onclick="submit()" id="btndDate">OK</button>
             <input type="hidden" id="accesskey" name="accesskey" />
			  <input type="hidden" id="canName" value="" />
        </div>
       
    </div>
    
	<div class="delete-popup">
        <p>Are you sure, you want to allow a re-attempt of assessment for the candidate?</p>
        <div class="form-button">
            <button class="cancel-btn outline-btn" onclick="no()">No</button>
            <button class="submit-btn" onclick="reAtemmp()">Yes</button>
            <input type="hidden"  value="" id="reAttempAccesskey">
        </div>
    </div>
	
	 <div class="hold-popup">
        <p>Are you sure you want to hold the candidate's application?</p>
        <div class="form-button">
            <button class="cancel-btn outline-btn" onclick="onHoldNo()">No</button>
            <button class="submit-btn" onclick="onHold()">Yes</button>

            <input type="hidden"  value="" id="reAttempAccesskey">
        </div>
    </div>
	<div class="invite-popup full-block-popup">
        <div class="form-section">
            <div class="form-block" id="datetime-container">
                <!-- Initial Date Time Input -->
                <div class="datetime-input">
                    <h5>Date Time</h5>
                    <input type="datetime-local" name="datetime" id="inviteDate" required>
                </div>
            </div>
        </div>
            <button id="add-datetime">Add More</button>
            <div class="form-section">
            <div class="form-block">
				<h5>Line Manager</h5>
				<select id="select-lm" multiple="multiple"  style="width: 100% !important;" class="form-block">
					<c:forEach items="${map}" var="entry">
						<option value="${entry.key}">${entry.value}</option>
					</c:forEach>
				</select>
			</div>
            </div>
            <div class="text-center">
            <input class="cancel-btn outline-btn" value="Cancel" type="button" id="invite-cancel">
            <button class="submit-btn" onclick="submitInvitation()" id="btndDate">OK</button>
             <input type="hidden" id="access_key" name="accesskey" />
			  <input type="hidden" id="can_Name" value="" />
        </div>
    </div>
    <div class="blk-bg"></div>
    <script>
    // Function to add a new Date Time input
    function addDateTimeInput() {
        const numDateTimeInputs = $(".datetime-input").length;

        if (numDateTimeInputs < 5) {
            const currentDate = new Date();
            const nextMonthDate = new Date();
            nextMonthDate.setMonth(nextMonthDate.getMonth() + 1);

            const minDate = currentDate.toISOString().slice(0, 16); // Format: 'YYYY-MM-DDTHH:MM'
            const maxDate = nextMonthDate.toISOString().slice(0, 16); // Format: 'YYYY-MM-DDTHH:MM'
		console.log('MinDate : '+minDate+'<>Max : '+maxDate);
            const newDateTimeInput = `
                <div class="datetime-input extra-input">
                    <input type="datetime-local" name="datetime" id="inviteDate" required value="`+minDate+`" min="`+minDate+`" max="`+maxDate+`" onkeydown="return false;">
                    <span class="remove-btn">Remove</span>
                </div>`;

            $("#datetime-container").append(newDateTimeInput);

            // Add an event listener to the newly created "Remove" button
            $(".remove-btn").last().on("click", function () {
                $(this).parent(".datetime-input").remove(); // Remove the corresponding input
            });
        } else {
            swal({
                title: "You can add only 5 date and time.",
                showCancelButton: false,
                confirmButtonColor: "#DC3545",
                confirmButtonText: "OK",
                closeOnConfirm: true
            });
        }
    }

    // Add Date Time input when the button is clicked using jQuery
    $("#add-datetime").click(addDateTimeInput);
</script>
	<script>
      $(document).ready(function () {
    	  
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
    	  
    	  
    	  $('#select-lm').select2({
    	        tags: false, // Allow custom tags
    	        tokenSeparators: [','], // Specify token separators for custom tags
    	        placeholder: 'Select Interviewer', // Default placeholder text
    	        width: '300px' // Width of the dropdown
    	        //maximumSelectionLength: 3
    	      });/*.on('select2:selecting', function(e) {
    	    	    var currentValue = $(this).val();
    	    	    if (currentValue && currentValue.length >= 3) {
    	    	       e.preventDefault(); // Prevent selecting new tags if the maximum limit is reached
    	    	    }
    	    	});*/
    	    	
    	    	//It will not allow user to enter date manually
    	    	$("#inviteDate").on("keydown", function(e) {
                    e.preventDefault();
                });
    	    	
    	    	$('#invite-cancel').click(function (){
    	    		$('.invite-popup, .blk-bg').hide(); 
    	    	});
    	  var form = $('#formFilter');
    	  form.attr('action', 'viewProcess');
      });
	  function submitInvitation(){
		    var dateTimes = $('input[name="datetime"]').map(function() {
		        return this.value;
		    }).get();
		    var isEmpty = dateTimes.some(function(date) {
		        return date.trim() === '';
		    });
		    var hasDuplicates = dateTimes.some(function(date, index, array) {
	            return array.indexOf(date) !== index;
	        });
		    if (isEmpty) {
		        swal({
		            title: "Please choose date and time.",
		            showCancelButton: false,
		            confirmButtonColor: "#DC3545",
		            confirmButtonText: "OK",
		            closeOnConfirm: true
		        });
		    }
		    if (hasDuplicates) {
		        swal({
		            title: "Please choose different date and time.",
		            showCancelButton: false,
		            confirmButtonColor: "#DC3545",
		            confirmButtonText: "OK",
		            closeOnConfirm: true
		        });
		    }
		    var selectedEmails = $('#select-lm').val();
		    if (selectedEmails.length < 1) {
		        swal({
		            title: "You must select a line manager.",
		            showCancelButton: false,
		            confirmButtonColor: "#DC3545",
		            confirmButtonText: "OK",
		            closeOnConfirm: true
		        });
		    }
		    
		    var access_key  = $("#access_key").val();
		    var data = {
		        'datetime': dateTimes,
		        'select-email': selectedEmails,
		        'accesskey':access_key
		    };
		   // alert(dateTimes);
		   if (selectedEmails.length >= 1 && !isEmpty && !hasDuplicates) {
		    $.ajax({
		        type: 'POST',
		        url: 'inviteLM', 
		        data: JSON.stringify(data),
		        contentType: 'application/json',
		        success: function(response) {
		        	 swal({   
						  title: "Emails have been sent",     
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
		   }
	  }
	  function btndDateCancel(){
		   $('#btndDate').prop('disabled', false);
			 $('#btndDate').val('Please wait');
		$('.fixdate-popup, .blk-bg, .fixdate-2nd-btn').hide(); 
        return false;		
	  }
      
	  function openInvitation(accesskey, name){
		  console.log(accesskey+'<>'+name);
		  $('#access_key').val(accesskey);
			$('#can_Name').val(name);
		  $('.invite-popup, .blk-bg').show();
	  }
	  
      function openDateTime(key,temp,name,dateNtime,intCount)
  	{ 
  		$('#accesskey').val(key);
		$('#canName').val(name);
		if(dateNtime.length>5){
			 dateNtime=dateNtime.split(",");
		var dateValue = dateNtime[0].split('/');
        var date = new Date(dateValue[2], dateValue[1] - 1, +dateValue[0]);
		$('#date').val(dateValue[2]+'-'+dateValue[1]+'-'+dateValue[0]); 
		$('#time').val(getTwentyFourHourTime(dateNtime[1]));
		}
		$('#addressarea').text(temp);
		$('#intCounter').val(intCount);
		$.ajax({
			url: 'getInvitedLM',
	         type:'post',
	         data:'accesskey='+key+'&intCount='+intCount,
	         success:function(jsonObject){
	        	 var jsonRes = JSON.parse(jsonObject);
	        	 $("#select-email").html(jsonRes.select2Lm);
                // Initialize the select2 dropdown
                $("#select-email").select2();
                //$("#dateSelect option:first").prop("selected", true);
                //Now set for table
                if(intCount === 1){
               		$("#dateBody").html(jsonRes.tableData)
                	$('.table-responsive').show();
                }else{
                	$('.table-responsive').hide();
                }
                $('.fixdate-popup, .blk-bg').show();
	    	  },
	          error:function(ress){
				window.close();
	    	  }
		});
  	}
	
	function getAdddress(accesskey){
    	  var accesskey="";
    	  $.ajax({
		      url:  'getAddress',
		      type: 'POST',
		      data: 'photoStatus='+status,
		      success: function (res) {
		    	  accesskey = res;
		      }
		    });
    	  return accesskey;
      }

	function getTwentyFourHourTime(amPmString) { 
        var d = new Date("1/1/2013 " + amPmString); 
		
		var h="",m="";
		var hh = d.getHours()+"";
		var mm = d.getMinutes()+"";
		if(hh.length == 1){
		   h = "0"+hh;	
		}else{
		 h = hh;		
		}
		if(mm.length == 1){
		   m = "0"+mm;	
		}else{
			m = mm;	
		}
        return h + ':' + m; 
    }
	
	
	function onTimeChange() {
  var inputEle = document.getElementById('time');
  var timeSplit = inputEle.value.split(':'),
    hours,
    minutes,
    meridian;
  hours = timeSplit[0];
  minutes = timeSplit[1];
  
  if (hours > 12) {
    meridian = 'PM';
    hours -= 12;
  } else if (hours < 12) {
    meridian = 'AM';
    if (hours == 0) {
      hours = 12;
    }
  } else {
    meridian = 'PM';
  }
  return hours + ':' + minutes + ' ' + meridian;
}
      
      function submit(key)
    	{    	
		     $('#btndDate').prop('disabled', true);
			 $('#btndDate').val('Please wait');
           var name =$('#canName').val();		
    	   var date =  $('#date').val()
		   var interviewAddress= $('#addressarea').val();
    	   var selectedEmails = Array.from($('#select-email')[0].selectedOptions, option => option.value); // Extract selected values as an array
    	   var simpleEmails = JSON.stringify(selectedEmails);
    	   var intCount2=$('#intCounter').val();
    	  // var time =  $('#time').val()
		 var time = onTimeChange();
    	   var accesskey = $('#accesskey').val();
		    if(date == ""){
    		   swal("Please select date"); 
    		   return false; 
    	   }
		   if(time == ""){
    		   swal("Please select time");  
    		   return false;
    	   }
		   if(interviewAddress == ""){
    		   swal("Please enter address");  
    		   return false;
        	   }
		   var selectedValue = $('#select-email').val();
		   if (selectedValue.length < 1) {
		     swal("Please select a line manager");
		     return false;
		   }
            var date1 = new Date(date);
           var newDate=  (date1.getDate())+"/"+(date1.getMonth()+1)+"/"+(date1.getFullYear());			
		  $('.fixdate-popup, .blk-bg').hide();
		 swal({   
					  title: "You have selected "+ newDate +" and "+ time +" for interviewing  "+ name +". Do you want to send the communication?",     
					  showCancelButton: true,
					  confirmButtonColor: "#DC3545",   
					  confirmButtonText: "Yes", 
                      cancelButtonText: "No",					  
					  closeOnConfirm: false },
					  function(isConfirm){
					  if(isConfirm){
						 $('.confirm').prop('disabled', true);
						  var fd = new FormData();
						    
				          fd.append('date',date);
				          fd.append('time',time);
				          fd.append('interviewAddress',interviewAddress);
				          fd.append('emails',simpleEmails);//JSON.stringify(selectedLanguages)
				          fd.append('intCount', intCount2);
				          fd.append('accesskey',accesskey);
				          console.log('Int Count :: '+intCount2);
					  $.ajax({
			    url: 'fixedInterViewDate',
			    enctype: 'multipart/form-data',
			    type:'post',
				data:fd,
				processData: false,
		        contentType: false,
		        cache: false,
		        timeout: 600000,
				success:function(res){	
                      $('.confirm').prop('disabled', false);
                      swal({   
					  title: "Email has been triggered to the candidate.",     
					  showCancelButton: false,
					  confirmButtonColor: "#DC3545",   
					  confirmButtonText: "OK",   
					  closeOnConfirm: false },
					  function(isConfirm){
					  location.reload(); 
					}); 					
				//location.reload(); 				        	 
				 },
				 error:function(ress){
					window.close();
				 }
			}); 
					 }else{
						 
						   $('#btndDate').prop('disabled', false);
			 $('#btndDate').val('Ok');
					 return false;
					}
					}); 
    	}
 
      
      function opentInterview(key, count){
            //var key =   $('#accesskey').val();
  	        mywindow=window.open("interviewForm?accesskey="+key+"&interviewCount="+count,"detailwindow","resizable=1,scrollbars=1,width=1170,height=600");
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
	  
	   function showReAttempPop(key){
    	  
    	  $("#reAttempAccesskey").val(key);
    	  $('.delete-popup, .blk-bg').show();
      }
      
      function no(){
    	  $('.delete-popup, .blk-bg').hide(); 
      }
	  
	    function reAtemmp(){
    	 var accesskey =   $("#reAttempAccesskey").val();
    		 $('.delete-popup, .blk-bg').hide(); 
	       $.ajax({
			    url: 'reAttemp',
			    type:'post',
				data:'accesskey='+accesskey,
				success:function(res){
					 swal({   
					  title: "Email has been triggered to the candidate.",     
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
					  location.reload();
				 }
			});       
      }
	   function openOnholdPopup(key)
  	{
  	    $("#reAttempAccesskey").val(key);
  	    $('.hold-popup, .blk-bg').show();
  	    
  	}
    function onHoldNo(){
  	   $('.hold-popup, .blk-bg').hide();
    }
	  
	  function  onHold(){
    	var accesskey =   $("#reAttempAccesskey").val();
    	$('.delete-popup, .blk-bg').hide(); 
    	  
	       
	       $.ajax({
			    url: 'holdUnHoldParticpant',
			    type:'post',
				data:'accesskey='+accesskey+'&status=H',
				success:function(res){
					 
					  location.reload();  				        	 
				 },
				 error:function(ress){
					window.close();
				 }
			});  
     }
	   
	   $(function(){
    var dtToday = new Date();
    
    var month = dtToday.getMonth() + 1;
    var day = dtToday.getDate();
    var year = dtToday.getFullYear();
    if(month < 10)
        month = '0' + month.toString();
    if(day < 10)
        day = '0' + day.toString();
    
    var maxDate = year + '-' + month + '-' + day;

    // or instead:
    // var maxDate = dtToday.toISOString().substr(0, 10);
    $('#date').attr('min', maxDate);
});
	 
	function funexport()
	{
		var dateFrom =$('#dateFromm').val();
		var dateTo =$('#dateToo').val();
		
		 var form = document.createElement("form");
		 form.method="post";
		 form.action="./inProgressCSV?dateFromm="+dateFrom+"&dateToo="+dateTo;
		 document.body.appendChild(form);
		 form.submit();
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
	 
	 $('em').click(function(){ 
	 
	 var column_name=$(this).html();
	 var status='1';
		 
		 if($(this).parent('a').parent('li').hasClass('active')){
			status='0';
		 } 
	 }); 
                function openFinalSubmit(pKey){    
                    window.location.href="finalSubmit?accesskey="+pKey;
                 }
    </script>
    <script>
    // Get a reference to the date input field
    var datePicker = document.getElementById('date');

    // Disable the input field
    datePicker.addEventListener('keydown', function(event) {
        event.preventDefault();
    });

    // Prevent paste events
    datePicker.addEventListener('paste', function(event) {
        event.preventDefault();
    });
</script>
    
  </body>
</html>
<%
 }catch(Exception e)
    {
    	 System.out.println("Errror....."+e);
    	  response.sendRedirect("login");
    }%>