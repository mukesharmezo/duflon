<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import = "java.util.ResourceBundle" %>

<%
try
    {
	ResourceBundle resource = ResourceBundle.getBundle("application");
String baseServer = resource.getString("client.url");
 String assessUrl = resource.getString("client.asseesment");
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
	<link rel="icon" type="image/x-icon" href="<%=baseServer%>img/iRecruit-favicon.ico"/>
    <title>iRecruit</title>
    
    <script src="./js/jquery-3.4.1.min.js"></script>
    
    <link rel="stylesheet" type="text/css" href="./css/common.css" />
    <link rel="stylesheet" type="text/css" href="./css/hiring-in-process.css" />
    <link rel="stylesheet" type="text/css" href="./css/sweetalert.css"/>
    <script type="text/javascript" src="./js/sweetalert.min.js"></script>
	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.12.1/css/jquery.dataTables.min.css">
    <link rel="stylesheet" type="text/css" href="./css/datatable.css">
    
    <!-- <script>
        var table = $('#data').DataTable({
            "pageLength": 10,
            scrollY: '425px',
            scrollCollapse: true,
            scrollX: true,
            fixedColumns:   {
                left: 2
            }
        });
    </script> -->

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
        .csv-icn-button{text-decoration: none; display: flex; align-items: center; color: #fff; font-size: 13px; line-height: 15px;margin-right: 20px; padding: 10px 15px; border-radius: 30px; background-color: #171c8f; text-transform: uppercase;}
        .csv-icn-button img{margin-right: 8px;}
        .collapsible {background-color:#fff; color: #000; cursor: pointer;padding: 18px;width: 100%;border: none;text-align: left;outline: none;font-size: 15px;border-radius: 10px;margin: 20px 0px 20px 0px;}
        .collapsible:after {content: '\002B';color:#000;font-weight: bold;margin-left: 5px;}
        /* .collapsible:after:hover {content: '\002B';color: white;font-weight: bold;margin-left: 5px;} */
        .collapsible:hover {background-color:#2a3740; color: #fff !important;}
        .active:after {content: "\2212";color: #fff;} 
        .content {width: 100%;padding: 0 18px;max-height: 0;overflow: hidden;transition: max-height 0.2s ease-out;background-color: #f1f1f1;display: flex;}
        .report-section.ir-report .collapsible.active ~ .content{max-height: unset !important;}
        button.collapsible {font-weight: 600;font-size: 17px;}
        .ir-report-tab-wrap{display:flex;align-items:center;flex-wrap: wrap; width:calc(106% - 10px);margin-top: 10px;}
        /* margin-top: 35px !important;} */
        .page-filters-filter{margin-top:25px !important;}
        .tablink , .main-tablink {margin: 0px 5px 0px 0px;border-radius: 5px;border: 1px solid #2a3740;/* background-color: #fff; */ color: #000;float: left;outline: none;cursor: pointer;padding:5px 5px;font-size: 12px;width:calc(15% - 10px);}
        /* .page-filters {margin-top: 23px !important} */
        .main-tablink {margin: 5px 5px 0px 0px;border-radius: 30px;border: 1px solid #2a3740;/* background-color: #fff; */color: #000;float: left;/* border: none; */outline: none;cursor: pointer;padding:8px 5px;font-size: 15px;width:calc(19% - 5px);}
        .tablink:hover, .main-tablink:hover {color: #fff;background-color: #2a3740}
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
        .export-to-csv .ecsvbutton{background: #2a3740 !important;color: #fff !important;}
        .dataTables_scrollBody{position: relative;overflow-y: hidden !important;overflow: auto;width: 100%;max-height:445px !important;}
        .dt-buttons {display: inline-flex;width: calc(100% - 230px);}
        .buttons-csv.buttons-html5.ecsvbutton {margin-left: auto;}
        .dataTables_wrapper .dataTables_filter input{border:1px solid #171c8f !important;}
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
    
          
            <!-- <div class="page-filters">
                <div class="page-filters-block">
                    <div class="filter"> -->
                      
                        
                        <!-- <button class="page-filters-date">Date:
                            <span id="reportrange">1 November, 2022 - 30 November, 2022</span>
                        </button>   -->   
                    <!-- </div>  -->
                <!-- </div> -->
            <!-- </div> -->
            <div class="right-section">
                <div class="page-filter-include">
                    <%@include file="./filter/dashboardReportFilter.jsp"%>
		         </div> 
        
        <!-- <div class="ir-report-tab-wrap-main"> -->
            <div class="ir-report-tab-wrap">
                <%--    <button class="tablink" onclick="openPage('overview', this, '#2a3740 '); getAnalyticsByAccesskeyList('${overviewSet}','overview')">Overview</button>
                <button class="tablink" onclick="openPage('action-points', this, '#2a3740 ')">Action Points</button>
                <button class="tablink" onclick="openPage('recruitment-source', this, '#2a3740 '); getAnalyticsByAccesskeyList('${sourceSet}','recruitment-source')">Recruitment Source</button>
                <button class="tablink" onclick="openPage('sales/non-sales', this, '#2a3740 '); getAnalyticsByAccesskeyList('${desgSet}','sales-non-sales')">Sales/Non-Sales</button>
                <button class="tablink" onclick="openPage('gender-diversity', this, '#2a3740 ')">Gender Diversity</button>
                <button class="tablink" onclick="openPage('candidate-experience', this, '#2a3740 '); getAnalyticsByAccesskeyList('${expAutoSet}','candidate-experience')">Candidate Experience</button>
                <button class="tablink" onclick="openPage('age-wise', this, '#2a3740 '); getAnalyticsByAccesskeyList('${ageSet}','age-wise')">Age Wise</button>
                <button class="tablink" onclick="openPage('assessment-report', this, '#2a3740 '); getAnalyticsByAccesskeyList('${assessmentSet}','assessment-report')">Assessment Report</button>
                --%>   
                
                <button class="main-tablink" id="default-tab" onclick="openPageMain('default', this, '#2a3740 ')" style="display:none;">Default</button>
                <button class="main-tablink" id="OverF" onclick="openPageMain('dashboard', this, '#2a3740 ')">Dashboard</button>
                <button class="main-tablink" onclick="openPageMain('detailed-assessment-report', this, '#2a3740 ')">Detailed Report</button>
				<%if(role.equalsIgnoreCase("HO") || role.equalsIgnoreCase("SA")) {%>
                <button class="main-tablink" id="QBA" onclick="openPageMain('question-wise-report', this, '#2a3740 ')">Question Wise Analysis</button>
                <button class="main-tablink" id="ComAnasdfdsf" onclick="openPageMain('competency-wise-analysis', this, '#2a3740 ')">Competency Analysis</button>
                <%if(role.equalsIgnoreCase("SuperAdmin")) {%>
                <button class="main-tablink" id="AssessRepo" onclick="openPageMain('ir-assessment-report', this, '#2a3740 ');getAssessmentReport();">Assessment Report</button>
                <%}%>
                <%}%>
                
            </div>
            
  

<div id="default" class="main-tabcontent">
    <h3>Please click on the required button above to fetch relevant report.</h3>
</div>

<div id="dashboard" class="main-tabcontent">
    <div class="ir-report-tab-wrap" style="margin-top: 10px !important;">
        <button class="tablink" id="aggregateF" onclick="openPage('aggregate-report', this, '#2a3740 ')">Overview</button>
        <button class="tablink" id="overviewF" onclick="openPage('overview', this, '#2a3740 ')">Recruitment Funnel</button>
        <button class="tablink" id="actionF" onclick="openPage('action-points', this, '#2a3740 ')">Action Points</button>
        <%if(role.equalsIgnoreCase("DL")) {%>
        <button class="tablink" id="recruitmentF" onclick="openPage('recruitment-source', this, '#2a3740 ')">Recruitment Source</button>
        <button class="tablink" id="salesF" onclick="openPage('sales/non-sales', this, '#2a3740 ')">Sales/Non-Sales</button>
        </div>
        <div class="ir-report-tab-wrap">
        <button class="tablink" id="genderF" onclick="openPage('gender-diversity', this, '#2a3740 ')">Gender Diversity</button>
        <button class="tablink" id="expF" onclick="openPage('candidate-experience', this, '#2a3740 ')">Candidate Experience</button>
        <button class="tablink" id="ageF" onclick="openPage('age-wise', this, '#2a3740 ')">Age Wise</button>
        <button class="tablink" id="assessmentF" onclick="openPage('assessment-report', this, '#2a3740 ')">Assessment Report</button>
        <!-- <button class="tablink" id="salesF" onclick="openPage('sales/non-sales', this, '#2D3392 ')">Sales/Non-Sales</button> -->
        <%}%>
    </div>
    <div id="overview" class="tabcontent">
        <!-- <h3>Overview</h3> -->
        <div class="table-date">
            <!--<div class="export-to-csv"><input type="button" class="ecsvbutton" value="Export To CSV" onclick="downloadExcelOV()"></div>-->
            <table id="data-ov" cellspacing="0" cellpadding="0" border="0" class="stripe display nowrap cell-border data-table" width="50" style="width: 100% !important;height: auto !important;">
                <thead>
                    <tr>
                        <th data-head="Sr.No." class="sorting" style="z-index: 1 !important;"><em>Sr.No.</em></th>
                        <th data-head="Region" class="sorting"><em>Region</em></th>
                        <th data-head="Dealer City" class="sorting"><em>Dealer City</em></th>
                        <th data-head="Dealership" class="sorting" style="min-width: 150px !important;"><em>Dealership</em></th>
                        <th data-head="Dealer Code" class="sorting" ><em>Dealer Code</em></th>
                        <th data-head="Candidate Name" class="sorting"><em>Candidate Name</em></th>
                        <th data-head="Profile" class="sorting"><em>Profile</em></th>
                        <th data-head="Candidate Status" class="sorting"><em>Candidate Status</em></th>
                        <c:if test="${(role eq 'DL')}">
                        <th data-head="Designation Code" class="sorting"><em>Designation Code</em></th>
                        </c:if>
                        <th data-head="MSPIN" class="sorting"><em>MSPIN</em></th>
                        <c:if test="${(role eq 'DL')}">
                        <th data-head="Mobile" class="sorting"><em>Mobile</em></th>
                        </c:if>
                        <th data-head="Access Key" class="sorting"><em>Access Key</em></th>
                        <th data-head="Registration Date" class="sorting"><em>Registration Date</em></th>
                        <th data-head="Assessment Date" class="sorting"><em>Assessment Date</em></th> 
                       <%--  <th data-head="Marks Obtained" class="sorting"><em>Marks Obtained</em></th>	 --%>			
                        <th data-head="Assessment Status" class="sorting"><em>Assessment Status</em></th>
                    </tr>
                </thead>
                <tbody>
                    <%int h=1; %>
                    <c:forEach items="${overviewAll}" var="participant">
                    <c:if test="${(role eq 'DL') || (participant.status eq 'Recruited' &&  (role eq 'HO' || role eq 'FS' || role eq 'SA'))}">
                        <tr>
                            <td><%=h %></td>
                            <td>${participant.regionCode}</td>
                              <td>${participant.city}</td>
                              <td>${participant.dealerName}</td>
                               <td>${participant.dealerCode}</td>
                            <td>${participant.participantName }</td>
                            <td>${participant.designation}</td>

                            <c:choose>
                                 <c:when test="${participant.designation == 'Sales Support' && participant.status == 'Passed'}">
                                      <td><span>NA</span></td>
                                  </c:when>
                                  <c:when test="${participant.designation == 'Sales Support' && participant.status != 'Passed'}">
                                        <td>${participant.status}</td>
                                  </c:when>
                                  <c:when test="${participant.designation == 'Sales' || participant.designation == 'Sourcing'}">
                                      <td>${participant.status}</td>
                                  </c:when>
                                </c:choose>


                            
                            <c:if test="${(role eq 'DL')}">
                                <td>${participant.finalDesignationCode}</td>
                            </c:if>
                            <td>${participant.mspin}</td>
                            <c:if test="${(role eq 'DL')}">
                                <td>${participant.mobile}</td>
                            </c:if>
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
                                <c:when test="${participant.designation == 'Sales Suppurt' }">
                                    <td><span>NA</span></td>
                                </c:when>
                            </c:choose>	
                            												
                        </tr>
                        <%h++; %>
                    </c:if>
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
                        <th data-head="Region" class="sorting"><em>Region</em></th>
                        <th data-head="Dealer City" class="sorting"><em>Dealer City</em></th>
                        <th data-head="Dealership" class="sorting" style="min-width: 150px !important;"><em>Dealership</em></th>
                        <th data-head="Dealer Code" class="sorting"><em>Dealer Code</em></th>
                        <th data-head="Candidate Name" class="sorting" ><em>Candidate Name</em></th>
                        <th data-head="Profile" class="sorting"><em>Profile</em></th>
                        <th data-head="Candidate Status" class="sorting"><em>Pending Action</em></th>
                        <th data-head="Designation Code" class="sorting"><em>Designation Code</em></th>
                        <th data-head="MSPIN" class="sorting"><em>MSPIN</em></th>
                        <th data-head="Mobile" class="sorting"><em>Mobile</em></th>
                        <th data-head="Access Key" class="sorting"><em>Access Key</em></th>
                        <th data-head="Registration Date" class="sorting"><em>Registration Date</em></th>
                        <th data-head="Assessment Date" class="sorting"><em>Assessment Date</em></th> 			
                        <th data-head="Assessment Status" class="sorting"><em>Assessment Status</em></th>
                    </tr>
                </thead>
                <tbody>
                      <%int i=1; %>
                      <c:forEach items="${actionAll}" var="participant">
                     <c:if test="${(role eq 'DL') || ((participant.status eq 'Praarambh' || participant.status eq 'FSDM Approval') &&  (role eq 'HO' || role eq 'FS' || role eq 'SA'))}">
                          <tr>
                              <td><%=i %></td>
                              <td>${participant.regionCode}</td>
                              <td>${participant.city}</td>
                              <td>${participant.dealerName}</td>
                               <td>${participant.dealerCode}</td>
                              <td>${participant.participantName }</td>
                              <td>${participant.designation}</td>
                              <td>${participant.status}</td>
                              <td>${participant.finalDesignationCode}</td>
                              <td>${participant.mspin}</td>
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
                                  <c:when test="${participant.designation == 'Sales Support' }">
                                      <td><span>NA</span></td>
                                  </c:when>
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
                        <%i++; %>
                      </c:if>
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
                        <th data-head="Region" class="sorting"><em>Region</em></th>
                        <th data-head="Dealer City" class="sorting"><em>Dealer City</em></th>
                        <th data-head="Dealership" class="sorting" style="min-width: 150px !important;"><em>Dealership</em></th>
                        <th data-head="Dealer Code" class="sorting"><em>Dealer Code</em></th>
                        <th data-head="Candidate Name" class="sorting"><em>Candidate Name</em></th>
                        <th data-head="Profile" class="sorting"><em>Profile</em></th>
                        <th data-head="Candidate Status" class="sorting"><em>Recruitment Source</em></th>
                        <th data-head="Designation Code" class="sorting"><em>Designation Code</em></th>
                        <th data-head="MSPIN" class="sorting"><em>MSPIN</em></th>
                        <th data-head="Mobile" class="sorting"><em>Mobile</em></th>
                        <th data-head="Access Key" class="sorting"><em>Access Key</em></th>
                        <th data-head="Registration Date" class="sorting"><em>Registration Date</em></th>
                        <th data-head="Assessment Date" class="sorting"><em>Assessment Date</em></th> 			
                        <th data-head="Assessment Status" class="sorting"><em>Assessment Status</em></th>
                    </tr>
                </thead>
                <tbody>
                      <%int j=1; %>
                      <c:forEach items="${sourceAll}" var="participant">
                          <tr>
                              <td><%=j %></td>
                              <td>${participant.regionCode}</td>
                              <td>${participant.city}</td>
                              <td>${participant.dealerName}</td>
                               <td>${participant.dealerCode}</td>
                              <td>${participant.participantName }</td>
                              <td>${participant.designation}</td>
                              <td>${participant.status}</td>
                              <td>${participant.finalDesignationCode}</td>
                              <td>${participant.mspin}</td>
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
                                  <c:when test="${participant.designation == 'Sales Support' }">
                                      <td><span>NA</span></td>
                                  </c:when>
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
                      <%j++; %>
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
                        <th data-head="Region" class="sorting"><em>Region</em></th>
                        <th data-head="Dealer City" class="sorting"><em>Dealer City</em></th>
                        <th data-head="Dealership" class="sorting" style="min-width: 150px !important;"><em>Dealership</em></th>
                        <th data-head="Dealer Code" class="sorting"><em>Dealer Code</em></th>
                        <th data-head="Candidate Name" class="sorting"><em>Candidate Name</em></th>
                        <th data-head="Profile" class="sorting"><em>Profile</em></th>
                        <th data-head="Designation Code" class="sorting"><em>Designation Code</em></th>
                        <th data-head="MSPIN" class="sorting"><em>MSPIN</em></th>
                        <th data-head="Mobile" class="sorting"><em>Mobile</em></th>
                        <th data-head="Access Key" class="sorting"><em>Access Key</em></th>
                        <th data-head="Registration Date" class="sorting"><em>Registration Date</em></th>
                        <th data-head="Assessment Date" class="sorting"><em>Assessment Date</em></th> 
                        <%-- <th data-head="Marks Obtained" class="sorting"><em>Marks Obtained</em></th>	 --%>			
                        <th data-head="Assessment Status" class="sorting"><em>Assessment Status</em></th>
                    </tr>
                </thead>
                <tbody>
                      <%int k=1; %>
                      <c:forEach items="${desgAll}" var="participant">
                          <tr>
                              <td><%=k %></td>
                              <td>${participant.regionCode}</td>
                              <td>${participant.city}</td>
                              <td>${participant.dealerName}</td>
                               <td>${participant.dealerCode}</td>
                              <td>${participant.participantName }</td>
                              <td>${participant.designation}</td>
                              <td>${participant.finalDesignationCode}</td>
                              <td>${participant.mspin}</td>
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
                                  <%-- <c:choose>
                                  <c:when  test="${empty participant.assessment_Completion_date && empty participant.testScore }">
                              <td><span >NA</span></td>
                              </c:when>
                                  <c:when test="${participant.passFailStatus == '1' }">
                                  <td><span class="green">${participant.testScore} </span></td>
                                      </c:when>
                                  <c:when test="${participant.passFailStatus == '0' }">
                                  <td><span class="red">${participant.testScore} </span></td>
                                  </c:when>
                                  </c:choose> --%>
                              
                                  <c:choose>
                                  <c:when test="${participant.designation == 'Sales Support' }">
                                      <td><span>NA</span></td>
                                  </c:when>
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
                      <%k++; %>
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
                        <th data-head="Region" class="sorting"><em>Region</em></th>
                        <th data-head="Dealer City" class="sorting"><em>Dealer City</em></th>
                        <th data-head="Dealership" class="sorting" style="min-width: 150px !important;"><em>Dealership</em></th>
                        <th data-head="Dealer Code" class="sorting"><em>Dealer Code</em></th>
                        <th data-head="Candidate Name" class="sorting"><em>Candidate Name</em></th>
                        <th data-head="Profile" class="sorting"><em>Profile</em></th>
                        <th data-head="Candidate Status" class="sorting"><em>Gender</em></th>
                        <th data-head="Designation Code" class="sorting"><em>Designation Code</em></th>
                        <th data-head="MSPIN" class="sorting"><em>MSPIN</em></th>
                        <th data-head="Mobile" class="sorting"><em>Mobile</em></th>
                        <th data-head="Access Key" class="sorting"><em>Access Key</em></th>
                        <th data-head="Registration Date" class="sorting"><em>Registration Date</em></th>
                        <th data-head="Assessment Date" class="sorting"><em>Assessment Date</em></th> 			
                        <th data-head="Assessment Status" class="sorting"><em>Assessment Status</em></th>
                    </tr>
                </thead>
                <tbody>
                      <%int l=1; %>
                      <c:forEach items="${genderAll}" var="participant">
                          <tr>
                              <td><%=l %></td>
                              <td>${participant.regionCode}</td>
                              <td>${participant.city}</td>
                              <td>${participant.dealerName}</td>
                               <td>${participant.dealerCode}</td>
                              <td>${participant.participantName }</td>
                              <td>${participant.designation}</td>
                              <td>${participant.status}</td>
                              <td>${participant.finalDesignationCode}</td>
                              <td>${participant.mspin}</td>
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
                                  <c:when test="${participant.designation == 'Sales Support' }">
                                      <td><span>NA</span></td>
                                  </c:when>
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
                      <%l++; %>
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
                        <th data-head="Region" class="sorting"><em>Region</em></th>
                        <th data-head="Dealer City" class="sorting"><em>Dealer City</em></th>
                        <th data-head="Dealership" class="sorting" style="min-width: 150px !important;"><em>Dealership</em></th>
                        <th data-head="Dealer Code" class="sorting"><em>Dealer Code</em></th>
                        <th data-head="Candidate Name" class="sorting"><em>Candidate Name</em></th>
                        <th data-head="Profile" class="sorting"><em>Profile</em></th>
                         <th data-head="Candidate Status" class="sorting"><em>Auto Experience</em></th>
                        <th data-head="Candidate Status" class="sorting"><em>Non-Auto Experience</em></th>
                        <th data-head="Designation Code" class="sorting"><em>Designation Code</em></th>
                        <th data-head="MSPIN" class="sorting"><em>MSPIN</em></th>
                        <th data-head="Mobile" class="sorting"><em>Mobile</em></th>
                        <th data-head="Access Key" class="sorting"><em>Access Key</em></th>
                        <th data-head="Registration Date" class="sorting"><em>Registration Date</em></th>
                        <th data-head="Assessment Date" class="sorting"><em>Assessment Date</em></th> 			
                        <th data-head="Assessment Status" class="sorting"><em>Assessment Status</em></th>
                    </tr>
                </thead>
                <tbody>
                      <%int m=1; %>
                      <c:forEach items="${expAutoAll}" var="participant">
                          <tr>
                              <td><%=m %></td>
                              <td>${participant.regionCode}</td>
                              <td>${participant.city}</td>
                              <td>${participant.dealerName}</td>
                               <td>${participant.dealerCode}</td>
                              <td>${participant.participantName }</td>
                              <td>${participant.designation}</td>
                              <td>${participant.status}</td>
                              <td>${participant.expNonAutoStatus}</td>
                              <td>${participant.finalDesignationCode}</td>
                              <td>${participant.mspin}</td>
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
                                  <c:when test="${participant.designation == 'Sales Support' }">
                                      <td><span>NA</span></td>
                                  </c:when>
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
                      <%m++; %>
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
                        <th data-head="Region" class="sorting"><em>Region</em></th>
                        <th data-head="Dealer City" class="sorting"><em>Dealer City</em></th>
                        <th data-head="Dealership" class="sorting" style="min-width: 150px !important;"><em>Dealership</em></th>
                        <th data-head="Dealer Code" class="sorting"><em>Dealer Code</em></th>
                        <th data-head="Candidate Name" class="sorting"><em>Candidate Name</em></th>
                        <th data-head="Profile" class="sorting"><em>Profile</em></th>
                        <th data-head="Candidate Status" class="sorting"><em>Age</em></th>
                        <th data-head="Designation Code" class="sorting"><em>Designation Code</em></th>
                        <th data-head="MSPIN" class="sorting"><em>MSPIN</em></th>
                        <th data-head="Mobile" class="sorting"><em>Mobile</em></th>
                        <th data-head="Access Key" class="sorting"><em>Access Key</em></th>
                        <th data-head="Registration Date" class="sorting"><em>Registration Date</em></th>
                        <th data-head="Assessment Date" class="sorting"><em>Assessment Date</em></th> 
                        <th data-head="Assessment Status" class="sorting"><em>Assessment Status</em></th>
                    </tr>
                </thead>
                <tbody>
                      <%int n=1; %>
                      <c:forEach items="${ageAll}" var="participant">
                          <tr>
                              <td><%=n %></td>
                              <td>${participant.regionCode}</td>
                              <td>${participant.city}</td>
                              <td>${participant.dealerName}</td>
                               <td>${participant.dealerCode}</td>
                              <td>${participant.participantName }</td>
                              <td>${participant.designation}</td>
                              <td>${participant.status}</td>
                              <td>${participant.finalDesignationCode}</td>
                              <td>${participant.mspin}</td>
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
                                  <c:when test="${participant.designation == 'Sales Support' }">
                                      <td><span>NA</span></td>
                                  </c:when>
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
                      <%n++; %>
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
                        <th data-head="Region" class="sorting"><em>Region</em></th>
                        <th data-head="Dealer City" class="sorting"><em>Dealer City</em></th>
                        <th data-head="Dealership" class="sorting" style="min-width: 150px !important;"><em>Dealership</em></th>
                        <th data-head="Dealer Code" class="sorting"><em>Dealer Code</em></th>
                        <th data-head="Candidate Name" class="sorting"><em>Candidate Name</em></th>
                        <th data-head="Profile" class="sorting"><em>Profile</em></th>
                        <th data-head="Candidate Status" class="sorting"><em>Percentage</em></th>
                        <th data-head="Designation Code" class="sorting"><em>Designation Code</em></th>
                        <th data-head="MSPIN" class="sorting"><em>MSPIN</em></th>
                        <th data-head="Mobile" class="sorting"><em>Mobile</em></th>
                        <th data-head="Access Key" class="sorting"><em>Access Key</em></th>
                        <th data-head="Registration Date" class="sorting"><em>Registration Date</em></th>
                        <th data-head="Assessment Date" class="sorting"><em>Assessment Date</em></th> 
                        <th data-head="Assessment Status" class="sorting"><em>Assessment Status</em></th>
                    </tr>
                </thead>
                <tbody>
                      <%int o=1; %>
                      <c:forEach items="${assessmentAll}" var="participant">
                          <tr>
                              <td><%=o %></td>
                              <td>${participant.regionCode}</td>
                              <td>${participant.city}</td>
                              <td>${participant.dealerName}</td>
                               <td>${participant.dealerCode}</td>
                              <td>${participant.participantName }</td>
                              <td>${participant.designation}</td>
                        
                                      <td>${participant.status}</td>
                                  
                             
                              <td>${participant.finalDesignationCode}</td>
                              <td>${participant.mspin}</td>
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
                                  <c:when test="${participant.designation == 'Sales Support' }">
                                      <td><span>NA</span></td>
                                  </c:when>
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
                      <%o++; %>
                      </c:forEach>
                  </tbody>
            </table>
        </div>
    </div>

    <div id="aggregate-report" class="tabcontent">
        <!-- <h3>Aggregate Report</h3> -->
        <div class="table-date">
            <!--<div class="export-to-csv"><input type="button" class="ecsvbutton" value="Export To CSV"></div>-->
            <table id="data-agr" cellspacing="0" cellpadding="0" border="0" class="stripe display nowrap cell-border" width="50" style="width: 100% !important;height: auto !important;">
                <thead>
                    <tr>
                        <th data-head="Sr.No." class="sorting" style="z-index:1 !important;"><em>Sr.No.</em></th>
                        <th data-head="Region" class="sorting"><em>Region</em></th>
                        <th data-head="Dealer City" class="sorting"><em>Dealer City</em></th>
                        <th data-head="Dealership" class="sorting" style="min-width: 150px !important;"><em>Dealership</em></th>
                        <th data-head="Dealer Code" class="sorting"><em>Dealer Code</em></th>
                        <th data-head="Candidate Name" class="sorting" ><em>Candidate Name</em></th>
                        <th data-head="Profile" class="sorting"><em>Profile</em></th>
                        <c:if test="${(role eq 'DL')}">
                        <th data-head="Designation Code" class="sorting"><em>Designation Code</em></th>
                        </c:if>
                        <th data-head="MSPIN" class="sorting"><em>MSPIN</em></th>
                        <c:if test="${(role eq 'DL')}">
                        <th data-head="Mobile" class="sorting"><em>Mobile</em></th>
                        </c:if>
                        <th data-head="Access Key" class="sorting"><em>Access Key</em></th>
                        <th data-head="Registration Date" class="sorting"><em>Registration Date</em></th>
                        <th data-head="Assessment Date" class="sorting"><em>Assessment Date</em></th>
                        <th data-head="Assessment Status" class="sorting"><em>Assessment Status</em></th>
                        <th data-head="Funnel" class="sorting"><em>Recruitment Funnel</em></th>
                        <th data-head="Action Points" class="sorting"><em>Action Points</em></th>
                        <th data-head="Source" class="sorting"><em>Source</em></th>
                        <%-- <th data-head="SalesNonSales" class="sorting"><em>Sales/Non-Sales</em></th> --%> 
                        <th data-head="Gender" class="sorting"><em>Gender</em></th>				
                        <th data-head="Auto" class="sorting"><em>Experience Auto</em></th>
                        <th data-head="NonAuto" class="sorting"><em>Experience Non-Auto</em></th>
                        <th data-head="Age Wise" class="sorting"><em>Age Wise</em></th>
                        <th data-head="Assessment percent" class="sorting"><em>Assessment Percent</em></th>
                    </tr>
                </thead>
                <tbody>
                <%int p=1; %>
                    <c:forEach items="${aggregates}" var="aggregate">
                      <c:if test="${(role eq 'DL') || ((aggregate.overview eq 'Recruited') &&  (role eq 'HO' || role eq 'FS' || role eq 'SA'))}">
                        <tr>
                            <td><%=p %></td>
                            <td>${aggregate.region }</td>
                            <td>${aggregate.dealerCity }</td>
                            <td>${aggregate.dealership }</td>
                               <td>${aggregate.dealerCode }</td>
                            <td>${aggregate.name }</td>
                            <td>${aggregate.profile }</td>
                            <c:if test="${(role eq 'DL')}">
                            <td>${aggregate.finalDesignationCode }</td>
                            </c:if>
                            <td>${aggregate.mspin }</td>
                            <c:if test="${(role eq 'DL')}">
                            <td>${aggregate.mobile }</td>
                            </c:if>
                            <td>${aggregate.accesskey }</td>
                            <td>${aggregate.registrationDate }</td>
                            <%-- <td>${aggregate.assessmentDate }</td> --%>
                            <%-- <td>${aggregate.testScore }</td> --%>

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
                                 <c:when test="${aggregate.profile == 'Sales Support' }">
                                      <td><span>NA</span></td>
                                  </c:when>
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
                                 <c:when test="${aggregate.profile == 'Sales Support' && aggregate.overview == 'Passed'}">
                                      <td><span>NA</span></td>
                                  </c:when>
                                  <c:when test="${aggregate.profile == 'Sales Support' && aggregate.overview != 'Passed'}">
                                      <td>${aggregate.overview }</td>
                                  </c:when>
                                  <c:when test="${aggregate.profile == 'Sales' || aggregate.profile == 'Sourcing'}">
                                      <td>${aggregate.overview }</td>
                                  </c:when>
                                  </c:choose>	
                            
                            <td>${aggregate.actionPoints }</td>
                            <td>${aggregate.recruitmentSource }</td>
                           <%--  <td>${aggregate.salesNonSales }</td> --%>
                            <td>${aggregate.gender }</td>
                            <td>${aggregate.expAuto }</td>
                            <td>${aggregate.expNonAuto }</td>
                            <td>${aggregate.ageWise }</td>
                             <td>                        
                              ${aggregate.assessmentReport }                               
                            </td>
                        </tr>
                        <%p++; %>
                        </c:if>
                      </c:forEach>
                  </tbody>
            </table>
        </div>
    </div>


</div>

<div id="detailed-assessment-report" class="main-tabcontent">
    <!-- <h3>Detailed Assessment Report</h3> -->
    <div class="report-section"> 
        <div class="report-block">
           <h3>Detailed Report</h3>
           <a href="#" class="csv-icn-button" onclick="exportTocsv('detailedCSV')"><img src="./img/csv-file-icn.svg" />Export to CSV</a>
       </div> 
        <!-- <div class="report-block">
           <h3>Summary Report</h3>
           <a href="#" class="csv-icn-button" onclick="exportTocsv('summeryReport')"><img src="./img/csv-file-icn.svg" />Export to CSV</a>
       </div> -->
       <%
           if(userId.equalsIgnoreCase("HO") ||  userId.equalsIgnoreCase("SA")){
               %>
       <div class="report-block">
           <h3>Data science Report</h3>
           <a href="#" class="csv-icn-button" onclick="exportTocsv('dataScienceCSV')"><img src="./img/csv-file-icn.svg" />Export to CSV</a>
       </div>
       <%}%>
   </div>
</div>

<div id="question-wise-report" style="display:none" class="main-tabcontent">
    <!-- <h3>Question Analysis</h3> -->
    <!-- <div class="table-date">
        <div class="export-to-csv"><input type="button" class="ecsvbutton" value="Export To CSV"></div>
        <table id="data-qa" cellspacing="0" cellpadding="0" border="0" class="stripe display nowrap cell-border" width="50" style="width: 100% !important;height: auto !important;">
            <thead>
                <tr>
                    <th data-head="Sr.No." class="sorting" style="z-index: 1 !important;"><em>Sr.No.</em></th>
                    <th data-head="Candidate Name" class="sorting" style="z-index: 1 !important;"><em>Candidate Name</em></th>
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
        </table>
 -->
 
 
 		
</div>

<div id="competency-wise-analysis" class="main-tabcontent">
<embed src="<%=assessUrl%>pa/competencyWiseReport"
               width="100%" 
               height="900px"  scrolling="no" />
 <!-- <center>  <h3>No matching records found</h3>  </center>
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

<div id="ir-assessment-report" class="main-tabcontent">
    <!-- <h3>Assessment Report</h3> -->
	<div id="assessdiv"></div>
    
</div>



<!-- <h1>Reports</h1> -->
<!-- <div class="report-section"> -->
    <!-- <div class="report-block">
        <h3>Detailed Report</h3>
        <a href="#" class="csv-icn-button" onclick="exportTocsv('detailedCSV')"><img src="./img/csv-file-icn.svg" />Export to CSV</a>
    </div> -->
    <!--   <div class="report-block">
        <h3>Summery Report</h3>
        <a href="#" class="csv-icn-button" onclick="exportTocsv('summeryReport')"><img src="./img/csv-file-icn.svg" />Export to CSV</a>
    </div> -->
    <!-- <%
        if(userId.equalsIgnoreCase("HO")){
            %>
            <div class="report-block">
                <h3>Data science Report</h3>
                <a href="#" class="csv-icn-button" onclick="exportTocsv('dataScienceCSV')"><img src="./img/csv-file-icn.svg" />Export to CSV</a>
            </div>
            <%}%>
        </div>  -->
        
        <!-- <div class="report-section ir-report">
            <button class="collapsible">Reports</button>
            <div class="content">
                <div class="report-block-v2">
                    <div class="report-block-half">
                        <p>Detailed Report</p>
                        <a href="#" class="csv-icn-button" onclick="exportTocsv('detailedCSV')"><img src="./img/csv-file-icn.svg" />Export to CSV</a>
                    </div>
                </div>
            </div> 
                    
            <div class="content">
                <%
                if(userId.equalsIgnoreCase("HO")){
                    %>
                        <div class="report-block-v2">
                            <div class="report-block-half">
                                <p>Data science Report</p>
                                <a href="#" class="csv-icn-button" onclick="exportTocsv('dataScienceCSV')"><img src="./img/csv-file-icn.svg" />Export to CSV</a>
                            </div>
                        </div>
                        <%}%>
                    </div> 
                </div>
                
                <div class="report-section ir-report">
                    <button class="collapsible">Overview</button>
                    <div class="content">
                    <div class="report-block-v2">
                        <div class="report-block-half">
                            <p>Registered</p>
                            <a href="#" class="csv-icn-button" onclick="getAnalyticsByAccesskeyList('${overview.registered}','registered')"><img src="./img/csv-file-icn.svg" />Export to CSV</a>
                        </div>
                        <div class="report-block-half">
                            <p>Assessments</p>
                            <a href="#" class="csv-icn-button" onclick="getAnalyticsByAccesskeyList('${overview.assessments}','assessment')"><img src="./img/csv-file-icn.svg" />Export to CSV</a>
                        </div>
                    </div>    
                </div>  
                
                
                <div class="content">
                    <div class="report-block-v2">
                        <div class="report-block-half">
                            <p>Passed</p>
                            <a href="#" class="csv-icn-button" onclick="getAnalyticsByAccesskeyList('${overview.pass}','passed')"><img src="./img/csv-file-icn.svg" />Export to CSV</a>
                        </div>
                        <div class="report-block-half">
                            <p>Offered</p>
                            <a href="#" class="csv-icn-button" onclick="getAnalyticsByAccesskeyList('${overview.offer}','offred')"><img src="./img/csv-file-icn.svg" />Export to CSV</a>
                        </div>
                    </div>
                </div>
                
                <div class="content">
                    <div class="report-block-v2">
                        <div class="report-block-half">
                            <p>Recruited</p>
                            <a href="#" class="csv-icn-button"  onclick="getAnalyticsByAccesskeyList('${overview.recruited}','recruited')"><img src="./img/csv-file-icn.svg" />Export to CSV</a>
                        </div>
                    </div>    
                </div>
                </div>
                
                <div class="report-section ir-report">
                    <button class="collapsible">Action Points (Pending)</button>
                    <div class="content">
                        <div class="report-block-v2">
                            <div class="report-block-half">
                                <p>Assessments</p>
                                <a href="#" class="csv-icn-button" onclick="getAnalyticsByAccesskeyList('${action.assessmentStatus}','pendingAssessment')"><img src="./img/csv-file-icn.svg" />Export to CSV</a>
                            </div>
                            <div class="report-block-half">
                                <p>Interview</p>
                                <a href="#" class="csv-icn-button" onclick="getAnalyticsByAccesskeyList('${action.interviewStatus}','interviewStatus')"><img src="./img/csv-file-icn.svg" />Export to CSV</a>
                            </div>
                        </div>    
                 </div>  


                 <div class="content">
                     <div class="report-block-v2">
                         <div class="report-block-half">
                             <p>Documents</p>
                             <a href="#" class="csv-icn-button" onclick="getAnalyticsByAccesskeyList('${action.documentUploadStatus}','documentUploadStatus')"><img src="./img/csv-file-icn.svg" />Export to CSV</a>
                            </div>
                            <div class="report-block-half">
                                <p>Praarambh</p>
                                <a href="#" class="csv-icn-button" onclick="getAnalyticsByAccesskeyList('${action.prarambhStatus}','prarambhStatus')"><img src="./img/csv-file-icn.svg" />Export to CSV</a>
                            </div>
                        </div>
                    </div>
                    
                    <div class="content">
                        <div class="report-block-v2">
                            <div class="report-block-half">
                                <p>FSDM Approval</p>
                                <a href="#" class="csv-icn-button" onclick="getAnalyticsByAccesskeyList('${action.fsdmApproval}','fsdmApproval')"><img src="./img/csv-file-icn.svg" />Export to CSV</a>
                            </div>
                        </div>    
                    </div>
                </div>
                
                <div class="report-section ir-report">
                    <button class="collapsible">Recruitment Source</button>
                    <div class="content">
                        <div class="report-block-v2">
                            <div class="report-block-half">
                                <p>Referrals</p>
                                <a href="#" class="csv-icn-button" onclick="getAnalyticsByAccesskeyList('${source.referrals}','referrals')"><img src="./img/csv-file-icn.svg" />Export to CSV</a>
                            </div>
                            <div class="report-block-half">
                                <p>Direct Walk In</p>
                                <a href="#" class="csv-icn-button" onclick="getAnalyticsByAccesskeyList('${source.directWalkIn}','directWalkIn')"><img src="./img/csv-file-icn.svg" />Export to CSV</a>
                            </div>
                        </div>    
                    </div>  
                    <div class="content">
                        <div class="report-block-v2">
                            <div class="report-block-half">
                                <p>Advertisement</p>
                                <a href="#" class="csv-icn-button" onclick="getAnalyticsByAccesskeyList('${source.advertisement}','advertisement')"><img src="./img/csv-file-icn.svg" />Export to CSV</a>
                            </div>
                            <div class="report-block-half">
                                <p>Job Consultant</p>
                                <a href="#" class="csv-icn-button" onclick="getAnalyticsByAccesskeyList('${source.jobConsultant}','jobConsultant')"><img src="./img/csv-file-icn.svg" />Export to CSV</a>
                            </div>
                        </div>
                    </div>
                    <div class="content">
                        <div class="report-block-v2">
                        <div class="report-block-half">
                            <p>Social Media</p>
                            <a href="#" class="csv-icn-button" onclick="getAnalyticsByAccesskeyList('${source.socialMedia}','socialMedia')"><img src="./img/csv-file-icn.svg" />Export to CSV</a>
                        </div>
                        <div class="report-block-half">
                            <p>Other</p>
                            <a href="#" class="csv-icn-button" onclick="getAnalyticsByAccesskeyList('${source.others}','others')"><img src="./img/csv-file-icn.svg" />Export to CSV</a>
                        </div>
                    </div>    
                </div>
            </div>
            
            <div class="report-section ir-report">
                <button class="collapsible">Sales-Non-Sales</button>
                <div class="content">
                    <div class="report-block-v2">
                        <div class="report-block-half">
                            <p>Sales</p>
                            <a href="#" class="csv-icn-button" onclick="getAnalyticsByAccesskeyList('${designation.sales}','sales')"><img src="./img/csv-file-icn.svg" />Export to CSV</a>
                        </div>
                        <div class="report-block-half">
                            <p>Non-Sales</p>
                            <a href="#" class="csv-icn-button" onclick="getAnalyticsByAccesskeyList('${designation.nonSales}','nonSales')"><img src="./img/csv-file-icn.svg" />Export to CSV</a>
                        </div>
                    </div>
                </div>  
            </div>
            
            <div class="report-section ir-report">
                <button class="collapsible">Gender Diversity</button>
                <div class="content">
                    <div class="report-block-v2">
                        <div class="report-block-half">
                            <p>Male</p>
                            <a href="#" class="csv-icn-button" onclick="getAnalyticsByAccesskeyList('${gender.male}','pendingAssessment')"><img src="./img/csv-file-icn.svg" />Export to CSV</a>
                        </div>
                        <div class="report-block-half">
                            <p>Female</p>
                            <a href="#" class="csv-icn-button" onclick="getAnalyticsByAccesskeyList('${gender.female}','pendingAssessment')"><img src="./img/csv-file-icn.svg" />Export to CSV</a>
                        </div>
                    </div>
                </div>  
            </div>
            
            <div class="report-section ir-report">
                <button class="collapsible">Candidate Experience</button>
                <div class="content">
                    <div class="report-block-v2">
                        <div class="report-block-half">
                            <p>Total Experience (Non Auto)</p>
                            <a href="#" class="csv-icn-button" onclick="getAnalyticsByAccesskeyList('${expAutoSet}','expAutoSet')"><img src="./img/csv-file-icn.svg" />Export to CSV</a>
                        </div>
                        <div class="report-block-half">
                        <p>Total Experience (Non Industry)</p>
                        <a href="#" class="csv-icn-button" onclick="getAnalyticsByAccesskeyList('${expNonAutoSet}','expNonAutoSet')"><img src="./img/csv-file-icn.svg" />Export to CSV</a>
                    </div>
                </div>
            </div>  
        </div>
        
        <div class="report-section ir-report">
            <button class="collapsible">Age Wise</button>
            <div class="content">
                <div class="report-block-v2">
                    <div class="report-block-half">
                        <p>Less than 20 Years</p>
                        <a href="#" class="csv-icn-button" onclick="exportTocsv('detailedCSV')"><img src="./img/csv-file-icn.svg" />Export to CSV</a>
                    </div>
                    <div class="report-block-half">
                        <p>Between 20 To 25 Years</p>
                        <a href="#" class="csv-icn-button" onclick="exportTocsv('detailedCSV')"><img src="./img/csv-file-icn.svg" />Export to CSV</a>
                    </div>
                </div>
            </div>  
            <div class="content">
                <div class="report-block-v2">
                    <div class="report-block-half">
                        <p>Between 30 To 35 Years</p>
                        <a href="#" class="csv-icn-button" onclick="exportTocsv('detailedCSV')"><img src="./img/csv-file-icn.svg" />Export to CSV</a>
                    </div>
                    <div class="report-block-half">
                        <p>Between 35 To 40 Years</p>
                        <a href="#" class="csv-icn-button" onclick="exportTocsv('detailedCSV')"><img src="./img/csv-file-icn.svg" />Export to CSV</a>
                    </div>
                </div>
            </div>  
        </div>
        
        <div class="report-section ir-report">
            <button class="collapsible">Assessment Report</button>
            <div class="content">
                <div class="report-block-v2">
                    <div class="report-block-half">
                        <p>Less than 40%</p>
                        <a href="#" class="csv-icn-button" onclick="exportTocsv('detailedCSV')"><img src="./img/csv-file-icn.svg" />Export to CSV</a>
                    </div>
                    <div class="report-block-half">
                        <p>Between 40% To 60% </p>
                        <a href="#" class="csv-icn-button" onclick="exportTocsv('detailedCSV')"><img src="./img/csv-file-icn.svg" />Export to CSV</a>
                    </div>
                </div>
            </div>  
            <div class="content">
                <div class="report-block-v2">
                    <div class="report-block-half">
                        <p>Between 60% To 80%</p>
                        <a href="#" class="csv-icn-button" onclick="exportTocsv('detailedCSV')"><img src="./img/csv-file-icn.svg" />Export to CSV</a>
                    </div>
                    <div class="report-block-half">
                        <p>More than 80%</p>
                        <a href="#" class="csv-icn-button" onclick="exportTocsv('detailedCSV')"><img src="./img/csv-file-icn.svg" />Export to CSV</a>
                    </div>
                </div>
            </div>  
        </div> -->
        
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
        <input type='hidden' id='report_name' value=''>

        <script>
            function openPageMain(pageName,elmnt,color) {
                console.log(document.getElementById(pageName));
                console.log(document.getElementsByClassName("main-tabcontent"));
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
                document.getElementById(pageName).style.display = "block";
                elmnt.style.backgroundColor = color;
                elmnt.style.color = '#fff';
                $('#regionCode').show();
                $('#stateCode').show();
                $('#cityCode').show();
                $('#dealershipCode').show();
                $('#outletCode').show();
                $('#outletCode').show();
                $('#dealershipName').show();
                $('#btn_submit').show();
               $('#export_exl').hide();

	        document.getElementById("formFilter").addEventListener("submit",function(e)
        		     {e.stopPropagationt();});
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
            document.getElementById("aggregateF").click();
        </script>
            
            
            
            
            <script>
                $(document).ready(function(){
                    /*Default Open Window From Dashboard Click*/
                    var flag2 = `${flag}`;
			        if(flag2.length>2){
        	        document.getElementById("OverF").click();
        	        document.getElementById(flag2).click();
			        }

                    $('#QBA').click(function(){
                        window.location.href='./qb-analysis';
                    })

                    /* Date filter */
                    var start = moment().startOf('month');
                    var end = moment().endOf('month');
                    
                    function cb(start, end) {
                        $('#reportrange').html(start.format('D MMMM, YYYY') + ' - ' + end.format('D MMMM, YYYY'));
                    }
            
            $('#reportrange').daterangepicker({
                opens: 'left',
                format: 'DD/MM/YYYY',
                startDate: start,
                endDate: end,
                locale: {
                    format: 'DD/MM/YYYY',
                }
            }, cb);
            cb(start, end);
            /* Date filter */
        });
        function exportTocsv(reportName){

                    $("#report_name").val(reportName);
        	$('#regionCode').hide();
            $('#stateCode').hide();
            $('#cityCode').hide();
            $('#dealershipCode').hide();
            $('#outletCode').hide();
            $('#outletCode').hide();
              $('#dealershipName').hide();
            // var dateFromm =$('#dateFromm').val();
		   // var dateToo =$('#dateToo').val();
            //url="./"+reportName+"?dateFromm="+dateFromm+"&dateToo="+dateToo;
        	//window.location.href=url;     	
        	$('.page-filters-filter').toggleClass('active');
            $('.page-filters-filter-block, .blk-bg').toggle();
            $('#btn_submit').hide();
            $('#export_exl').show();
                    //var dateFromm =$('#dateFromm').val();
		   // var dateToo =$('#dateToo').val();
                   // url="./"+reportName+"?dateFromm="+dateFromm+"&dateToo="+dateToo;
        	   // window.location.href=url;     	
        }
         
          function exportTocsvPro(){
        	  var reportName = $("#report_name").val();
          	document.getElementById("formFilter").addEventListener("submit",function(e)
          		     {e.preventDefault();});
          	
               var dateFromm =$('#dateFromm').val();
  		     var dateToo =$('#dateToo').val();

         		        var form = document.createElement("form");   
         	                form.method="post";
         		        form.action="./"+reportName+"?dateFromm="+dateFromm+"&dateToo="+dateToo
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

        // console.log("Vrushali");
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
        #data-ov_paginate a, #data-ap_paginate a, #data-rs_paginate a, #data-sns_paginate a, #data-gd_paginate a, #data-ce_paginate a, #data-aw_paginate a, #data-ar_paginate a, #data-qa_paginate a, #data-ca_paginate a, #data-agr_paginate a{margin-left: 20px !important;text-decoration: none !important;display: inline-block !important;padding: 7px 20px !important;font-size: 13px;line-height: 20px;color: #fff !important;border-radius: 20px !important;border: none !important;background-color: #2a3740 !important;cursor: pointer !important;}
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
            function downloadExcelOV(){
                    $('#data-ov').table2csv({
                        file_name: 'data.csv',
                        header_body_space: 0
                    });
                
            }
        </script>
       	<script type="text/javascript" src="./js/table2csv.js"></script>
        <script src="https://cdn.datatables.net/fixedcolumns/4.2.1/js/dataTables.fixedColumns.min.js"></script>

</html>
<%     }else{
    response.sendRedirect("login");
}
}catch(Exception e)
{
    	  response.sendRedirect("login");
    }
    %>