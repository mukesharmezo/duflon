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
      if(session.getAttribute("role") != null)
	  {
String role = session.getAttribute("role").toString().trim();
String st = "";
 %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<link rel="icon" type="image/x-icon" href="<%=baseServer%>img/DuflonFavicon.png"/>
    <title><%=title %></title>
    
    <script src="./js/jquery-3.4.1.min.js"></script>
    
    <link rel="stylesheet" type="text/css" href="./css/common.css" />
    <link rel="stylesheet" type="text/css" href="./css/hiring-in-process.css" />
    <link rel="stylesheet" type="text/css" href="css/dashboard-filter.css">
    <link rel="stylesheet" type="text/css" href="./css/sweetalert.css"/>
    <link rel="stylesheet" type="text/css" href="./css/jquery.datatable.min.css"/>
    <script type="text/javascript" src="./js/sweetalert.min.js"></script>
	<link rel="stylesheet" type="text/css" href="./css/jquery.datatable.min.css"/>
    <link rel="stylesheet" type="text/css" href="./css/datatable.css"> 
    
    <style>
        .collapsible {background-color: #777;color: white;cursor: pointer;padding: 18px;width: 100%;border: none;text-align: left;outline: none;font-size: 15px;}
        .collapsible:after {content: '\002B';color: white;font-weight: bold;float: right;margin-left: 5px;}
        .active:after {content: "\2212";}
        .content {padding: 0 18px;max-height: 0;overflow: hidden;transition: max-height 0.2s ease-out;background-color: #f1f1f1;}
        .ui-datepicker {width: 12em;}
         h1{color:green;}
        .report-block-half p {font-size:15px;font-weight: 500; margin-left: 20px;}
        .report-section .report-block-v2 {width: calc(100% - 30px);border-radius: 10px;box-sizing: border-box;display: flex;justify-content: space-between;align-items: center;}
        .report-section{margin: 0 !important;}
        .report-block-half{width: calc(50% - 30px);margin: 10px 15px 15px;background-color: #fff;border-radius: 10px;display: flex;justify-content: space-between;align-items: center;}
        .report-section{display: flex; flex-wrap: wrap; margin: 15px -15px !important;}
        .report-section .report-block{width: calc(50% - 30px); margin: 0 15px 30px; background-color: #fff; border-radius: 10px; padding: 25px; box-sizing: border-box; display: flex; justify-content: space-between; align-items: center;}
        .report-section .report-block h3{margin: 0; font-weight: 500; font-size: 18px; line-height: 21px; color: #000;}
        .csv-icn-button{text-decoration: none; display: flex; align-items: center; color: #fff; font-size: 13px; line-height: 15px;margin-right: 20px; padding: 10px 15px; border-radius: 30px; background-color: #DC3545; text-transform: uppercase;}
        .csv-icn-button img{margin-right: 8px;}
        .collapsible {background-color:#fff; color: #000; cursor: pointer;padding: 18px;width: 100%;border: none;text-align: left;outline: none;font-size: 15px;border-radius: 10px;margin: 20px 0px 20px 0px;}
        .collapsible:after {content: '\002B';color:#000;font-weight: bold;margin-left: 5px;}
        /* .collapsible:after:hover {content: '\002B';color: white;font-weight: bold;margin-left: 5px;} */
        .collapsible:hover {background-color:#DC3545; color: #fff !important;}
        .active:after {content: "\2212";color: #fff;} 
        .content {width: 100%;padding: 0 18px;max-height: 0;overflow: hidden;transition: max-height 0.2s ease-out;background-color: #f1f1f1;display: flex;}
        .report-section.ir-report .collapsible.active ~ .content{max-height: unset !important;}
        button.collapsible {font-weight: 600;font-size: 17px;}
        .ir-report-tab-wrap{display:flex;align-items:center;flex-wrap: wrap; width:calc(106% - 10px);margin-top: 10px;}
        /* margin-top: 35px !important;} */
        .page-filters-filter{margin-top:25px !important;}
        .tablink , .main-tablink {margin: 0px 5px 0px 0px;border-radius: 5px;border: 1px solid #DC3545;/* background-color: #fff; */ color: #000;float: left;outline: none;cursor: pointer;padding:5px 5px;font-size: 12px;width:calc(15% - 10px);}
        /* .page-filters {margin-top: 23px !important} */
        .main-tablink {margin: 5px 5px 0px 0px;border-radius: 30px;border: 1px solid #DC3545;/* background-color: #fff; */color: #000;float: left;/* border: none; */outline: none;cursor: pointer;padding:8px 5px;font-size: 15px;width:calc(19% - 5px);}
        .tablink:hover, .main-tablink:hover {color: #fff;background-color: #DC3545}
        .table-date {margin-top: 30px;}
        /* Style the tab content (and add height:100% for full page content) */
        .tabcontent, .main-tabcontent {color: white;display: none;/* padding-top: 100px; *//* padding-bottom: 30px; */height: 100%}
        /* .section-modchooser-link .btn .btn-link{
        color: ;
        } */
        .dataTables_wrapper .dataTables_filter input{padding: 10px 0px 10px 0px !important;}
        .export-to-csv{position: absolute;top: -50px !important;right: 0 !important;margin-bottom: 15px;z-index: 10;}
        .table-date table tr, .table-date table tr td{color:#000;}
        .tabcontent h3, .main-tabcontent h3{color:#000;}
        .export-to-csv .ecsvbutton{background: #DC3545 !important;color: #fff !important;}
        .dataTables_scrollBody{position: relative;overflow-y: hidden !important;overflow: auto;width: 100%;max-height:445px !important;}
        .dt-buttons {display: inline-flex;width: calc(100% - 230px);}
        .buttons-csv.buttons-html5.ecsvbutton {margin-left: auto;}
        .dataTables_wrapper .dataTables_filter input{border:1px solid #DC3545 !important;}
        .dataTables_scroll.dtfc-has-left {padding: 10px 0px 0px 0px !important;}
        .main-tabcontent{min-height: calc(100vh - 226px)}
        .table-date table tr th em {font-weight: normal;}
        #ComAna{ display:none; } 
        table.dataTable tbody th, table.dataTable tbody td {padding: 12px 10px !important;}
        @media (max-width: 1300px){
            .dt-buttons {right: 25% !important;}
           .page-filters-filter-block {top: 60px !important;}

        }
        @media (max-width: 768px) {
            .main-tablink {width:auto;}
            .tablink {width:auto;}
            .report-section .report-block {width: 100%;flex-wrap: wrap;}
            .report-section .report-block h3 {width: 100%;}
            a.csv-icn-button {margin-right: 0px;margin-top: 15px;}
           .page-filters-filter-block {top: 60px !important;}
            }
        @media (max-width: 767px) {
            .page-filters {margin-top: 40px !important;}
            .page-filters-block {margin: 0 !important;}
            .page-filters-filter-block .form-section .form-block {width: calc(100% - 20px) !important;}
            .page-filters-filter-block {top: 60px !important;width: 350px !important;}
        }
        @media (max-width: 400px){
            .page-filters {margin-top: 40px !important;}
            .page-filters-filter-block {top: 60px !important;width: 330px !important;}
        }
        @media (max-width: 376px){
            .dt-buttons {display: contents !important;}
            .page-filters-filter-block .form-section .form-block {width: calc(100% - 20px) !important;}
            .page-filters-filter-block {top: 60px !important;width: 280px !important;}}
        @media (max-width: 320px){
            .dt-buttons {display: contents !important;}.page-filters-filter-block {top: 60px !important;width: 280px !important;}}
          
</style>
<c:set var="flag" value='${flag}'></c:set>
</head>
<body>
    <div class="left-panel-include">
        <%@include file="./header/left-panel.jsp"%> 
    </div>
    <div class="user-panel-include">
        <%@include file="./header/user-panel.jsp"%>
	</div>
            <div class="right-section">
                <div class="page-filter-include">
		  				<%@include file="./filter/page-filter.jsp"%>
				 </div> 
        
        <!-- <div class="ir-report-tab-wrap-main"> -->
            <div class="ir-report-tab-wrap">
              
                
                <button class="main-tablink" id="default-tab" onclick="openPageMain('default', this, '#DC3545 ')" style="display:none;">Default</button>
                <!-- <button class="main-tablink" id="OverF" onclick="openPageMain('dashboard', this, '#DC3545 ')">Dashboard</button> -->
                <button class="main-tablink" id="OverF" onclick="openPageMain('aggregate-report', this, '#DC3545 ')">Dashboard</button>
                <button class="main-tablink" onclick="openPageMain('detailed-assessment-report', this, '#DC3545 ')">Detailed Report</button>
                <button class="main-tablink" id="QBA" onclick="openPageMain('question-wise-report', this, '#DC3545 ')">Question Wise Analysis</button>
                <%if(role.equalsIgnoreCase("SuperAdmin")) {%>
                <button class="main-tablink" id="ComAnasdfdsf" onclick="openPageMain('competency-wise-analysis', this, '#DC3545 ')">Competency Analysis</button>
                <button class="main-tablink" id="AssessRepo" onclick="openPageMain('ir-assessment-report', this, '#DC3545 ');getAssessmentReport();">Assessment Report</button>
                <%}%>
                
            </div>
            
  

<div id="default" class="main-tabcontent">
    <h3>Please click on the required button above to fetch relevant report.</h3>
</div>

<div id="dashboard" class="main-tabcontent">
    <div class="ir-report-tab-wrap" style="margin-top: 10px !important;">
        <button class="tablink" id="aggregateF" onclick="openPage('aggregate-report', this, '#DC3545 ')">Overview</button>
        <button class="tablink" id="overviewF" onclick="openPage('overview', this, '#DC3545 ')">Recruitment Funnel</button>
        <button class="tablink" id="actionF" onclick="openPage('action-points', this, '#DC3545 ')">Action Points</button>
        <button class="tablink" id="recruitmentF" onclick="openPage('recruitment-source', this, '#DC3545 ')">Recruitment Source</button>
        <button class="tablink" id="salesF" onclick="openPage('sales/non-sales', this, '#DC3545 ')">Designation</button>
        </div>
        <div class="ir-report-tab-wrap">
        <button class="tablink" id="genderF" onclick="openPage('gender-diversity', this, '#DC3545 ')">Gender Diversity</button>
        <button class="tablink" id="expF" onclick="openPage('candidate-experience', this, '#DC3545 ')">Candidate Experience</button>
        <button class="tablink" id="ageF" onclick="openPage('age-wise', this, '#DC3545 ')">Age Wise</button>
        <button class="tablink" id="assessmentF" onclick="openPage('assessment-report', this, '#DC3545 ')">Assessment Report</button>
        <!-- <button class="tablink" id="salesF" onclick="openPage('sales/non-sales', this, '#DC3545 ')">Sales/Non-Sales</button> -->
    </div>
    <div id="overview" class="tabcontent">
        <!-- <h3>Overview</h3> -->
        <div class="table-date">
            <!--<div class="export-to-csv"><input type="button" class="ecsvbutton" value="Export To CSV" onclick="downloadExcelOV()"></div>-->
            <table id="data-ov" cellspacing="0" cellpadding="0" border="0" class="stripe display nowrap cell-border data-table" width="50" style="width: 100% !important;height: auto !important;">
                <thead>
                    <tr>
                        <th data-head="Sr.No." class="sorting" style="z-index: 1 !important;"><em>Sr.No.</em></th>
                        <th data-head="Candidate Name" class="sorting"><em>Candidate Name</em></th>
                        <th data-head="Profile" class="sorting"><em>Designation</em></th>
                        <th data-head="Candidate Status" class="sorting"><em>Candidate Status</em></th>
                        <th data-head="Mobile" class="sorting"><em>Mobile</em></th>
                        <th data-head="Access Key" class="sorting"><em>Access Key</em></th>
                        <th data-head="Registration Date" class="sorting"><em>Registration Date</em></th>
                        <th data-head="Assessment Date" class="sorting"><em>Assessment Date</em></th> 
                        <th data-head="Assessment Status" class="sorting"><em>Assessment Status</em></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${overviewAll}" var="participant" varStatus="status">
                    <%-- <c:if test="${(role eq 'HRE') || (participant.status eq 'Recruited' &&  (role eq 'HO' || role eq 'FS'))}"> --%>
                        <tr>
                            <td>${status.count}</td>
                            <td>${participant.participantName }</td>
                            <td>${participant.designation}</td>
                             <td>${participant.status}</td>
                          <%--   <c:if test="${(role eq 'DL')}"> --%>
                           <%--  </c:if> --%>
                            <td>${participant.mobile}</td>
                            <td>${participant.accesskey}</td>
                            <td>${participant.dateOfRegistration}</td>
                            <td>${participant.assessment_Completion_date}</td>
                            <c:choose>
                                <c:when test="${participant.passFailStatus == '1' }">
                                    <td><span class="green">Pass</span></td>
                                </c:when>
                                <c:when test="${not empty participant.assessment_Completion_date  && participant.passFailStatus == '0' }">
                                    <td ><span class="red" >Fail</span> </td>
                                </c:when>
                                <c:when test="${empty participant.assessment_Completion_date && participant.passFailStatus == '0' }">
                                    <td ><span >NA</span> </td>
                                </c:when>
                            </c:choose>	
                        </tr>
                    <%-- </c:if> --%>
                </c:forEach>
            </tbody>
        </table>
    </div> 
    </div>

    <div id="action-points" class="tabcontent">
        <!-- <h3>Action Points</h3>  -->
        <div class="table-date">
            <!--<div class="export-to-csv"><input type="button" class="ecsvbutton" value="Export To CSV"></div>-->
            <table id="data-ap" cellspacing="0" cellpadding="0" border="0" class="stripe display nowrap cell-border data-table" width="50" style="width: 100% !important;height: auto !important;">
                <thead>
                    <tr>
                        <th data-head="Sr.No." class="sorting" style="z-index: 1 !important;"><em>Sr.No.</em></th>
                        <th data-head="Candidate Name" class="sorting" ><em>Candidate Name</em></th>
                        <th data-head="Designation" class="sorting"><em>Designation</em></th>
                        <th data-head="Candidate Status" class="sorting"><em>Pending Action</em></th>
                        <th data-head="Mobile" class="sorting"><em>Mobile</em></th>
                        <th data-head="Access Key" class="sorting"><em>Access Key</em></th>
                        <th data-head="Registration Date" class="sorting"><em>Registration Date</em></th>
                        <th data-head="Assessment Date" class="sorting"><em>Assessment Date</em></th> 			
                        <th data-head="Assessment Status" class="sorting"><em>Assessment Status</em></th>
                    </tr>
                </thead>
                <tbody>
                      <c:forEach items="${actionAll}" var="participant" varStatus="status">
                    <%--  <c:if test="${(role eq 'DL') || ((participant.status eq 'Praarambh' || participant.status eq 'FSDM Approval') &&  (role eq 'HO' || role eq 'FS'))}"> --%>
                          <tr>
                              <td>${status.count}</td>
                              <td>${participant.participantName }</td>
                              <td>${participant.designation}</td>
                              <td>${participant.status}</td>
                              <td>${participant.mobile}</td>
                              <td>${participant.accesskey}</td>
                              <td>${participant.dateOfRegistration}</td>
                          <c:choose>
                              <c:when  test="${empty participant.assessment_Completion_date}">
                              <td><span >NA</span></td>
                              </c:when>
                              <c:when test="${not empty participant.assessment_Completion_date}">
                              <td>${participant.assessment_Completion_date}</td>
                              </c:when>
                              </c:choose>
                                                                
                                  <c:choose>
                                  <c:when test="${participant.passFailStatus == '1' }">
                                      <td><span class="green">Pass</span></td>
                                  </c:when>
                                  <c:when test="${not empty participant.assessment_Completion_date  && participant.passFailStatus == '0' }">
                                      <td ><span class="red" >Fail</span> </td>
                                  </c:when>
                                  <c:when test="${empty participant.assessment_Completion_date && participant.passFailStatus == '0' }">
                                      <td ><span >NA</span> </td>
                                  </c:when>
                                  </c:choose>	
                        </tr>
                      <%-- </c:if> --%>
                      </c:forEach>
                  </tbody>
            </table>
        </div>
    </div>

    <div id="recruitment-source" class="tabcontent">
        <!-- <h3>Recruitment Source</h3> -->
        <div class="table-date">
            <!--<div class="export-to-csv"><input type="button" class="ecsvbutton" value="Export To CSV"></div>-->
            <table id="data-rs" cellspacing="0" cellpadding="0" border="0" class="stripe display nowrap cell-border" width="50" style="width: 100% !important;height: auto !important;">
                <thead>
                    <tr>
                        <th data-head="Sr.No." class="sorting" style="z-index: 1 !important;"><em>Sr.No.</em></th>
                        <th data-head="Candidate Name" class="sorting" ><em>Candidate Name</em></th>
                        <th data-head="Designation" class="sorting"><em>Designation</em></th>
                        <th data-head="Candidate Status" class="sorting"><em>Recruitment Source</em></th>
                        <th data-head="Mobile" class="sorting"><em>Mobile</em></th>
                        <th data-head="Access Key" class="sorting"><em>Access Key</em></th>
                        <th data-head="Registration Date" class="sorting"><em>Registration Date</em></th>
                        <th data-head="Assessment Date" class="sorting"><em>Assessment Date</em></th> 			
                        <th data-head="Assessment Status" class="sorting"><em>Assessment Status</em></th>
                    </tr>
                </thead>
                <tbody>
                      <c:forEach items="${sourceAll}" var="participant" varStatus="status">
                          <tr>
                              <td>${status.count}</td>
                              <td>${participant.participantName }</td>
                              <td>${participant.designation}</td>
                              <td>${participant.status}</td>
                              <td>${participant.mobile}</td>
                              <td>${participant.accesskey}</td>
                              <td>${participant.dateOfRegistration}</td>
                          <c:choose>
                              <c:when  test="${empty participant.assessment_Completion_date}">
                              <td><span >NA</span></td>
                              </c:when>
                              <c:when test="${not empty participant.assessment_Completion_date}">
                              <td>${participant.assessment_Completion_date}</td>
                              </c:when>
                              </c:choose>
                                  <c:choose>
                                  <c:when test="${participant.passFailStatus == '1' }">
                                      <td><span class="green">Pass</span></td>
                                  </c:when>
                                  <c:when test="${not empty participant.assessment_Completion_date  && participant.passFailStatus == '0' }">
                                      <td ><span class="red" >Fail</span> </td>
                                  </c:when>
                                  <c:when test="${empty participant.assessment_Completion_date && participant.passFailStatus == '0' }">
                                      <td ><span >NA</span> </td>
                                  </c:when>
                                  </c:choose>	
                      </tr>
                      </c:forEach>
                  </tbody>
            </table>
        </div> 
    </div>

    <div id="sales/non-sales" class="tabcontent">
        <!-- <h3>Sales Non-Sales</h3>  -->
        <div class="table-date">
            <!--<div class="export-to-csv"><input type="button" class="ecsvbutton" value="Export To CSV"></div>-->
            <table id="data-sns" cellspacing="0" cellpadding="0" border="0" class="stripe display nowrap cell-border" width="50" style="width: 100% !important;height: auto !important;">
                <thead>
                    <tr>
                        <th data-head="Sr.No." class="sorting" style="z-index: 1 !important;"><em>Sr.No.</em></th>
                        <th data-head="Candidate Name" class="sorting" ><em>Candidate Name</em></th>
                        <th data-head="Designation" class="sorting"><em>Designation</em></th>
                        <th data-head="Mobile" class="sorting"><em>Mobile</em></th>
                        <th data-head="Access Key" class="sorting"><em>Access Key</em></th>
                        <th data-head="Registration Date" class="sorting"><em>Registration Date</em></th>
                        <th data-head="Assessment Date" class="sorting"><em>Assessment Date</em></th> 
                        <%-- <th data-head="Marks Obtained" class="sorting"><em>Marks Obtained</em></th>	 --%>			
                        <th data-head="Assessment Status" class="sorting"><em>Assessment Status</em></th>
                    </tr>
                </thead>
                <tbody>
                      <c:forEach items="${desgAll}" var="participant" varStatus="status">
                          <tr>
                              <td>${status.count}</td>
                              <td>${participant.participantName }</td>
                              <td>${participant.designation}</td>
                              <td>${participant.mobile}</td>
                              <td>${participant.accesskey}</td>
                              <td>${participant.dateOfRegistration}</td>
                          <c:choose>
                              <c:when  test="${empty participant.assessment_Completion_date}">
                              <td><span >NA</span></td>
                              </c:when>
                              <c:when test="${not empty participant.assessment_Completion_date}">
                              <td>${participant.assessment_Completion_date}</td>
                              </c:when>
                              </c:choose>
                                  <c:choose>
                                  <c:when test="${participant.passFailStatus == '1' }">
                                      <td><span class="green">Pass</span></td>
                                  </c:when>
                                  <c:when test="${not empty participant.assessment_Completion_date  && participant.passFailStatus == '0' }">
                                      <td ><span class="red" >Fail</span> </td>
                                  </c:when>
                                  <c:when test="${empty participant.assessment_Completion_date && participant.passFailStatus == '0' }">
                                      <td ><span >NA</span> </td>
                                  </c:when>
                                  </c:choose>												 
                      </tr>
                      </c:forEach>
                  </tbody>
            </table>
        </div>
    </div>

    <div id="gender-diversity" class="tabcontent">
        <!-- <h3>Gender Diversity</h3> -->
        <div class="table-date">
            <!--<div class="export-to-csv"><input type="button" class="ecsvbutton" value="Export To CSV"></div>-->
            <table id="data-gd" cellspacing="0" cellpadding="0" border="0" class="stripe display nowrap cell-border" width="50" style="width: 100% !important;height: auto !important;">
                <thead>
                    <tr>
                        <th data-head="Sr.No." class="sorting" style="z-index: 1!important;"><em>Sr.No.</em></th>
                        <th data-head="Candidate Name" class="sorting" ><em>Candidate Name</em></th>
                        <th data-head="Designation" class="sorting"><em>Designation</em></th>
                        <th data-head="Candidate Status" class="sorting"><em>Gender</em></th>
                        <th data-head="Mobile" class="sorting"><em>Mobile</em></th>
                        <th data-head="Access Key" class="sorting"><em>Access Key</em></th>
                        <th data-head="Registration Date" class="sorting"><em>Registration Date</em></th>
                        <th data-head="Assessment Date" class="sorting"><em>Assessment Date</em></th> 			
                        <th data-head="Assessment Status" class="sorting"><em>Assessment Status</em></th>
                    </tr>
                </thead>
                <tbody>
                      <c:forEach items="${genderAll}" var="participant" varStatus="status">
                          <tr>
                              <td>${status.count}</td>
                              <td>${participant.participantName }</td>
                              <td>${participant.designation}</td>
                              <td>${participant.status}</td>
                              <td>${participant.mobile}</td>
                              <td>${participant.accesskey}</td>
                              <td>${participant.dateOfRegistration}</td>
                          <c:choose>
                              <c:when  test="${empty participant.assessment_Completion_date}">
                              <td><span >NA</span></td>
                              </c:when>
                              <c:when test="${not empty participant.assessment_Completion_date}">
                              <td>${participant.assessment_Completion_date}</td>
                              </c:when>
                              </c:choose>
                                  
                                  <c:choose>
                                  <c:when test="${participant.passFailStatus == '1' }">
                                      <td><span class="green">Pass</span></td>
                                  </c:when>
                                  <c:when test="${not empty participant.assessment_Completion_date  && participant.passFailStatus == '0' }">
                                      <td ><span class="red" >Fail</span> </td>
                                  </c:when>
                                  <c:when test="${empty participant.assessment_Completion_date && participant.passFailStatus == '0' }">
                                      <td ><span >NA</span> </td>
                                  </c:when>
                                  </c:choose>	
                      </tr>
                      </c:forEach>
                  </tbody>
            </table>
        </div>
    </div>

    <div id="candidate-experience" class="tabcontent">
        <!-- <h3>Candidate Experience</h3> -->
        <div class="table-date">
            <!--<div class="export-to-csv"><input type="button" class="ecsvbutton" value="Export To CSV"></div>-->
            <table id="data-ce" cellspacing="0" cellpadding="0" border="0" class="stripe display nowrap cell-border" width="50" style="width: 100% !important;height: auto !important;">
                <thead>
                    <tr>
                        <th data-head="Sr.No." class="sorting" style="z-index: 1 !important;"><em>Sr.No.</em></th>
                        <th data-head="Candidate Name" class="sorting" ><em>Candidate Name</em></th>
                        <th data-head="Designation" class="sorting"><em>Designation</em></th>
                         <th data-head="Experience" class="sorting"><em>Experience</em></th>
                        <th data-head="Mobile" class="sorting"><em>Mobile</em></th>
                        <th data-head="Access Key" class="sorting"><em>Access Key</em></th>
                        <th data-head="Registration Date" class="sorting"><em>Registration Date</em></th>
                        <th data-head="Assessment Date" class="sorting"><em>Assessment Date</em></th> 			
                        <th data-head="Assessment Status" class="sorting"><em>Assessment Status</em></th>
                    </tr>
                </thead>
                <tbody>
                      <c:forEach items="${expAutoAll}" var="participant" varStatus="status">
                          <tr>
                              <td>${status.count}</td>
                              <td>${participant.participantName }</td>
                              <td>${participant.designation}</td>
                              <td>${participant.status}</td>
                              <td>${participant.mobile}</td>
                              <td>${participant.accesskey}</td>
                              <td>${participant.dateOfRegistration}</td>
                          <c:choose>
                              <c:when  test="${empty participant.assessment_Completion_date}">
                              <td><span >NA</span></td>
                              </c:when>
                              <c:when test="${not empty participant.assessment_Completion_date}">
                              <td>${participant.assessment_Completion_date}</td>
                              </c:when>
                              </c:choose>
                                 
                                  <c:choose>
                                  <c:when test="${participant.passFailStatus == '1' }">
                                      <td><span class="green">Pass</span></td>
                                  </c:when>
                                  <c:when test="${not empty participant.assessment_Completion_date  && participant.passFailStatus == '0' }">
                                      <td ><span class="red" >Fail</span> </td>
                                  </c:when>
                                  <c:when test="${empty participant.assessment_Completion_date && participant.passFailStatus == '0' }">
                                      <td ><span >NA</span> </td>
                                  </c:when>
                                  </c:choose>	
                      </tr>
                      </c:forEach>
                  </tbody>
            </table>
        </div>
    </div>

    <div id="age-wise" class="tabcontent">
        <!-- <h3>Age Wise</h3>  -->
        <div class="table-date">
            <!--<div class="export-to-csv"><input type="button" class="ecsvbutton" value="Export To CSV"></div>-->
            <table id="data-aw" cellspacing="0" cellpadding="0" border="0" class="stripe display nowrap cell-border" width="50" style="width: 100% !important;height: auto !important;">
                <thead>
                    <tr>
                        <th data-head="Sr.No." class="sorting" style="z-index: 1 !important;"><em>Sr.No.</em></th>
                        <th data-head="Candidate Name" class="sorting" ><em>Candidate Name</em></th>
                        <th data-head="Designation" class="sorting"><em>Designation</em></th>
                        <th data-head="Candidate Status" class="sorting"><em>Age</em></th>
                        <th data-head="Mobile" class="sorting"><em>Mobile</em></th>
                        <th data-head="Access Key" class="sorting"><em>Access Key</em></th>
                        <th data-head="Registration Date" class="sorting"><em>Registration Date</em></th>
                        <th data-head="Assessment Date" class="sorting"><em>Assessment Date</em></th> 
                        <th data-head="Assessment Status" class="sorting"><em>Assessment Status</em></th>
                    </tr>
                </thead>
                <tbody>
                      <c:forEach items="${ageAll}" var="participant" varStatus="status">
                          <tr>
                              <td>${status.count}</td>
                              <td>${participant.participantName }</td>
                              <td>${participant.designation}</td>
                              <td>${participant.status}</td>
                              <td>${participant.mobile}</td>
                              <td>${participant.accesskey}</td>
                              <td>${participant.dateOfRegistration}</td>
                          <c:choose>
                              <c:when  test="${empty participant.assessment_Completion_date}">
                              <td><span >NA</span></td>
                              </c:when>
                              <c:when test="${not empty participant.assessment_Completion_date}">
                              <td>${participant.assessment_Completion_date}</td>
                              </c:when>
                              </c:choose>
                                  
                                  <c:choose>
                                  <c:when test="${participant.passFailStatus == '1' }">
                                      <td><span class="green">Pass</span></td>
                                  </c:when>
                                  <c:when test="${not empty participant.assessment_Completion_date  && participant.passFailStatus == '0' }">
                                      <td ><span class="red" >Fail</span> </td>
                                  </c:when>
                                  <c:when test="${empty participant.assessment_Completion_date && participant.passFailStatus == '0' }">
                                      <td ><span >NA</span> </td>
                                  </c:when>
                                  </c:choose>	
                      </tr>
                      </c:forEach>
                  </tbody>
            </table>
        </div>
    </div>

    <div id="assessment-report" class="tabcontent">
        <!-- <h3>Assessment Report</h3> -->
        <div class="table-date">
            <!--<div class="export-to-csv"><input type="button" class="ecsvbutton" value="Export To CSV"></div>-->
            <table id="data-ar" cellspacing="0" cellpadding="0" border="0" class="stripe display nowrap cell-border" width="50" style="width: 100% !important;height: auto !important;">
                <thead>
                    <tr>
                        <th data-head="Sr.No." class="sorting" style="z-index:1 !important;"><em>Sr.No.</em></th>
                        <th data-head="Candidate Name" class="sorting" ><em>Candidate Name</em></th>
                        <th data-head="Designation" class="sorting"><em>Designation</em></th>
                        <th data-head="Candidate Status" class="sorting"><em>Percentage</em></th>
                        <th data-head="Mobile" class="sorting"><em>Mobile</em></th>
                        <th data-head="Access Key" class="sorting"><em>Access Key</em></th>
                        <th data-head="Registration Date" class="sorting"><em>Registration Date</em></th>
                        <th data-head="Assessment Date" class="sorting"><em>Assessment Date</em></th> 
                        <th data-head="Assessment Status" class="sorting"><em>Assessment Status</em></th>
                    </tr>
                </thead>
                <tbody>
                      <c:forEach items="${assessmentAll}" var="participant" varStatus="status">
                          <tr>
                              <td>${status.count}</td>
                              <td>${participant.participantName }</td>
                              <td>${participant.designation}</td>
                               <td>${participant.status}</td>
                              <td>${participant.mobile}</td>
                              <td>${participant.accesskey}</td>
                              <td>${participant.dateOfRegistration}</td>
                          <!--	<td>${participant.assessment_Completion_date}</td>        -->
                          <c:choose>
                              <c:when  test="${empty participant.assessment_Completion_date}">
                              <td><span >NA</span></td>
                              </c:when>
                              <c:when test="${not empty participant.assessment_Completion_date}">
                              <td>${participant.assessment_Completion_date}</td>
                              </c:when>
                              </c:choose>
                                  <c:choose>
                                  <c:when test="${participant.passFailStatus == '1' }">
                                      <td><span class="green">Pass</span></td>
                                  </c:when>
                                  <c:when test="${not empty participant.assessment_Completion_date  && participant.passFailStatus == '0' }">
                                      <td ><span class="red" >Fail</span> </td>
                                  </c:when>
                                  <c:when test="${empty participant.assessment_Completion_date && participant.passFailStatus == '0' }">
                                      <td ><span >NA</span> </td>
                                  </c:when>
                                  </c:choose>	
                      </tr>
                      </c:forEach>
                  </tbody>
            </table>
        </div>
    </div>
</div>
<div id="aggregate-report" class="main-tabcontent">
        <div class="table-date">
            <table id="data-agr" cellspacing="0" cellpadding="0" border="0" class="stripe display nowrap cell-border" width="50" style="width: 100% !important;height: auto !important;">
                <thead>
                    <tr>
                        <th data-head="Sr.No." class="sorting" style="z-index:1 !important;"><em>Sr.No.</em></th>
                        <th data-head="Candidate Name" class="sorting" style="z-index:1 !important;"><em>Candidate Name</em><span><img src="./img/filter-icn.svg" /></span></th>
                        <th data-head="Designation" class="sorting"><em>Designation</em></th>
                        <th data-head="Mobile" class="sorting"><em>Mobile</em></th>
                        <th data-head="Access Key" class="sorting"><em>Access Key</em></th>
                        <th data-head="Registration Date" class="sorting"><em>Registration Date</em></th>
                        <th data-head="Assessment Date" class="sorting"><em>Assessment Date</em></th>
                        <th data-head="Assessment Status" class="sorting"><em>Assessment Status</em></th>
                        <th data-head="Funnel" class="sorting"><em>Recruitment Funnel</em></th>
                        <th data-head="Action Points" class="sorting"><em>Action Points</em></th>
                        <th data-head="Source" class="sorting"><em>Source</em></th>
                        <%-- <th data-head="SalesNonSales" class="sorting"><em>Sales/Non-Sales</em></th> --%> 
                        <th data-head="Gender" class="sorting"><em>Gender</em></th>				
                        <th data-head="Experience" class="sorting"><em>Experience</em></th>
                        <th data-head="Age Wise" class="sorting"><em>Age Wise</em></th>
                        <th data-head="Assessment percent" class="sorting"><em>Assessment Percent</em></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${aggregates}" var="aggregate" varStatus="status">
                        <tr>
                            <td>${status.count}</td>
                            <td>${aggregate.name }</td>
                            <td>${aggregate.profile }</td>
                            <td>${aggregate.mobile }</td>
                            <td>${aggregate.accesskey }</td>
                            <td>${aggregate.registrationDate }</td>

                            <c:choose>
                              <c:when  test="${empty aggregate.assessmentDate}">
                              <td><span >NA</span></td>
                              </c:when>
                              <c:when test="${not empty aggregate.assessmentDate}">
                              <td>${aggregate.assessmentDate}</td>
                              </c:when>
                              </c:choose>

                            
                            <%-- <td>${aggregate.passFailStatus }</td> --%>
                             <c:choose>
                                  <c:when test="${aggregate.passFailStatus == '1' }">
                                      <td><span class="green">Pass</span></td>
                                  </c:when>
                                  <c:when test="${not empty aggregate.assessmentDate  && aggregate.passFailStatus == '0' }">
                                      <td ><span class="red" >Fail</span> </td>
                                  </c:when>
                                  <c:when test="${empty aggregate.assessmentDate && aggregate.passFailStatus == '0' }">
                                      <td ><span >NA</span> </td>
                                  </c:when>
                                  </c:choose>

                                  <c:choose>
                                 <c:when test="${aggregate.overview == 'Passed'}">
                                      <td><span>NA</span></td>
                                  </c:when>
                                  <c:when test="${aggregate.overview != 'Passed'}">
                                      <td>${aggregate.overview }</td>
                                  </c:when>
                                  </c:choose>	
                            
                            <td>${aggregate.actionPoints }</td>
                            <td>${aggregate.recruitmentSource }</td>
                           <%--  <td>${aggregate.salesNonSales }</td> --%>
                            <td>${aggregate.gender }</td>
                            <td>${aggregate.expAuto }</td>
                            <td>${aggregate.ageWise }</td>
                             <td>${aggregate.assessmentReport }</td>
                        </tr>
                      </c:forEach>
                  </tbody>
            </table>
        </div>
    </div>
<div id="detailed-assessment-report" class="main-tabcontent">
    <!-- <h3>Detailed Assessment Report</h3> -->
    <div class="report-section"> 
        <div class="report-block">
           <h3>Detailed Report</h3>
           <a href="#" class="csv-icn-button" onclick="exportTocsv('detailedCSV')"><img src="./img/csv-file-icn.svg" />Export to CSV</a>
       </div> 
   </div>
</div>

<div id="question-wise-report" style="display:none" class="main-tabcontent">
    
</div>

<div id="competency-wise-analysis" class="main-tabcontent">
 <center>  <h3>No matching records found</h3>  </center>
    <div class="table-date" style="display:none">
        <div class="export-to-csv"> No data to display!</div> 
        <table id="data-ca" cellspacing="0" cellpadding="0" border="0" class="stripe display nowrap cell-border" width="50" style="width: 100% !important;height: auto !important;">
            <thead>
                <tr>
                    <th data-head="Sr.No." class="sorting" style="z-index: 1 !important;"><em>Sr.No.</em></th>
                    <th data-head="Candidate Name" class="sorting"><em>Candidate Name</em></th>
                    <!-- <th data-head="Designation" class="sorting"><em>Designation</em></th> -->
                    <th data-head="Profile" class="sorting"><em>Profile</em></th>

                    <th data-head="Mobile Number" class="sorting"><em>Mobile Number</em></th>
                    <th data-head="Access Key" class="sorting"><em>Access Key</em></th>
                    <th data-head="Registration Date" class="sorting"><em>Registration Date</em></th>
                    <th data-head="Assessment Date" class="sorting"><em>Assessment Date</em></th>
                    <th data-head="Marks Obtained" class="sorting"><em>Marks Obtained</em></th>
                    <th data-head="Assessment Status" class="sorting"><em>Assessment Status</em></th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>1</td>
                    <td>Vrushali Thakre</td>
                    <td>Vrushali Thakre</td>
                    <td>987654321</td>
                    <td>987654321</td>
                    <td>987654321</td>
                    <td>987654321</td>
                    <td>987654321</td>
                    <td>Test</td>
                </tr>
            </tbody>
        </table>   <!-- TBL -->
    </div> 
</div>
  </div>      
  <div class="blk-bg"></div>
        <script src="./js/jquery.dataTables.min.js"></script>
        <script src="./js/reportDataTable.js"></script>
         
<script type="text/javascript" src="https://cdn.datatables.net/buttons/2.3.2/js/dataTables.buttons.min.js"></script> 
<script type="text/javascript" src="https://cdn.datatables.net/buttons/2.3.2/js/buttons.html5.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/buttons/2.3.2/js/buttons.print.min.js"></script>
	
	<input type='hidden' id='filename1' value='Recruitment Funnel'>

	<input type='hidden' id='filename2' value='Action Points'>
	<input type='hidden' id='filename3' value='Recruitment Source'>
	<input type='hidden' id='filename4' value='Sales Non-Sales'>
	<input type='hidden' id='filename5' value='Gender Diversity'>
	<input type='hidden' id='filename6' value='Experience'>
	<input type='hidden' id='filename7' value='Age Wise'>
	<input type='hidden' id='filename8' value='Assessment Report'>
	<input type='hidden' id='filename9' value='Assessment Report'>
	<input type='hidden' id='filename11' value='Overview'>
 
        <script>
            function openPageMain(pageName,elmnt,color) {
                var i, tabcontent, tablinks;
                tabcontent = document.getElementsByClassName("main-tabcontent");
                for (i = 0; i < tabcontent.length; i++) {
                    tabcontent[i].style.display = "none";
                }
                tablinks = document.getElementsByClassName("main-tablink");
                for (i = 0; i < tablinks.length; i++) {
                    tablinks[i].style.backgroundColor = "";
                    tablinks[i].style.color = "";
                }
                console.log('1'+pageName);
                document.getElementById(pageName).style.display = "block";
                console.log('2'+pageName);
                elmnt.style.backgroundColor = color;
                elmnt.style.color = '#fff';
            }
            
            // Get the element with id="defaultOpen" and click on it
            document.getElementById("default-tab").click();

            function openPage(pageName,elmnt,color) {
                console.log(document.getElementById(pageName));
                console.log(document.getElementsByClassName("tabcontent"));
                var i, tabcontent, tablinks;
                tabcontent = document.getElementsByClassName("tabcontent");
                for (i = 0; i < tabcontent.length; i++) {
                    tabcontent[i].style.display = "none";
                }
                tablinks = document.getElementsByClassName("tablink");
                for (i = 0; i < tablinks.length; i++) {
                    tablinks[i].style.backgroundColor = "";
                    tablinks[i].style.color = "";
                }
                document.getElementById(pageName).style.display = "block";
                elmnt.style.backgroundColor = color;
                elmnt.style.color = '#fff';
            }
            
            // Get the element with id="defaultOpen" and click on it
            //document.getElementById("aggregateF").click();
        </script>
            <script>
                $(document).ready(function(){
                	var form = $('#formFilter');
              	  form.attr('action', 'showAllLinksCSV');
                	
                    /*Default Open Window From Dashboard Click*/
                    var flag2 = `${flag}`;
			        if(flag2.length>2){
        	        document.getElementById("OverF").click();
        	        document.getElementById(flag2).click();
			        }
                    $('#QBA').click(function(){
                        window.location.href='./qb-analysis';
                    });
        });
        function exportTocsv(reportName){
             var dateFromm =$('#dateFromm').val();
		    var dateToo =$('#dateToo').val();
            url="./"+reportName+"?dateFromm="+dateFromm+"&dateToo="+dateToo;
        	window.location.href=url;     	
        }
        
        </script>

<!-- <script>
    var coll = document.getElementsByClassName("collapsible");
    var i;
    
    for (i = 0; i < coll.length; i++) {
        coll[i].addEventListener("click", function() {
            this.classList.toggle("active");
            var content = this.nextElementSibling;
            if (content.style.maxHeight){
                content.style.maxHeight = null;
            } else {
                content.style.maxHeight = content.scrollHeight + "px";
            } 
        });
    }
</script> -->
<script type="text/javascript">
    function getAnalyticsByAccesskeyList(list,status){
        var accesskeyList = JSON.stringify(list);
        accesskeyList=accesskeyList.replace('[','');
        accesskeyList=accesskeyList.replace(']','');
        if(accesskeyList.length>5){	
            mywindow=window.open("analyticsByAccesskey?accesskeyList="+accesskeyList+"&status="+status, "detailwindow","resizable=1,scrollbars=1,width=1170,height=600");
 	       		mywindow.moveTo(120,90);  
    		}    		
    	}
    	
        </script>
      <script type="text/javascript">
          function getAnalyticsByAccesskeyList(list,id){
              var status = "Overview";
              var accesskeyList = JSON.stringify(list);
              accesskeyList=accesskeyList.replace('[','');
              accesskeyList=accesskeyList.replace(']','');
              $.ajax({
                  type:"get",
                  url:"analyticsByAccesskey",
                  data:"accesskeyList="+accesskeyList+"&status="+status,
                  success:function(response){
                      $("#"+id).html(response);
                    },
                    error:function(resp){
                    }
                });    		
            }
			
			
			function getAssessmentReport(){
             
			  //$("#assessment-report").css("display", "block");
			  //$("#assessment-report"),show();
            

                  window.location.href='./assessmentReport';				
            }
            
    </script>
  
</body>  
    <style>
        #data-ov_paginate a.paginate_button.current, #data-ap_paginate a.paginate_button.current, #data-rs_paginate a.paginate_button.current, #data-sns_paginate a.paginate_button.current, #data-gd_paginate a.paginate_button.current, #data-ce_paginate a.paginate_button.current, #data-aw_paginate a.paginate_button.current, #data-ar_paginate a.paginate_button.current, #data-qa_paginate a.paginate_button.current, #data-ca_paginate a.paginate_button.current{background: rgb(193 193 193) !important}
        #data-ov_paginate a, #data-ap_paginate a, #data-rs_paginate a, #data-sns_paginate a, #data-gd_paginate a, #data-ce_paginate a, #data-aw_paginate a, #data-ar_paginate a, #data-qa_paginate a, #data-ca_paginate a, #data-agr_paginate a{margin-left: 20px !important;text-decoration: none !important;display: inline-block !important;padding: 7px 20px !important;font-size: 13px;line-height: 20px;color: #fff !important;border-radius: 20px !important;border: none !important;background-color: #DC3545 !important;cursor: pointer !important;}
        #data-ov_paginate, #data-ap_paginate, #data-rs_paginate, #data-sns_paginate, #data-gd_paginate, #data-ce_paginate, #data-aw_paginate, #data-ar_paginate, #data-qa_paginate, #data-ca_paginate{margin: 30px 0 0;width: 100%;text-align: center}
        /* table.dataTable thead>tr>th.sorting:nth-child(2) {left: 83px !important;} */
        table.dataTable thead>tr>th.sorting{cursor: pointer;position: relative;padding-right: 50px;}
        table.dataTable thead>tr>th.sorting:before{position: absolute;display: block;opacity: .125;right: 10px !important;line-height: 9px;font-size: .9em;}
         /* table.dataTable tbody td{
            padding: 8px 14px !important;
        } */
        /* .table-date table tr:nth-child(2) {
            left: 88px !important;
        } */

        /* td.dtfc-fixed-left:nth-child(2) {left: 83px !important;} */
        .dtfc-fixed-left:nth-child(2){
            position: unset !important;
            left: 0 !important;
        }
        </style>
        <script>
           
        </script>
       	<script type="text/javascript" src="./js/table2csv.js"></script>
        <script src="https://cdn.datatables.net/fixedcolumns/4.2.1/js/dataTables.fixedColumns.min.js"></script>

</html>
<%     }else{
    response.sendRedirect("login");
}
}catch(Exception e)
{
	System.out.println("Errror....."+e);
    	  response.sendRedirect("login");
    }
    %>