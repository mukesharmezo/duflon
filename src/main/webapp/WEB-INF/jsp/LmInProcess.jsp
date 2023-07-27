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
if (session.getAttribute("role") != null) {
	String role = session.getAttribute("role").toString().trim();
	String st = "";

%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<link rel="icon" type="image/x-icon" href="<%=baseServer%>img/DuflonFavicon.png"/>  <title><%=title %></title>
    <link rel="stylesheet" type="text/css" href="./css/common.css" />
    <link rel="stylesheet" type="text/css" href="./css/fsdm.css" />
    <link rel="stylesheet" type="text/css" href="css/dashboard-filter.css">
      <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.12.1/css/jquery.dataTables.min.css">
    <link rel="stylesheet" type="text/css" href="./css/datatable.css">
    <style>
        .left-panel > ul > li:nth-child(1) > a, .left-panel > ul > li:nth-child(1) > ul > li:nth-child(1) > a{opacity: 1;}
        .left-panel > ul > li:nth-child(1) > ul > li:nth-child(1) > a::after{content: ''; position: absolute; right: 0; top: 50%; transform: translate(0, -50%); border-right: 6px solid #fff; border-top: 6px solid transparent; border-bottom: 6px solid transparent;}
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
		  				<%@include file="./filter/page-filter.jsp"%>
				 </div>

        <!-- <h1>In Progress</h1> -->
        <div class="container-1100">
            <div class="table-date">
			<div class="add-remove-columns">
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
						<li><a class="toggle-vis" data-column="11"><em>Assessment Sheet</em></a></li>
						<li><a class="toggle-vis" data-column="12"><em>Registration Form</em></a></li>
                        <li><a class="toggle-vis" data-column="13"><em>Interview Date</em></a></li>
                        <li><a class="toggle-vis" data-column="14"><em>Interview Score</em></a></li>
                        <li><a class="toggle-vis" data-column="15"><em>Interview Date 2</em></a></li>
                        <li><a class="toggle-vis" data-column="16"><em>Interview Score 2</em></a></li>
						<li><a class="toggle-vis" data-column="17"><em>Approval</em></a></li>
						
                    </ul>
                </div>
                 <div class="export-to-csv"><input type="button" onclick="funexport()" class="ecsvbutton" value="Export To CSV"></div>
                <table id="data" cellspacing="0" cellpadding="0" border="0" class="display nowrap cell-border" width="50">
                    <thead>
                        <tr>
                          <th data-head="Sr. No."  class="sorting" style="z-index: 1 !important;" ><em >Sr.No.</em></th>
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
							<th data-head="Assessment Sheet" class="sorting"><em>Assessment Sheet</em></th>
                            <th data-head="Registration Form" class="sorting"><em>Registration Form</em></th>
                            <th data-head="Interview Date" class="sorting"><em>Interview Date</em></th>
                            <th data-head="Interview Score" class="sorting"><em>Interview Score</em></th>
                            <th data-head="Interview Date 2" class="sorting"><em>Interview Date 2</em></th>
                            <th data-head="Interview Score 2" class="sorting"><em>Interview Score 2</em></th>
							<th data-head="Approval" class="sorting"><em>Approval</em></th>
                           
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
                            <c:choose>
                               <c:when test="${participant.passFailStatus == '1' }">
                                  <td><span class="green">Pass</span></td>
                               </c:when>
                               <c:when test="${participant.passFailStatus == '0' }">
                                  <td ><span class="red" >Fail</span></td>
                               </c:when> 
                               </c:choose> 
                            <td><a href="#"><img src="./img/pdf-icn.svg" onclick="openReport('${participant.accesskey}','${participant.participantName }','${participant.email }','${participant.mobile }')" /></a></td >
							<td> <a href="#" class="view-btn green"  onclick="openAnswerReport('${participant.accesskey}','${participant.participantName }','${participant.email }')">View</a></td >
							<td>
							  <c:choose>
                               <c:when test="${participant.passFailStatus == '1' }">
                                <a href="#" class="view-btn" onclick="openProfile('${participant.accesskey}')">View</a>
                               </c:when>
                               <c:otherwise>
                               --
                               </c:otherwise>
                               </c:choose>
							  </td> 
							<c:choose>
                               <c:when test="${not empty participant.interViewDate }">
                                 <td ><span class="fixdate" >${participant.interViewDate}</span></td>
                               </c:when>  
                                <c:otherwise>
                                <td>--</td>
                               </c:otherwise>
                               </c:choose> 
							  
                             <td>
                             <c:choose>
                               <c:when test="${participant.interViewStatus == 'final' }">
                                <a href="#" class="view-btn green"  onclick="openIterviewForm('${participant.accesskey}',1)">View</a>
                               </c:when>
                               <c:otherwise>
                               --
                               </c:otherwise>
                               </c:choose>
                             </td>
							<c:choose>
                               <c:when test="${not empty participant.interViewDate2 }">
                                 <td ><span class="fixdate" >${participant.interViewDate2}</span></td>
                               </c:when>  
                                <c:otherwise>
                                <td>--</td>
                               </c:otherwise>
                               </c:choose> 
							  
                             <td>
                             <c:choose>
                               <c:when test="${participant.interViewStatus2 == 'final' }">
                                <a href="#" class="view-btn green"  onclick="openIterviewForm('${participant.accesskey}',2)">View</a>
                               </c:when>
                               <c:otherwise>
                               --
                               </c:otherwise>
                               </c:choose>
                             </td>
							 
                             <td>
                             <c:if test="${participant.hiredStatus == 'P'}">
                             	<span>Approval Pending</span>
                             </c:if>
                             <c:if test="${empty participant.hiredStatus}">
                             	<span> --</span>
                             </c:if>
							<%-- <c:choose>
											<c:when test="${participant.interViewPassFailStatus2 == 'pass'}">
													<a href="approveParticipantByLM?accesskey=${participant.accesskey}"> <span
														class="btn btn-secondary">Approve</span>
													</a>
											</c:when>
											<c:otherwise>
												<span>--</span>
											</c:otherwise>
										</c:choose> --%>
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
    	  var form = $('#formFilter');
    	  form.attr('action', 'viewAllParticapants');
            
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
	        mywindow=window.open("<%=assessUrl%>player/viewAssessment.jsp?accesskey="+key+"&name="+name+"&email="+email+"&mobile="+mobile+"&testid=43&attemptid=1","detailwindow","resizable=1,scrollbars=1,width=1170,height=600");
	       mywindow.moveTo(120,90);
     }
	 
	  function openAnswerReport(key,name,email,){
	        mywindow=window.open("<%=assessUrl%>pa/viewTest.do?accesskey="+key+"&name="+name+"&email="+email+"&testid=43&attemptid=1","detailwindow","resizable=1,scrollbars=1,width=1170,height=600");
	       mywindow.moveTo(120,90);
     }
      
      
      function openProfile(key){
    	  window.location.href="profileDetails?accesskey="+key;
      }
      
      function openIterviewForm(key, count){
    	  mywindow=window.open("printInterviewForm?accesskey="+key+"&interviewCount="+count, "detailwindow","resizable=1,scrollbars=1,width=1170,height=600");
	       mywindow.moveTo(120,90);  
      }
	  
     function funexport() {
			
    	 	var dateFrom =$('#dateFromm').val();
 			var dateTo =$('#dateToo').val();
       		var form = document.createElement("form");   
       	    form.method="post";
       		form.action="inProgressCSV?dateFromm="+dateFrom+"&dateToo="+dateTo;
       		document.body.appendChild(form);
   		 	form.submit();
		}
    </script>
  </body>
</html>
<%
} else {
response.sendRedirect("login");
}
 }catch(Exception e)
    {
    	 System.out.println("Errror....."+e);
    	  response.sendRedirect("login");
    }%>