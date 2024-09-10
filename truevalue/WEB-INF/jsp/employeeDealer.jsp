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
	
    <link rel="icon" type="image/x-icon" href="<%=baseServer%>img/iRecruit-favicon.ico"/>

    <title>iRecruit</title>
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
        @media (max-width: 320px){
				.page-filters {display: flex !important;}
				.add-remove-columns{left: 0 !important;}
				.add-remove-columns.irc-add-remove-columns{margin: 0 !important;}
				.page-filters-process{top: 30px;height: 40px !important;}
				.table-date {top: 20px !important;}
				div#data_filter {margin-top: -30px !important;}
                .export-to-csv {top: 0px !important;left: 0 !important;}
                .page-filters-filter-block .form-section .form-block{width: calc(100% - 20px) !important;}

			}

			@media (max-width: 376px){
				.add-remove-columns{left: 0 !important;}
				.page-filters {display: flex !important;}
				.add-remove-columns.irc-add-remove-columns{margin: 0 !important;} 
				.page-filters-process{top: 30px;height: 40px !important;}
				.page-filters-filter{margin-top: 35px !important;}
				.table-date {top: 20px !important;}
				div#data_filter {margin-top: -30px !important;}
                .export-to-csv {top: 0px !important;left: 0 !important;}
              /* .page-filters-process-block{width:340px !important;top: 70px !important;} */
              .page-filters-filter-block .form-section .form-block{width: calc(100% - 20px) !important;}
              .page-filters-filter-block, .page-filters-process-block {width: 350px !important;}

				
}
@media (max-width: 426px){
    .add-remove-columns{left: 0 !important;top: -45px !important;}
	.page-filters-filter{margin-top: 0 !important;}
	.table-date {top:50px !important;}
    .page-filters-filter-block, .page-filters-process-block{top: 40px !important;}
    .page-filters-filter-block .form-section .form-block{width: calc(100% - 20px) !important;}
    
}
@media (max-width: 767px) {
	.add-remove-columns {top: -48px !important;}
    .table-date {top: 55px !important;}
  .page-filters-filter-block, .page-filters-process-block {width: 390px !important;}

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
        <h1>Employee Master</h1>
        <div class="page-filter-include">
		 <%@include file="./filter/emp-dealer-filter.jsp"%>
		</div>

        <!-- <h1>Employee Master</h1> -->
        <div class="container-1100">
            <div class="table-date">
			<div class="add-remove-columns">
                    <span>Add/Remove Columns</span>
                    <ul>
                        <li><a class="toggle-vis" data-column="0"><em>Sr. No.</em></a></li>
                        <li><a class="toggle-vis" data-column="1"><em>Candidate Name</em></a></li>
						<li><a class="toggle-vis" data-column="2"><em>Profile</em></a></li>
						<li><a class="toggle-vis" data-column="3"><em>Designation Code</em></a></li>
						<li><a class="toggle-vis" data-column="4"><em>Designation Desc</em></a></li>
						<li><a class="toggle-vis" data-column="5"><em>Mobile Number</em></a></li>
						<li><a class="toggle-vis" data-column="6"><em>Access Key</em></a></li>
						<li><a class="toggle-vis" data-column="7"><em>Registration Date</em></a></li>
						<li><a class="toggle-vis" data-column="8"><em>Assessment Date</em></a></li>				
                       <!-- <li><a class="toggle-vis" data-column="9"><em>Total Marks</em></a></li>
                        <li><a class="toggle-vis" data-column="10"><em>Marks Obtained</em></a></li>
                        <li><a class="toggle-vis" data-column="11"><em>Percentage</em></a></li> -->
						<li><a class="toggle-vis" data-column="9"><em>Aptitude</em></a></li> 
						<li><a class="toggle-vis" data-column="10"><em>Attitude</em></a></li> 
                        <li><a class="toggle-vis" data-column="11"><em>Assessment Status</em></a></li>
                        <li><a class="toggle-vis" data-column="12"><em>Assessment Report</em></a></li>
						<li><a class="toggle-vis" data-column="13"><em>Data Sciencet</em></a></li>
                        <li><a class="toggle-vis" data-column="14"><em>Interview Date</em></a></li>
                        <li><a class="toggle-vis" data-column="15"><em>Interview Score</em></a></li>
						<li><a class="toggle-vis" data-column="16"><em>Registration Form</em></a></li>
						<li><a class="toggle-vis" data-column="17"><em>MSPIN</em></a></li>
						<li><a class="toggle-vis" data-column="18"><em>Induction Course Status</em></a></li>						
						<li><a class="toggle-vis" data-column="19"><em>FSDM Approval</em></a></li>
						
										
                    </ul>
                </div>
				   <div class="export-to-csv"><input type="button" onclick="funexport()" class="ecsvbutton" value="Export To CSV"></div>
                <table id="data" cellspacing="0" cellpadding="0" border="0" class="display nowrap cell-border" width="50">
                    <thead>
                        <tr>
                           <th data-head="Sr. No." style="z-index: 1 !important;"><em>Sr. No.</em></th>
							<th data-head="Candidate Name" class="sorting" style="z-index: 1 !important;"><em>Candidate Name</em</span></th>
							<th data-head="Profile" class="sorting"><em>Profile</em</span></th>
							<th data-head="Designation Code" class="sorting"><em>Designation Code</em</span></th>
							<th data-head="Designation Desc" class="sorting"><em>Designation Desc</em></th>                         
							<th data-head="Mobile Number" class="sorting"><em>Mobile Number</em</span></th>
							<th data-head="Access Key" class="sorting"><em>Access Key</em</span></th>
							<th data-head="Registration Date" class="sorting"><em>Registration Date</em</span></th>
							<th data-head="Assessment Date" class="sorting"><em>Assessment Date</em</span></th>                       
                           <!-- <th data-head="Total Marks" class="sorting"><em>Total Marks</em></th>
                            <th data-head="Marks Obtained" class="sorting"><em>Marks Obtained</em></th>
                            <th data-head="Percentage Scored" class="sorting"><em>Percentage</em></th> -->	
                            <th data-head="Aptitude" class="sorting"><em>Aptitude</em></th>		
                            <th data-head="Attitude" class="sorting"><em>Attitude</em></th>							
                            <th data-head="Assessment Status" class="sorting"><em>Assessment Status</em></th>
							<th data-head="Assessment Report" class="sorting"><em>Assessment Report</em></th>
                            <th data-head="Interview Date" class="sorting"><em>Interview Date</em></th>
                            <th data-head="Interview Form" class="sorting"><em>Interview Score</em></th>
                            <th data-head="Registration Form" class="sorting"><em>Registration Form</em></th>
                            <th data-head="MSPIN" class="sorting"><em>MSPIN<em></th>
							<th data-head="Induction Course Status" class="sorting"><em>Induction Course Status</em></th>
							<th data-head="FSDM Approval" class="sorting"><em>FSDM Approval</em></th>
                           
                        </tr>
                    </thead>
                    <tbody>
                    <%int i=1; %>
                    <c:forEach items="${participantList}" var="participant">
                        <tr>
                            <td><%=i %></td>
                           <td> ${fn:replace(participant.participantName, "null", "")}</td>
							<td>${participant.designation}</td>
                            <td>
							   <span>  ${participant.finalDesignationCode}  </span>
							 </td>
							  <td>
							   <span>  ${participant.finalDesignation}  </span>
							 </td>
							<td>${participant.mobile}</td>
							<td>${participant.accesskey}</td>
							<td>${participant.dateOfRegistration}</td>
							<td>${participant.assessment_Completion_date}</td>
							<!--<td class="text-center"><center><span class="text-center">${participant.totalMark}</span></center></td>
							 <c:choose>
                               <c:when test="${participant.passFailStatus == '1' }">
							    <td><span class="green">${participant.testScore} </span></td>
								 </c:when>
                               <c:when test="${participant.passFailStatus == '0' }">
							    <td><span class="red">${participant.testScore} </span></td>
								</c:when>
							    </c:choose>
                            <td><span>${participant.percentageScore}%</span></td>	-->		
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

                           					
                            <td><a href="#"><img src="./img/pdf-icn.svg"  onclick="openReport('${participant.accesskey}','${participant.participantName }','${participant.email }','${participant.mobile }')"/></a></td>
                             


                            <td ><span class="fixdate"  style="cursor: default !important;">${participant.interViewDate}</span></td>
                           <td>
						   <c:choose>
                               <c:when test="${participant.interViewPassFailStatus == 'pass'}">
                              <span> <a href="#" class="view-btn green"  onclick="openIterviewForm('${participant.accesskey}')">View</a></span>
                               </c:when>                                 
                               <c:otherwise>
                                    <span> --</span>
                               </c:otherwise>
							   </c:choose>                             
							</td>
                            <td>							
							<c:choose>
                               <c:when test="${participant.interViewPassFailStatus == 'pass' && participant.passFailStatus == '1'}">
                              <span><a href="#" class="view-btn" onclick="openProfile('${participant.accesskey}')">View</a></span>
                               </c:when>                                
                               <c:otherwise>
                                    <span> --</span>
                               </c:otherwise>
							   </c:choose>
							</td>
                           <td> <span>${participant.mspin }</span></td>
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
                               <c:when test="${participant.fsdmApprovalStatus == 'Approval Awaited' }">
                               <span class="red">${participant.fsdmApprovalStatus }</span>
                               </c:when>
                                 <c:when test="${participant.fsdmApprovalStatus == 'Feedback Given'}">
                                <span class="blue">${participant.fsdmApprovalStatus }</span>
                                 </c:when>
                               <c:otherwise>
                               <span class="green">${participant.fsdmApprovalStatus }</span>
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
 
    <script>
      $(document).ready(function () {
       
      });
       
      
      function opentInterview(key){
  	        mywindow=window.open("interviewForm?accesskey="+key,"detailwindow","resizable=1,scrollbars=1,width=1170,height=600");
  	       mywindow.moveTo(120,90);
       }
	   
	    function openReport(key,name,email,mobile){
	        mywindow=window.open("<%=assessUrl%>player/viewAssessment.jsp?accesskey="+key+"&name="+name+"&email="+email+"&mobile="+mobile+"&testid=41&attemptid=1","detailwindow","resizable=1,scrollbars=1,width=1170,height=600");
	       mywindow.moveTo(120,90);
     }
      
      
      function openProfile(key){
    	  window.location.href="profileDetails?accesskey="+key;
      }
      
      function openIterviewForm(key){
    	  mywindow=window.open("printInterviewForm?accesskey="+key, "detailwindow","resizable=1,scrollbars=1,width=1170,height=600");
	       mywindow.moveTo(120,90);  
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
		var form = document.createElement("form");
         	
		 form.method="post";
		 form.action="./csvEmployee?outlet="+outlet+"&candidate="+name+"&unique="+uniqueCode+"&desig="+desg+"&mspinS="+mspinS+"&pass="+passFail+"&dateFromm="+dateFrom+"&dateToo="+dateTo;
		 document.body.appendChild(form);
		 form.submit();
  	}	  
    </script>
  </body>
  <style>
    @media (max-width: 768px){
            .page-filters-filter-block, .page-filters-process-block {width:450px !important;}

          }
          @media (max-width: 767px){
            .page-filters-filter-block, .page-filters-process-block {width: 330px !important;}

          }
          @media (max-width: 426px){
            .page-filters-filter-block, .page-filters-process-block {width: 300px !important;}

        }
        @media (max-width: 376px){
            .page-filters-filter-block, .page-filters-process-block {width: 280px !important;}

        }
       
        @media (max-width: 320px){
            .page-filters-filter-block, .page-filters-process-block {width: 255px !important;}

        }
       
      
        
         
  </style>
</html>
<%
 }catch(Exception e)
    {
    	 System.out.println("Errror....."+e);
    	  response.sendRedirect("login");
    }%>
