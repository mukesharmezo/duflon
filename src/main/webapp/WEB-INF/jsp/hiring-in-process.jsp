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
    <link rel="icon" type="image/x-icon" href="<%=baseServer%>img/DuflonFavicon.png"/>   <title><%=title %></title>
    <link rel="stylesheet" type="text/css" href="./css/common.css" />
    <link rel="stylesheet" type="text/css" href="./css/hiring-in-process.css" />
    <link rel="stylesheet" type="text/css" href="css/dashboard-filter.css">

	 <link rel="stylesheet" type="text/css" href="./css/sweetalert.css"/>
    <script type="text/javascript" src="./js/sweetalert.min.js"></script>
	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.12.1/css/jquery.dataTables.min.css">
    <link rel="stylesheet" type="text/css" href="./css/datatable.css">

    

    <script src="./js/jquery-3.4.1.min.js"></script>
    <script src="./js/jquery.dataTables.min.js"></script>
	<script src="https://cdn.datatables.net/fixedcolumns/4.2.1/js/dataTables.fixedColumns.min.js"></script>
	<script src="./js/datatable.js"></script>
		<style>
			.dataTables_scrollBody {overflow-y: hidden !important;overflow-x: auto !important;}
			.dataTables_wrapper .dataTables_filter input{padding: 10px 0px 10px 0px !important;}

			@media  (max-width: 820px){
				/* .page-filters-filter-block {width: 515px !important;} */
				.table-date {top: 55px !important;}
				/* .page-filters-process-block {width: 450px !important;left: -242px !important;} */
			}
			@media  (max-width: 768px){
          .page-filters-filter-block .form-section .form-block{width: calc(100% - 20px) !important;}
          .page-filters-filter-block {width: 400px !important;}
		  .communications-popup {width: 650px !important;}
		  .table-date{top: 50px !important;}
        } 
		
        @media  (max-width: 767px)  {
          .page-filters-filter-block .form-section .form-block{width: calc(100% - 20px) !important;}
          /* .page-filters {margin-top: 60px !important;} */
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
			/* .page-filters {margin-top: 20px !important;} */
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
				/* .page-filters {margin-top: 20px !important;} */
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

       			 <%-- <div class="page-filter-include">
		  				<%@include file="./filter/page-filter.jsp"%>
				 </div> --%>

        <div class="container-1100">
            <div class="table-date">
				<div class="add-remove-columns irc-add-remove-columns">
                    <span>Add/Remove Columns</span>
                    <ul>
                        <li><a class="toggle-vis" data-column="0"><em>Sr. No.</em></a></li>
                        <li><a class="toggle-vis" data-column="1"><em>Candidate Name</em></a></li>
						<li><a class="toggle-vis" data-column="2"><em>Designation</em></a></li>
						<li><a class="toggle-vis" data-column="3"><em>Mobile Number</em></a></li>
						<li><a class="toggle-vis" data-column="4"><em>Access Key</em></a></li>
						<li><a class="toggle-vis" data-column="5"><em>Registration Date</em></a></li>
						<li><a class="toggle-vis" data-column="6"><em>Assessment Date</em></a></li>				
                        <li><a class="toggle-vis" data-column="7"><em>Aptitude</em></a></li>
                        <li><a class="toggle-vis" data-column="8"><em>Attitude</em></a></li>
                        <li><a class="toggle-vis" data-column="9"><em>Assessment Status</em></a></li>
                        <li><a class="toggle-vis" data-column="10"><em>Assessment Report</em></a></li>
						<li><a class="toggle-vis" data-column="11"><em>Registration Form</em></a></li>
                        <li><a class="toggle-vis" data-column="12"><em>Interview Date</em></a></li>
                        <li><a class="toggle-vis" data-column="13"><em>Interview Score</em></a></li>
                        <li><a class="toggle-vis" data-column="14"><em>Interview 2 Date</em></a></li>
                        <li><a class="toggle-vis" data-column="15"><em>Interview 2 Score</em></a></li>
						<li><a class="toggle-vis" data-column="16"><em>Approval</em></a></li>
						<li><a class="toggle-vis" data-column="17"><em>On-Hold</em></a></li>						
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
                            <th data-head="Assessment Status" class="sorting"><em>Assessment Status</em></th>
							<th data-head="Assessment Report" class="sorting"><em>Assessment Report</em></th>
                            <th data-head="Registration Form" class="sorting"><em>Registration Form</em></th>
                            <th data-head="Interview Date" class="sorting"><em>Interview Date</em></th>
                            <th data-head="Interview Score" class="sorting"><em>Interview Score</em></th>
                            <th data-head="Interview Date" class="sorting"><em>Interview 2 Date</em></th>
                            <th data-head="Interview Score" class="sorting"><em>Interview 2 Score</em></th>
							<th data-head="Approval" class="sorting"><em>Approval</em></th>
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
                               <c:when test="${participant.passFailStatus == '1' }">
                                  <span class="green">Pass</span>
                               </c:when>
                               <c:when test="${participant.passFailStatus == '0' }">
                                  <span class="red" >Fail</span>
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
							
							<%-- <c:choose>
                               <c:when test="${participant.interViewPassFailStatus == 'pass' && participant.passFailStatus == '1' && participant.interViewStatus == 'final'}">
                              <span> <a href="#" class="view-btn" onclick="openProfile('${participant.accesskey}')">View</a></span>
                               </c:when>
                               <c:otherwise>
                                    <span> --</span>
                               </c:otherwise>
							   </c:choose> --%>
							</td>
							
						<!-- Interview 1 -->
							<c:choose>
							    <c:when test="${ participant.passFailStatus == '0'  }">
                                  <td><span>--</span></td>
                               </c:when>
							   <c:when test="${participant.interViewStatus == 'final' }">
                                 <td ><span class="fixdate" style="cursor: default !important;">${participant.interViewDate}</span></td>
                               </c:when>
                               <c:when test="${participant.interViewDate == '' }">
                                  <td onclick="openDateTime('${participant.accesskey}','1','${participant.participantName }','',1)"><span class="fixdate" >Fix Date</span></td>
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
                               <c:when test="${participant.interViewStatus == 'final'  && participant.regStatus == '0' && participant.passFailStatus == '1'}">
                               <span> <a href="#" class="view-btn green"  onclick="openIterviewForm('${participant.accesskey}' , 1)">View</a> </span>
                               </c:when>
							    <c:when test="${(participant.interViewStatus == 'save' || participant.interViewDate != '' && participant.intterviewFormStatus  eq '1') 
								&& (participant.regStatus == '1' && participant.passFailStatus == '1') && participant.interViewPassFailStatus == 'pass'  && participant.intterviewFormStatus  eq '1' && intDate le todayDate}">
                                 <Span><a href="#" class="view-btn green" onclick="opentInterview('${participant.accesskey}' , 1)">Fill</a></span>
                                 </c:when>
								  <c:when test="${(participant.interViewStatus == 'save' || participant.interViewDate != ''  ) && ( participant.passFailStatus == '1')
								&& (participant.regStatus == '1' && participant.passFailStatus == '1' && participant.intterviewFormStatus  eq '1') && participant.interViewPassFailStatus == 'fail' }">
                                 <Span><a href="#" class="view-btn red" onclick="opentInterview('${participant.accesskey}' , 1)">Fill</a></span>
                                 </c:when>
                                 <c:when test="${(participant.interViewStatus == 'save' || participant.interViewDate != '') 
								 && (participant.regStatus == '1' && participant.passFailStatus == '1')  
                                   && (participant.intterviewFormStatus  eq '1')}">
                                 <Span><a href="#" class="view-btn" onclick="opentInterview('${participant.accesskey}' , 1)">Fill</a></span>
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
                               <c:when test="${participant.interViewDate2 == '' }">
                                  <td onclick="openDateTime('${participant.accesskey}','1','${participant.participantName }','',2)"><span class="fixdate" >Fix Date</span></td>
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
                               <c:when test="${participant.interViewStatus2 == 'final' && participant.passFailStatus == '1'}">
                               <Span> <a href="#" class="view-btn green"  onclick="openIterviewForm('${participant.accesskey}' , 2)">View</a> </span>
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
								  <c:when test="${participant.interViewDate2 == ''}">
                                      <span>--</span>
                                 </c:when>
                               <c:otherwise>
                                    <span> ---</span>
                               </c:otherwise>
							   </c:choose>
							</td>
                            
							<td>
								<c:choose>
									<c:when test="${participant.hiredStatus == 'Y'}"><span>Recruited</span> </c:when>
									<c:otherwise><span>--</span></c:otherwise>
								</c:choose>
							</td>
							<%-- <td>  ${participant.hiredStatus} </td> --%>
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
 <div class="fixdate-popup">
        <h2>Interview Date</h2>
        <div class="form-section">
            <div class="form-block">
                <h5>Date</h5>
                <input type="date" value="" id="date" style="text-transform: uppercase !important;"  />
            </div>
            <div class="form-block">
                <h5>Time</h5>
				<input type="time" id="time" name="time" value="21:00" min="09:00" max="21:00" required>
            </div>
			 <div class="form-block">
       	<textarea rows="4" cols="50" name="addressarea" id="addressarea" placeholder="Address" maxlength="200" required="required">${participant.interviewAddress}</textarea>
        <input type="hidden" id="intCounter" name="intCounter" >
        </div>
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
	 <div class="designation-popup">
        <p>Are you sure you want to select designation</p>
        <div class="form-button">
            <button class="cancel-btn outline-btn" onclick="hideDesignationPopup()">No</button>
            <button class="submit-btn" onclick="selectDesignation()">Yes</button>
            <input type="hidden"  value="" id="desig_accesskey">
            <input type="hidden"  value="" id="designation">
        </div>
    </div>
	
	   <div class="communications-popup">
        <h3>Data science</h3>
        <form class="form-section" action="">
            <div class="form-block">
              <span> Name</span><br>
              <input type="text" placeholder="Data science Reference ID" id="name" disabled />
            </div>
			 <div class="form-block">  
             <span >Data science reference ID</span> <br>        
            <input type="text" placeholder="Data science reference ID" id="reference" disabled />
            </div>
            <div class="form-block">  
             <span >Data science prediction</span> <br>        
            <input type="text" placeholder="Data science prediction" id="prediction" disabled />
            </div>


            <div class="form-block">
            
			Do you want to conduct an interview? <span style="color:red;">*</span><br>
                      <input type="radio" name="no" id="no" value = "no"><label for="no">No</label>
                      <input type="radio" name="yes" id="yes" value = "yes"><label for="yes">Yes</label>

            </div>
			<div class="form-block" id="div_yes" style="display:none;">
			    Reason <span style="color:red;">*</span>
                <select id="reson_yes" style="margin-top:7px !important;" >
                     <option value="">Select</option>
                     <option value="Experience is relevant">Experience is relevant</option>  
                     <option value="Good communication skills">Good communication skills</option>
                     <option value="Excellent overall personality ">Excellent overall personality </option>
                     <option value="Superior Product/ process knowledge">Superior Product/ process knowledge</option>
                     <option value="High market Influence/ Positive feedback">High market Influence/ Positive feedback</option>
                     <option value="Management decision">Management decision</option>
                     <option value="Fit for profile">Fit for profile</option>  
					 <option value="Interiviewing for other profile">Interviewing for other profile</option>  
					 
                </select>                     
            </div>
            
             <div class="form-block" id="div_no" style="display:none">
			     Reason <span style="color:red;">*</span>
                <select id="reson_no">
                    <option value="">Select</option>
                    <option value="Experience is not relevant">Experience is not relevant</option>
                    <option value="Communication is not good">Communication is not good</option>
                    <option value="Overall personality is not suitable for profile">Overall personality is not suitable for profile</option>
                    <option value="High salary expectation">High salary expectation</option>   
                    <option value="Negative feedback">Negative feedback</option>
                    <option value="Not fit for profile">Not fit for profile</option>                  
                </select>
            </div>
            <div class="form-button">
                <input type="button" class="cancel-btn" onclick="cancle()" value="Cancel"/>
                <input type="button" class="submit-btn" onclick="setReason()" value="Submit" id="btn_submit"/>			
				<input type="button" class="submit-btn" onclick="editDataScience()" value="Edit" id="btn_edit" style="display:none"/>
                <input type="hidden"  value="" id="accesskey"/>
                 <input type="hidden"  value="" id="interview_reason"/>
            </div>
        </form>
    </div>
    <div class="blk-bg"></div>
    <script>
      $(document).ready(function () {
            
      });
	  
	  function btndDateCancel(){
		   $('#btndDate').prop('disabled', false);
			 $('#btndDate').val('Please wait');
		$('.fixdate-popup, .blk-bg, .fixdate-2nd-btn').hide(); 
        return false;		
	  }
      
      function openDateTime(key,temp,name,dateNtime,intCount)
  	{ 
		console.log('1st IC : '+intCount);
  		$('#accesskey').val(key);
		$('#canName').val(name);
		if(dateNtime.length>5){
			 dateNtime=dateNtime.split(",");
		var dateValue = dateNtime[0].split('/');
       // abc();
        var date = new Date(dateValue[2], dateValue[1] - 1, +dateValue[0]);
		$('#date').val(dateValue[2]+'-'+dateValue[1]+'-'+dateValue[0]); 
		$('#time').val(getTwentyFourHourTime(dateNtime[1]));
		$('#addressarea').text(temp);
		$('#intCounter').val(intCount);
		//$('#addressarea').text(getAdddress(key));
		}
  	    $('.fixdate-popup, .blk-bg').show();
  	    
  	}
	
	
	function getAdddress(accesskey){
    	  var accesskey="";
    	  console.log('Call Address : '+accesskey);
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
    	   var intCount2=$('#intCounter').val();
    	   console.log('RD IC : '+intCount2);
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
			if(intCount2 == ""){
				intCount2=2;
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
					  title: "Email and SMS has been triggered to the candidate.",     
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
	        mywindow=window.open("<%=assessUrl%>player/viewAssessment.jsp?accesskey="+key+"&name="+name+"&email="+email+"&mobile="+mobile+"&testid=41&attemptid=1","detailwindow","resizable=1,scrollbars=1,width=1170,height=600");
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


 function openDesignationPopup(key)
  	{ 	  
    	 $("#desig_accesskey").val(key);
  	     $('.designation-popup, .blk-bg').show();
  	    
  	} 
    
    function hideDesignationPopup()
  	{ 	    
  	    $('.designation-popup, .blk-bg').hide();
  	    
  	} 
	
	 
    function  selectDesignation(accesskey,name,msipin){
	   // var key = $("#desig_accesskey").val();
	    var des = $("#designation").val();
    	 swal({   
					  title: "You have requested to change the designation of "+ name +" "+msipin+" from STR to "+des +"\r\n Are you sure?",     
					  showCancelButton: true,
					  confirmButtonColor: "#DC3545",   
					  confirmButtonText: "OK", 
                      cancelButtonText: "Cancel",					  
					  closeOnConfirm: false },
					  function(isConfirm){
					  if(isConfirm){
    	
    	
	       $.ajax({
			    url: 'finalDesignation',
			    type:'post',
				data:'accesskey='+accesskey+'&designtion='+des,
				success:function(res){ 
					location.reload();  				        	 
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
	 
	 
	function funexport()
	{
	 	var outlet = $('#outlet').val();
		var name =$('#candidateName').val();
		var uniqueCode =$('#uniqueCode').val();
		var desg =$('#desg').val();
		var mspinS =$('#mspinS').val();
		var passFail =$('#passFail').val();
		var dateFrom =$('#dateFromm').val();
		var dateTo =$('#dateToo').val();
		var interview = null;
		if($('#interview').is(':checked')){
			interview = $('#interview').val();
		}
		var prarambh = null;
		if($('#prarambh').is(':checked')){
			prarambh = $('#prarambh').val();
		}
		var fsdm = null;
		if($('#fsdm').is(':checked')){
			fsdm = $('#fsdm').val();
		}


		// document.forms[0].action="./inProgressCSV?outletCode="+outlet+"&candidate="+name+"&unique="+uniqueCode+"&desig="+desg+"&mspinS="+mspinS+"&pass="+passFail+"&date="+dateRange;
		//document.forms[0].method="post";
		//document.forms[0].submit();
		
		 var form = document.createElement("form");
         	
		 form.method="post";
		 form.action="./inProgressCSV?outlet="+outlet+"&candidate="+name+"&unique="+uniqueCode+"&desig="+desg+"&mspinS="+mspinS+"&pass="+passFail+"&dateFromm="+dateFrom+"&dateToo="+dateTo+"&interview="+interview+"&prarambh="+prarambh+"&fsdm="+fsdm;
		 document.body.appendChild(form);
		 form.submit();
	}	
	function editDataScience(){
		$("#btn_submit").show();
		$('#reson_no').attr('disabled', false);
		$('#reson_yes').attr('disabled', false);
		$('#no').attr('disabled', false);
		$('#yes').attr('disabled', false);
	}
function showDataScience(accesskey,result,name,reson,interviewStatus,status,prediction,reference,interViewDate){
		 $('#name').val(name);	
		 $('#accesskey').val(accesskey);	
		 if(status =="2"){
			 $("#btn_submit").hide();
			 $('#reson_no').attr('disabled', 'disabled');
			 $('#reson_yes').attr('disabled', 'disabled');
			 $('#no').attr('disabled', 'disabled');
			 $('#yes').attr('disabled', 'disabled');
		 }
		 if(interViewDate == "" && status =="2"){
			$("#btn_edit").show(); 
		 }
		 if(interviewStatus =="yes"){
			 $("#yes").prop('checked',true);
			 if(prediction == 'Low'){
		    	 $("#div_yes").show();
				  $("#div_no").hide();
		    	 $("#reson_yes").val(reson);
		    	}
		 }
		 if(interviewStatus =="no"){
			 $("#no").prop('checked',true);
			 if(prediction == 'High'){
		     	  $("#div_no").show();
				   $("#div_yes").hide();
		     	 $("#reson_no").val(reson );
		     	}
		 }
		 
		 $("#reference").val(reference);
		 $("#prediction").val(prediction +" productivity" );
		 
	     $('.communications-popup, .blk-bg').show();
	}
	
	function cancle(){
		 $("#yes").prop('checked',false);
		 $("#no").prop('checked',false);
		 $("#reson_no").val("");
		 $("#reson_yes").val("");
		 $("#reference").val("");
		 $('.communications-popup, .blk-bg').hide();
	}
	
	 function  setReason(){
		    var yes = $("#reson_yes").val();
		    var no = $("#reson_no").val();
		   var accesskey= $('#accesskey').val();
		    var interview_reason =$("#interview_reason").val();
		   // var prediction =$("#prediction").val();
		   // var reference =$("#reference").val();
		  // alert(interview_reason);
		    
		         		
			
		    var reason="";
		    if(yes != ""){
		    	reason =yes;
		    }
		    if(no != ""){
		    	reason =no;
		    }
			 if($("#reson_no").is(":visible") || $("#reson_yes").is(":visible") ){
			if(reason == ""){
				showMSG("Please select reason option")
		      return false;
			}
			 }
			 
			 if(interview_reason ==""){
		          showMSG("Please select  interview option")
		          return false;
		         }	
		       $.ajax({
				    url: 'datascience',
				    type:'post',
					data:'accesskey='+accesskey+'&interviewReason='+interview_reason+"&reason="+reason,
					success:function(res){ 
						location.reload();  				        	 
					 },
					 error:function(ress){
						window.close();
					 }
				});  
	     }
	 
	 $("#yes").change(function(){
     	var val = $("#yes").val();
     	 $("#yes").prop('checked',true);
    	 $("#no").prop('checked',false);
    	var prediction= $("#prediction").val();
    	if(prediction == 'Low productivity'){
    	 $("#div_yes").show();
    	 $("#div_no").hide();
    	}
    	if(prediction == 'High productivity'){
       	 $("#div_yes").hide();
       	 $("#div_no").hide();
       	 $("#reson_yes").val("");
       	$("#reson_no").val("");
       	}
    	$("#interview_reason").val(val);
     });
     
     $("#no").change(function(){
     	var val = $("#no").val();
     	 $("#no").prop('checked',true);
    	 $("#yes").prop('checked',false);
    	 var prediction= $("#prediction").val();
     	if(prediction == 'High productivity'){
     	  $("#div_no").show();
     	 $("#div_yes").hide();
     	}
     	if(prediction == 'Low productivity'){
       	 $("#div_yes").hide();
       	 $("#div_no").hide();
       	 $("#reson_no").val("");
       	 $("#reson_yes").val("");
       	}
     	$("#interview_reason").val(val);
     });
   
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
		
		console.log('Column '+column_name+' with status '+status);
	 }); 
                function openFinalSubmit(pKey){    
                    window.location.href="finalSubmit?accesskey="+pKey;
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