<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import = "java.util.ResourceBundle" %>

<%
try
    {
      ResourceBundle resource = ResourceBundle.getBundle("application");
String baseServer = resource.getString("client.url");
	%>
<!DOCTYPE html>
<html lang="en"><head>
<meta http-equiv="content-type" content="text/html; charset=windows-1252">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	  <link rel="icon" type="image/x-icon" href="<%=baseServer%>img/iRecruit-favicon.ico"/>
    <title>iRecruit</title>
    <link rel="stylesheet" type="text/css" href="./css/common.css">
    <link rel="stylesheet" type="text/css" href="./css/dashboard.css">
    <link rel="stylesheet" type="text/css" href="./css/dashboard-filter.css">
    <link rel="stylesheet" type="text/css" href="./css/daterangepicker.css" />
    <script src="js/jquery-3.4.1.min.js"></script>
    <script type="text/javascript" src="./js/sweetalert.min.js"></script>
    <script src="./js/moment.min.js"></script>
    <script src="./js/daterangepicker.js"></script>
    <style>
        .ir-dsh-cnt-img-wrap{margin-left:-8px;margin-right:-8px;}
        .ir-dsh-cnt-img-wrap img{display:block;}
        .apexcharts-toolbar{display:none !important;}
        #sales-nosales-v2 .apexcharts-legend-text{font-size:13px !important;}
        #sales-nosales-v2 .apexcharts-legend.apx-legend-position-left{left: 18px !important;top: 0px !important;}
        #overview-v2 .apexcharts-legend.apexcharts-align-center.apx-legend-position-left {top: 45% !important;left: unset !important;right: 0px !important;transform: translate(85%, -50%);overflow: visible;}
        #overview-v2 foreignObject {overflow: visible;}
        #overview-v2 svg {overflow: visible;}
        .dashboard-block h3{margin:0 0 15px !important;}
        .dashboard-block{padding:20px !important;}
        #SvgjsG2119 {display: none !important;}
        .apexcharts-tooltip{z-index:500 !important;}
        .apexcharts-canvas{overflow:visible !important}
        .ir-sm a{cursor: pointer;text-decoration: none !important;float: right;}
        input.ir-export-csv {background: #2D3393 !important;color: #fff !important;font-size: 13px !important;text-align: center !important;}
        .page-filters {margin-top: 20px !important}
    
         
        @media (max-width: 320px){
  .page-filters-filter-block .form-section .form-block, .page-filters-process-block .form-section .form-block {width: calc(100% - 20px) !important;}
  .page-filters-filter-block {width: 330px !important;}
  .pyramid_legend_pointers {display: flex !important;flex-direction: row !important;justify-content: start !important;width: 100%;flex-wrap: wrap !important;}
.pyramid_wrap {
    width: 100% !important;}

        }
        @media (max-width: 376px){
  .page-filters-filter-block .form-section .form-block, .page-filters-process-block .form-section .form-block {width: calc(100% - 20px) !important;}
  .page-filters-filter-block {width: 350px !important;}}
  @media  (max-width:400px){
    .page-filters-filter-block {width: 350px !important;}
  }
        @media  (max-width: 767px)  {
          .page-filters-filter-block .form-section .form-block{width: calc(100% - 20px) !important;}
          .page-filters {margin-top: 60px !important;}
          .page-filters-filter-block {width: 390px !important;}
        }
        @media  (max-width: 768px){
          .page-filters { margin-top: 70px !important;}
          .page-filters-filter-block .form-section .form-block{width: calc(100% - 20px) !important;}
          .page-filters-filter-block {width: 400px !important;}
        }
        @media  (max-width: 820px){
          .pyramid_wrap {width: 100% !important;}
          .pyramid_legend_pointers{display: block !important;flex-direction: row !important;width:81% !important;}
          .ir-sm{bottom: 4px !important;}
        }
        @media  (max-width: 1024px){
          .pyramid_wrap {width: 100% !important;}
          .pyramid_legend_pointers{display: block !important;flex-direction: row !important;width:81% !important;}
          .ir-sm{bottom: 4px !important;}
        }

        </style>
     <script type="text/javascript">
          //  var xhr = new XMLHttpRequest();
	  //  xhr.open('GET', 'upadteAnalytics', true);
	  //  xhr.send();
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
         <div class="page-filter-include">
		  <%@include file="./filter/dashboardFilter.jsp"%>
		</div>

		  <!-- <input type="button" class="export-to-csv" style="border-radius: 15px; background-color: darkblue; color: white; padding: 15px;" value="CSV Report" onclick="exportToCSV()"> -->
		<!-- <div>
    <input type="button" class="" style="display: inline-block;
      padding: 9px 17px 9px 15px;
      font-size: 13px;
      line-height: 18px;
      border: 1px solid #2D3393;
      color: #2D3393;
      border-radius: 30px;
      cursor: pointer;
      position: relative;
      background-color: #fff;" value="CSV Report" onclick="exportToCSV()">
		</div>  -->
        <div <%-- id="data-time" --%>><p><b>* Data Period : </b>${defaultDate}</p></div>
        <div class="dashboard-section">
            <div class="dashboard-block" style="display: none;">
                <h3>Recruitment Funnel</h3>
                <div class="overview-section">
                    <div class="overview-data">
                        <div class="overview-data-block" onclick="getAnalyticsByAccesskeyList('${overview.registered}','registered')">
                            <p>${fn:length(overview.registered)}</p>
                            <h4>Registered</h4>
                            <div class="ir-dsh-cnt-img-wrap">
                                <img src="./img/dashboard/graph-bg.png" alt="">
                            </div>
                        </div>
                        <div class="overview-data-block" onclick="getAnalyticsByAccesskeyList('${overview.assessments}','assessment')">
                            <p>${fn:length(overview.assessments)}</p>
                           <h4>Assessments</h4>
                            <div class="ir-dsh-cnt-img-wrap">
                                <img src="./img/dashboard/graph-bg.png" alt="">
                            </div>
                        </div>
                        <div class="overview-data-block" onclick="getAnalyticsByAccesskeyList('${overview.pass}','passed')">
                            <p>${fn:length(overview.pass)}</p>
                            <h4>Passed</h4>
                            <div class="ir-dsh-cnt-img-wrap">
                                <img src="./img/dashboard/graph-bg.png" alt="">
                            </div>
                        </div>
                        <div class="overview-data-block" onclick="getAnalyticsByAccesskeyList('${overview.offer}','offred')">
                            <p>${fn:length(overview.offer)}</p>
                            <h4>Offered</h4>
                            <div class="ir-dsh-cnt-img-wrap">
                                <img src="./img/dashboard/graph-bg.png" alt="">
                            </div>
                        </div>
                        <div class="overview-data-block" onclick="getAnalyticsByAccesskeyList('${overview.recruited}','recruited')">
                            <p>${fn:length(overview.recruited)}</p>
                            <h4>Recruited</h4>
                            <div class="ir-dsh-cnt-img-wrap">
                                <img src="./img/dashboard/graph-bg.png" alt="">
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <!-- <div class="dashboard-section"> -->
           
        <!-- </div>
        <div class="dashboard-section"> -->
            <!-- <div class="dashboard-block ir-w-40">
                <h3>Overview</h3>
                <div class="overview-section ">
                    <div class="overview-layout " style="justify-content: start !important;">
                  <div class="dashboard-layout-full" id="overview-v2" style="margin:0px !important"></div>
                    -->


                        <!-- <div class="pyramid_wrap">
                            <div class="category_one">
                                <h6 class="value">${fn:length(overview.registered)}</h6>
                            </div>
                            <div class="category_two">
                              <h6 class="value">${fn:length(overview.assessments)}</h6>
                            </div>
                            <div class="category_three">
                              <h6 class="value">${fn:length(overview.pass)}</h6>
                            </div>
                            <div class="category_four">
                              <h6 class="value">${fn:length(overview.offer)}</h6>
                            </div>
                            <div class="category_five" >
                              <h6 class="value">${fn:length(overview.recruited)}</h6>
                            </div>
                        </div> -->
                        <!-- <div class="pyramid_legend_pointers">
                            <span>Registered</span>
                            <span>Assessments</span>
                            <span>Passed</span>
                            <span>Offered</span>
                            <span>Recruited</span>
                        </div> -->
                    <!-- </div> -->
                    <!-- <div class="overview-data">
                        <div class="overview-data-block" onclick="getAnalyticsByAccesskeyList('${overview.registered}','registered')">
                            <h4><img src="./img/dashboard/d-icn01.svg" />Registered</h4>
                            <p>${fn:length(overview.registered)}</p>
                        </div>
                        <div class="overview-data-block" onclick="getAnalyticsByAccesskeyList('${overview.assessments}','assessment')">
                           <h4><img src="./img/dashboard/book.png" style="width: 20px; height: 20px;" />Assessments</h4>
                            <p>${fn:length(overview.assessments)}</p>
                        </div>
                        <div class="overview-data-block" onclick="getAnalyticsByAccesskeyList('${overview.pass}','passed')">
                            <h4><img src="./img/dashboard/d-icn03.svg" />Passed</h4>
                            <p>${fn:length(overview.pass)}</p>
                        </div>
                        <div class="overview-data-block" onclick="getAnalyticsByAccesskeyList('${overview.offer}','offred')">
                           <h4><img src="./img/dashboard/writing.png" style="width: 20px; height: 17px;"  />Offered</h4>
                            <p>${fn:length(overview.offer)}</p>
                        </div>
                        <div class="overview-data-block" onclick="getAnalyticsByAccesskeyList('${overview.recruited}','recruited')">
                            <h4><img src="./img/dashboard/d-icn05.svg" />Recruited</h4>
                            <p>${fn:length(overview.recruited)}</p>
                        </div>
                    </div> -->
                <!-- </div> -->
                <!-- <div class="dashboard-section">
                    <div class="overview-layout">
                        <div class="dashboard-block ir-w-40">
                            <div class="category_one" onclick="getAnalyticsByAccesskeyList('${overview.registered}','registered')">
                                <h6 class="value">${fn:length(overview.registered)}</h6>
                            </div>
                            <div class="category_two" onclick="getAnalyticsByAccesskeyList('${overview.assessments}','assessment')">
                              <h6 class="value">${fn:length(overview.assessments)}</h6>
                            </div>
                            <div class="category_three"  onclick="getAnalyticsByAccesskeyList('${overview.pass}','passed')">
                              <h6 class="value">${fn:length(overview.pass)}</h6>
                            </div>
                            <div class="category_four"  onclick="getAnalyticsByAccesskeyList('${overview.offer}','offred')">
                              <h6 class="value">${fn:length(overview.offer)}</h6>
                            </div>
                            <div class="category_five"  onclick="getAnalyticsByAccesskeyList('${overview.recruited}','recruited')">
                              <h6 class="value">${fn:length(overview.recruited)}</h6>
                            </div>
                        </div>
                        <div class="pyramid_legend_pointers">
                            <span>Registered</span>
                            <span>Assessments</span>
                            <span>Passed</span>
                            <span>Offered</span>
                            <span>Recruited</span>
                        </div>
                    </div>  -->
                    <!-- <div class="overview-data">
                        <div class="overview-data-block" onclick="getAnalyticsByAccesskeyList('${overview.registered}','registered')">
                            <h4><img src="./img/dashboard/d-icn01.svg" />Registered</h4>
                            <p>${fn:length(overview.registered)}</p>
                        </div>
                        <div class="overview-data-block" onclick="getAnalyticsByAccesskeyList('${overview.assessments}','assessment')">
                           <h4><img src="./img/dashboard/book.png" style="width: 20px; height: 20px;" />Assessments</h4>
                            <p>${fn:length(overview.assessments)}</p>
                        </div>
                        <div class="overview-data-block" onclick="getAnalyticsByAccesskeyList('${overview.pass}','passed')">
                            <h4><img src="./img/dashboard/d-icn03.svg" />Passed</h4>
                            <p>${fn:length(overview.pass)}</p>
                        </div>
                        <div class="overview-data-block" onclick="getAnalyticsByAccesskeyList('${overview.offer}','offred')">
                           <h4><img src="./img/dashboard/writing.png" style="width: 20px; height: 17px;"  />Offered</h4>
                            <p>${fn:length(overview.offer)}</p>
                        </div>
                        <div class="overview-data-block" onclick="getAnalyticsByAccesskeyList('${overview.recruited}','recruited')">
                            <h4><img src="./img/dashboard/d-icn05.svg" />Recruited</h4>
                            <p>${fn:length(overview.recruited)}</p>
                        </div>
                    </div>
                </div> --> 
            <!-- </div> -->
        <div class="dashboard-section">

            <div class="dashboard-block ir-col-3 ">
              <h3>Recruitment Funnel</h3>
              <div class="ir-pyaramid">
                <div class="pyramid_wrap">
                  <div class="category_one">
                      <h6 class="value">${fn:length(overview.registered)}</h6>
                  </div>
                  <div class="category_two">
                    <h6 class="value">${fn:length(overview.assessments)}</h6>
                  </div>
                  <div class="category_three">
                    <h6 class="value">${fn:length(overview.pass)}</h6>
                  </div>
                  <div class="category_four">
                    <h6 class="value">${fn:length(overview.offer)}</h6>
                  </div>
                  <div class="category_five" >
                    <h6 class="value">${fn:length(overview.recruited)}</h6>
                  </div>
                 
                </div>
                <div class="pyramid_legend_pointers">
                  <span>Registered</span>
                  <span>Assessments</span>
                  <span>Passed</span>
                  <span>Offered</span>
                  <span>Recruited</span>
                </div>     
              </div>
              <div class="ir-sm">
                <a href="showAllLinksCSV?flag=overviewF">Show More</a>
              </div>
            </div>
            
            <div class="dashboard-block ir-col-3 ">
              <h3>Action Points (Pending)</h3>
              <div class="dashboard-layout-full" id="action-points-v2"></div>
              <div class="ir-sm">
                <a href="showAllLinksCSV?flag=actionF">Show More</a>
              </div>
            </div>
              


              <!-- <div class="overview-section action-points">
                  <div class="overview-data">
                      <div class="overview-data-block" onclick="getAnalyticsByAccesskeyList('${action.assessmentStatus}','pendingAssessment')">
                          <div class="overview-data-content">
                              <p>${fn:length(action.assessmentStatus)}</p>
                              <h4>Assessments</h4>
                          </div>
                          <div class="overview-data-img">
                              <img src="./img/dashboard/book.png">
                          </div>
                      </div>
                      <div class="overview-data-block" onclick="getAnalyticsByAccesskeyList('${action.interviewStatus}','pendingInterview')">
                           <div class="overview-data-content">
                              <p>${fn:length(action.interviewStatus)}</p>
                              <h4>Interview</h4>
                           </div>
                            <div class="overview-data-img">
                              <img src="./img/dashboard/interview.png">
                          </div>
                      </div>
                      <div class="overview-data-block" onclick="getAnalyticsByAccesskeyList('${action.documentUploadStatus}','pendingDoc')">
                           <div class="overview-data-content">
                              <p>${fn:length(action.documentUploadStatus)}</p>
                              <h4>Documents</h4>
                           </div>
                            <div class="overview-data-img">
                              <img src="./img/dashboard/documents.png">
                          </div>
                      </div>
                      <div class="overview-data-block" onclick="getAnalyticsByAccesskeyList('${action.prarambhStatus}','pendingPraraambh')">
                           <div class="overview-data-content">
                              <p>${fn:length(action.prarambhStatus)}</p>              
                              <h4>Induction Course</h4>
                           </div>
                            <div class="overview-data-img">
                              <img src="./img/dashboard/course.png">
                          </div>
                      </div>
                      <div class="overview-data-block" onclick="getAnalyticsByAccesskeyList('${action.fsdmApproval}','pendingApproval')">
                           <div class="overview-data-content">
                              <p>${fn:length(action.fsdmApproval)}</p>
                              <h4>FSDM Approval</h4>
                           </div>
                            <div class="overview-data-img">
                              <img src="./img/dashboard/immigration.png">
                          </div>
                      </div>
                  </div>
              </div> -->
          <!-- </div> -->
        </div>
        <div class="dashboard-section" style="display: none;">
            <div class="dashboard-block">
                <h3>Action Points (Pending)</h3>
                <div class="overview-section action-points">
                    <div class="overview-data">
                        <div class="overview-data-block" onclick="getAnalyticsByAccesskeyList('${action.assessmentStatus}','pendingAssessment')">
                            <h4><img src="./img/dashboard/book.png" style="width: 20px; height: 20px;"/>Assessments</h4>
                            <p>${fn:length(action.assessmentStatus)}</p>
                        </div>
                        <div class="overview-data-block" onclick="getAnalyticsByAccesskeyList('${action.interviewStatus}','pendingInterview')">
                            <h4><img src="./img/dashboard/interview.png"   style="width: 20px; height: 20px;" />Interview</h4>
                            <p>${fn:length(action.interviewStatus)}</p>
                        </div>
                        <div class="overview-data-block" onclick="getAnalyticsByAccesskeyList('${action.documentUploadStatus}','pendingDoc')">
                            <h4><img src="./img/dashboard/d-icn08.svg" />Documents</h4>
                            <p>${fn:length(action.documentUploadStatus)}</p>
                        </div>
                        <div class="overview-data-block" onclick="getAnalyticsByAccesskeyList('${action.prarambhStatus}','pendingPraraambh')">
                            <h4><img src="./img/dashboard/course.png"  style="width: 20px; height: 20px;"  />Induction Course</h4>
                            <p>${fn:length(action.prarambhStatus)}</p>
                        </div>
                        <div class="overview-data-block" onclick="getAnalyticsByAccesskeyList('${action.fsdmApproval}','pendingApproval')">
                            <h4><img src="./img/dashboard/d-icn09.svg" />FSDM Approval</h4>
                            <p>${fn:length(action.fsdmApproval)}</p>
                        </div>
                    </div>
                </div>
            </div>
        </div> 

     

        <div class="dashboard-section">
            <div class="dashboard-block ir-col-3" >
                <h3>Recruitment Source</h3>
                <div class="dashboard-layout-full" id="recruitment-source-v2"></div>
                 <div class="ir-sm">
                <a href="showAllLinksCSV?flag=recruitmentF">Show More</a>
              </div>
            </div>

            <div class="dashboard-block ir-col-3">
                <h3>Sales / Non Sales</h3>
                <div class="dashboard-layout-full" id="sales-nosales-v2"></div>
                 <div class="ir-sm">
                <a href="showAllLinksCSV?flag=salesF" >Show More</a>
              </div>
            </div>
        </div>

        <div class="dashboard-section">
            <div class="dashboard-block ir-col-3">
                <h3>GENDER DIVERSITY</h3>
                <div class="dashboard-layout-full" id="gender-diversity-v2"></div>
                 <div class="ir-sm">
                <a href="showAllLinksCSV?flag=genderF">Show More</a>
              </div>
            </div>
       
          <div class="dashboard-block ir-col-3">
              <h3>Candidate Experience</h3>
              <div class="dashboard-layout-full" id="candidate-experience-v2"></div>
               <div class="ir-sm">
                <a href="showAllLinksCSV?flag=expF">Show More</a>
              </div>
          </div>   
        </div>

      <div class="dashboard-section"> 
          <div class="dashboard-block half ir-col-3">
            <h3>Age Wise</h3>
            <div class="dashboard-layout-full" id="age-wise-v2"></div>
            <div class="ir-sm">
              <a href="showAllLinksCSV?flag=ageF">Show More</a>
            </div>
          </div>
        
        <div class="dashboard-block half ir-col-3">
            <h3>Assessment Report</h3>
            <div class="dashboard-layout-full" id="assessment-report-v2"></div>
            <div class="ir-sm">
              <a href="showAllLinksCSV?flag=assessmentF">Show More</a>
            </div>
        </div>
     </div>
     <!-- <div class="dashboard-block">
      <h3>My Performance</h3>
      <div class="dashboard-layout-full" id="chart"></div> -->
      <!-- <div class="ir-sm">
        <a href="showAllLinksCSV?flag=assessmentF">Show More</a>
      </div> -->
  </div>

        <!-- <div class="dashboard-section">
            <div class="dashboard-block half">
                <h3>Age Wise</h3>
                <div class="dashboard-layout-full" id="age-wise-v2"></div>
            </div>
            
         <div class="dashboard-block half">
                <h3>Assessment Report</h3>
                <div class="dashboard-layout-full" id="assessment-report-v2"></div>
            </div>

            
        </div>  -->


       <div class="dashboard-section" style="display: none;">
            <div class="dashboard-block half">
                <h3>Recruitment Source</h3>
                <div class="dashboard-layout-full" id="recruitment-source" style="height: 350px; width: 971px; left: 50%; transform: translate(-50%, 0);"></div>
            </div>
            <div class="dashboard-block half">
                <h3>Candidate Experience</h3>
                <div class="dashboard-layout-full" id="candidate-experience" style="height: 350px; width: 471px;"></div>
            </div>
        </div>
        <div class="dashboard-section" style="display: none;">
            <div class="dashboard-block half">
                <h3>Assessment Report</h3>
                <div class="dashboard-layout-full" id="assessment-report" style="height: 350px; width: 471px;"></div>
            </div>
            <div class="dashboard-block half">
                <h3>Sales / Non Sales</h3>
                <div class="dashboard-layout-full" id="sales-nosales" style="height: 350px; width: 471px;"></div>
            </div>
        </div>

        <div class="dashboard-section" style="display: none;">
            <div class="dashboard-block half">
                <h3>Gender Diversity</h3>
                <div class="dashboard-layout-full" id="gender-diversity" style="height: 350px; width: 471px;"></div>
            </div>
            <div class="dashboard-block half">
                <h3>Age Wise</h3>
                <div class="dashboard-layout-full" id="age-wise" style="height: 350px; width: 471px;"></div>
            </div>
        </div>
    </div>

    <div class="blk-bg"></div>
    
    
     <script type="text/javascript" src="./js/jquery.canvasjs.min.js"></script>
     <script type="text/javascript" src="./js/apexcharts.js"></script>
    <script>
      $(document).ready(function () {
		  

		  
		  
        // Recruitment Source
        var recruitmentSource = {
            exportEnabled: true,
            animationEnabled: true,
            title:{
                text: "",
            },
            legend:{
                horizontalAlign: "center",
                verticalAlign: "bottom",
                fontFamily: 'Arial',
                fontWeight: "normal",
                fontSize: 10,
                // maxWidth: 370
            },
            data: [{
                type: "pie",
                showInLegend: true,
                toolTipContent: "<b>{name}</b>: {y} (#percent%)",
                indexLabel: "#percent%",
                legendText: "{name}",
                indexLabelPlacement: "inside",
                indexLabelFontColor: "#ffffff",
                dataPoints: [
				
                    { y: ${fn:length(source.referrals)}, name: "Referrals", color: "#1747A5" },
                    { y: ${fn:length(source.directWalkIn)}, name: "Direct Walk In", color: "#2D368D" },
                    { y: ${fn:length(source.advertisement)}, name: "Advertisement", color: "#1747A5" },
                    { y: ${fn:length(source.jobConsultant)}, name: "Job Consultant", color: "#81B2CC" },
                    { y: ${fn:length(source.socialMedia)}, name: "Social Media", color: "#356098" },
                    { y: ${fn:length(source.others)}, name: "Others", color: "#98CEED" }
                ]
            }]
        };
        $("#recruitment-source").CanvasJSChart(recruitmentSource);
		
		// Candidate Experience
		var chartCandidate = {
			animationEnabled: true,
			theme: "light2",
			title:{
				text: ""
			},	
			axisY: {
				//title: "Total Experience (Non Auto)",
				titleFontColor: "#4DB87D",
				lineColor: "#fff",
				labelFontColor: "#fff",
				tickColor: "#fff",
			  gridThickness:0
			},
			axisY2: {
				//title: "Total Experience (Auto Industry)",
				titleFontColor: "#8186BB",
				lineColor: "#fff",
				labelFontColor: "#fff",
				tickColor: "#fff",
			  	gridThickness:0
			},	
			toolTip: {
				shared: true
			},
			legend: {
				cursor:"pointer",
				itemclick: toggleDataSeries,
				fontFamily: 'Arial',
				fontWeight: "normal",
				fontSize: 10
			},
			data: [{
				type: "column",
				name: "Total Experience (Non Auto)",
				legendText: "Total Experience (Non Auto)",
				  color: "#4DB87D",
				showInLegend: true, 
				dataPoints:[
					{ label: "<3 Months", y: ${fn:length(expNonAuto.lessThan3Months)}, color: "#4DB87D", indexLabel: "${fn:length(expNonAuto.lessThan3Months)}", indexLabelFontColor: "#4DB87D" },
					{ label: "3 month to 6 Months", y: ${fn:length(expNonAuto.months3To6)}, color: "#4DB87D", indexLabel: "${fn:length(expNonAuto.months3To6)}", indexLabelFontColor: "#4DB87D" },
					{ label: "6 months - 1 year", y: ${fn:length(expNonAuto.months6To1Year)}, color: "#4DB87D", indexLabel: "${fn:length(expNonAuto.months6To1Year)}", indexLabelFontColor: "#4DB87D" },
					{ label: "1 - 2 Years", y: ${fn:length(expNonAuto.year1To2Year)}, color: "#4DB87D", indexLabel: "${fn:length(expNonAuto.year1To2Year)}", indexLabelFontColor: "#4DB87D" },
					{ label: "2 - 5 Years", y: ${fn:length(expNonAuto.year2To5Year)}, color: "#4DB87D", indexLabel: "${fn:length(expNonAuto.year2To5Year)}", indexLabelFontColor: "#4DB87D" },
					{ label: "5 - 10 Years", y: ${fn:length(expNonAuto.year5To10Year)}, color: "#4DB87D", indexLabel: "${fn:length(expNonAuto.year5To10Year)}", indexLabelFontColor: "#4DB87D" },
					{ label: ">=10 Years", y: ${fn:length(expNonAuto.moreThan10Year)}, color: "#4DB87D", indexLabel: "${fn:length(expNonAuto.moreThan10Year)}", indexLabelFontColor: "#4DB87D" }
				]
			},
			{
				type: "column",	
				name: "Total Experience (Auto Industry)",
				legendText: "Total Experience (Auto Industry)",
				  color: "#8186BB",
				axisYType: "secondary",
				showInLegend: true,
				dataPoints:[
					{ label: "<3 Months", y: ${fn:length(experience.lessThan3Months)}, color: "#8186BB", indexLabel: "${fn:length(experience.lessThan3Months)}", indexLabelFontColor: "#8186BB" },
					{ label: "3 month to 6 Months", y: ${fn:length(experience.months3To6)}, color: "#8186BB", indexLabel: "${fn:length(experience.months3To6)}", indexLabelFontColor: "#8186BB" },
					{ label: "6 months - 1 year", y: ${fn:length(experience.months6To1Year)}, color: "#8186BB", indexLabel: "${fn:length(experience.months6To1Year)}", indexLabelFontColor: "#8186BB" },
					{ label: "1 - 2 Years", y: ${fn:length(experience.year1To2Year)}, color: "#8186BB", indexLabel: "${fn:length(experience.year1To2Year)}", indexLabelFontColor: "#8186BB" },
					{ label: "2 - 5 Years", y: ${fn:length(experience.year2To5Year)}, color: "#8186BB", indexLabel: "${fn:length(experience.year2To5Year)}", indexLabelFontColor: "#8186BB" },
					{ label: "5 - 10 Years", y: ${fn:length(experience.year5To10Year)}, color: "#8186BB", indexLabel: "${fn:length(experience.year5To10Year)}", indexLabelFontColor: "#8186BB" },
					{ label: ">=10 Years", y: ${fn:length(experience.moreThan10Year)}, color: "#8186BB", indexLabel: "${fn:length(experience.moreThan10Year)}", indexLabelFontColor: "#8186BB" }
				]
			}]
		};
		
		$("#candidate-experience").CanvasJSChart(chartCandidate);
		function toggleDataSeries(e) {
			if (typeof(e.dataSeries.visible) === "undefined" || e.dataSeries.visible) {
				e.dataSeries.visible = false;
			}
			else {
				e.dataSeries.visible = true;
			}
			chartCandidate.render();
		}
		  
		   // Assessment Report
        var chartAssessment = {
            animationEnabled: true,
            theme: "light2", // "light1", "light2", "dark1", "dark2"
            title:{
                text: ""
            },
            axisY: {
                //title: "Assessment Report",
                lineColor: "#fff",
                labelFontColor: "#fff",
                tickColor: "#fff",
                gridThickness:0
            },
            legend:{
                fontFamily: 'Arial',
                fontWeight: "normal",
                fontSize: 10
            },
            data: [{        
                type: "column",  
                showInLegend: true, 
                legendMarkerColor: "#4DB87D",
                legendText: "Assessment Report",
                dataPoints: [      
                    { y: ${fn:length(assessment.lessThan40)}, label: "<40%", color: "#4DB87D", indexLabel: "${fn:length(assessment.lessThan40)}", indexLabelFontColor: "#000" },
                    { y: ${fn:length(assessment.between40To60)},  label: "40-60%", color: "#4DB87D", indexLabel: "${fn:length(assessment.between40To60)}", indexLabelFontColor: "#000" },
                    { y: ${fn:length(assessment.between60To80)},  label: "60-80%", color: "#4DB87D", indexLabel: "${fn:length(assessment.between60To80)}", indexLabelFontColor: "#000" },
                    { y: ${fn:length(assessment.moreThan80)},  label: " >=80%", color: "#4DB87D", indexLabel: "${fn:length(assessment.moreThan80)}", indexLabelFontColor: "#000" }
                ]
            }]
        };       
		  $("#assessment-report").CanvasJSChart(chartAssessment);
		  
		 // Sales Non Sales
        var salesNonSales = {
            exportEnabled: true,
            animationEnabled: true,
            title:{
                text: "",
            },
            legend:{
                horizontalAlign: "center",
                verticalAlign: "bottom",
                fontFamily: 'Arial',
                fontWeight: "normal",
                fontSize: 10
            },
            data: [{
                type: "pie",
                showInLegend: true,
                toolTipContent: "<b>{name}</b>: {y} (#percent%)",
                indexLabel: "#percent%",
                legendText: "{name}",
                indexLabelPlacement: "inside",
                indexLabelFontColor: "#ffffff",
                dataPoints: [
                    { y: ${fn:length(designation.sales)}, name: "Sales", color: "#F97D58", indexLabel: "${fn:length(designation.sales)}", indexLabelFontColor: "#FFF" },
                    { y: ${fn:length(designation.nonSales)}, name: "Non-Sales", color: "#FFDE69", indexLabel: "${fn:length(designation.nonSales)}", indexLabelFontColor: "#000" }
                ]
            }]
        };
        $("#sales-nosales").CanvasJSChart(salesNonSales);

        // Gender Diversity
        var genderDiversity = {
            exportEnabled: true,
            animationEnabled: true,
            title:{
                text: "",
            },
            legend:{
                horizontalAlign: "center",
                verticalAlign: "bottom",
                fontFamily: 'Arial',
                fontWeight: "normal",
                fontSize: 10
            },
            data: [{
                type: "pie",
                showInLegend: true,
                toolTipContent: "<b>{name}</b>: {y} (#percent%)",
                indexLabel: "#percent%",
                legendText: "{name}",
                indexLabelPlacement: "inside",
                indexLabelFontColor: "#ffffff",
                dataPoints: [
                    { y: ${fn:length(gender.male)}, name: "Male", color: "#6973D7", indexLabel: "${fn:length(gender.male)}", indexLabelFontColor: "#FFF" },
                    { y: ${fn:length(gender.female)}, name: "Female", color: "#4DB87D", indexLabel: "${fn:length(gender.female)}", indexLabelFontColor: "#FFF" }
                ]
            }]
        };
		
        $("#gender-diversity").CanvasJSChart(genderDiversity);
		
		 // Age Wise
        var chartAge = {
            animationEnabled: true,
            theme: "light2", // "light1", "light2", "dark1", "dark2"
            title:{
                text: ""
            },
            axisY: {
                //title: "Assessment Report",
                lineColor: "#fff",
                labelFontColor: "#fff",
                tickColor: "#fff",
                gridThickness:0
            },
            legend:{
                fontFamily: 'Arial',
                fontWeight: "normal",
                fontSize: 10
            },
            data: [{        
                type: "column",  
                showInLegend: true, 
                legendMarkerColor: "#356098",
                legendText: "Age Wise",
                dataPoints: [      
                    { y: ${fn:length(age.lessThan20)}, label: "<20", color: "#356098", indexLabel: "${fn:length(age.lessThan20)}", indexLabelFontColor: "#000" },
                    { y: ${fn:length(age.between20To25)},  label: "20-25", color: "#356098", indexLabel: "${fn:length(age.between20To25)}", indexLabelFontColor: "#000" },
                    { y: ${fn:length(age.between25To30)},  label: "25-30", color: "#356098", indexLabel: "${fn:length(age.between25To30)}", indexLabelFontColor: "#000" },
                    { y: ${fn:length(age.between30To35)},  label: "30-35", color: "#356098", indexLabel: "${fn:length(age.between30To35)}", indexLabelFontColor: "#000" },
                    { y: ${fn:length(age.between35To40)},  label: "35-40", color: "#356098", indexLabel: "${fn:length(age.between35To40)}", indexLabelFontColor: "#000" },
                    { y: ${fn:length(age.moreThan40)},  label: ">=40", color: "#356098", indexLabel: "${fn:length(age.moreThan40)}", indexLabelFontColor: "#000" }
                ]
            }]
        };
		       $("#age-wise").CanvasJSChart(chartAge);
		  
        // New apex charts

        //CANDIDATE EXPERIENCE
      
        var options = {
          series: [{
          name: 'Total Experience (Non Auto)',
          data: [${fn:length(expNonAuto.lessThan3Months)},${fn:length(expNonAuto.months3To6)},${fn:length(expNonAuto.months6To1Year)},${fn:length(expNonAuto.year1To2Year)},${fn:length(expNonAuto.year2To5Year)},${fn:length(expNonAuto.year5To10Year)},${fn:length(expNonAuto.moreThan10Year)}]
        }, {
          name: 'Total Experience (Auto Industry)',
          data: [${fn:length(experience.lessThan3Months)},${fn:length(experience.months3To6)},${fn:length(experience.months6To1Year)},${fn:length(experience.year1To2Year)},${fn:length(experience.year2To5Year)}, ${fn:length(experience.year5To10Year)},${fn:length(experience.moreThan10Year)}]
        }],
          chart: {
          type: 'bar',
          width: '100%',
          height: 350,
        },
        plotOptions: {
          bar: {
            horizontal: false,
            columnWidth: '70%',
            endingShape: 'rounded'
          },
        },
        dataLabels: {
          enabled: true
        },
        stroke: {
          show: true,
          width: 2,
          colors: ['transparent']
        },
        xaxis: {
          categories: ['<3 M', '3 M to 6 M', '6 M - 1 Y', '1 - 2 Y', '2 - 5 Y', '5 - 10 Y', '>=10 Y'],
        },
        // yaxis: {
        //   title: {
        //     text: '$ (thousands)'
        //   }
        // },
        fill: {
          opacity: 1
        },
        tooltip: {
          y: {
            formatter: function (val) {
              return val
            }
          }
        },
      
        responsive: [{
          breakpoint: 480,
          options: {
            chart: {
              width: '100%',
              height:350,
            },
              plotOptions: {
          bar: {
            horizontal: false,
            columnWidth: '70%',
            endingShape: 'rounded'
          },
        },
            legend: {
              position: 'bottom'
            }
          }
        }]
        };

        var chart = new ApexCharts(document.querySelector("#candidate-experience-v2"), options);
        chart.render();
        
        var options = {
        series: [${fn:length(source.referrals)},${fn:length(source.directWalkIn)}, ${fn:length(source.advertisement)},${fn:length(source.jobConsultant)}, ${fn:length(source.socialMedia)}, ${fn:length(source.others)}],

          // series: [44, 55, 41, 17, 15],
          chart: {
          type: 'donut',
          width: '100%',
          height: 350,
        },
        labels: ['Referrals', 'Direct Walk In', 'Advertisement', 'Job Consultant', 'Social Media', 'Other'],
        colors:['#1ab7ea', '#24b181', '#fcba39','#fd5f76','#8973d6','#3295b8'],
        fill:{
          opacity:1
        },
        legend: {
          position: 'bottom'

        },
        // responsive: [{
        //   breakpoint: 980,
        //   options: {
        //     chart: {
        //       width: '100%',
        //       height:350,
        //     },
        //     legend: {
        //       position: 'bottom'
        //     }
        //   }
        // }]
        };

        var chart = new ApexCharts(document.querySelector("#recruitment-source-v2"), options);
        chart.render();
    
      
            // AGE WISE

            var options = {
          series: [{
            name:'Age Wise',
          data: [${fn:length(age.lessThan20)},${fn:length(age.between20To25)},${fn:length(age.between25To30)},${fn:length(age.between30To35)},${fn:length(age.between35To40)},${fn:length(age.moreThan40)}]
        }],
          chart: {
          type: 'bar',
          height: 350,
          width: '100%',
          // height: 240,
        },
        plotOptions: {
          bar: {
            borderRadius: 4,
            horizontal: true,
          }
        },
        dataLabels: {
          enabled: true
        },
        colors: ['#59edbb'],
        xaxis: {
          // categories: ['<20', '20-25', '25-30', '30-35', '35-40', '>=40',
          categories: ['18-20','20-25', '25-30', '30-35', '35-40', '>=40',
          ],
        }
        };

        var chart = new ApexCharts(document.querySelector("#age-wise-v2"), options);
        chart.render();

        //ASSESSMENT REPORT

        
        var options = {
          series: [{
          name: 'Assessment Report',
          data: [${fn:length(assessment.lessThan40)}, ${fn:length(assessment.between40To60)}, ${fn:length(assessment.between60To80)}, ${fn:length(assessment.moreThan80)}]
        }],
          chart: {
          type: 'bar',
          height: 350,
          width: '100%',
          // height: 230,
        },
        plotOptions: {
          bar: {
            horizontal: false,
            columnWidth: '55%',
            endingShape: 'rounded'
          },
        },
        dataLabels: {
          enabled: true
        },
        stroke: {
          show: true,
          width: 2,
          colors: ['transparent']
        },
        xaxis: {
          categories: ['<40%', '40-60%', '60-80%', '>=80%'],
        },
        fill: {
          opacity: 1
        },
        tooltip: {
          y: {
            formatter: function (val) {
              // return "$ " + val + " thousands"
              return  val
            }
          }
        }
        };

        var chart = new ApexCharts(document.querySelector("#assessment-report-v2"), options);
        chart.render();

        //OVERVIEW
        var options = {
          series: [${fn:length(overview.registered)},${fn:length(overview.assessments)},${fn:length(overview.pass)},${fn:length(overview.offer)},${fn:length(overview.recruited)}],
          chart: {
          width:'100%',
          height:350,
          type: 'radialBar',
        },
        plotOptions: {
          radialBar: {
            offsetY: 0,
            startAngle: 0,
            endAngle: 360,
            hollow: {
              margin: 5,
              size: '10%',
              background: 'transparent',
              image: undefined,
            },
            dataLabels: {
              name: {
                show: false,
              },
              
              value: {
                show: false,
              }
            }
          }
        },
        colors: ['#1ab7ea', '#24b181', '#fcba39','#fd5f76' ,'#00e396'],
        labels: ['Registered', 'Assessments','Passed', 'Offered','Recruited'],
        legend: {
          show: true,
          floating: true,
          fontSize: '13px',
          position: 'bottom',
          // offsetX: 160,
          // offsetY: 15,
          labels: {
            useSeriesColors: true,
          },
          markers: {
            size: 0
          },
          formatter: function(seriesName, opts) {
            return seriesName + ":  " + opts.w.globals.series[opts.seriesIndex]
          },
          itemMargin: {
            vertical: 3
          }
        },
        responsive: [{
          height: 350,
          width: '100%',
          breakpoint: 480,
          options: {
            legend: {
                show: false
            }
          }
        }]
        };

        var chart = new ApexCharts(document.querySelector("#overview-v2"), options);
        chart.render();
      
      //GENDER DIVERSITY

      // dataPoints: [
      //               { y: ${fn:length(gender.male)}, name: "Male", color: "#6973D7", indexLabel: "${fn:length(gender.male)}", indexLabelFontColor: "#FFF" },
      //               { y: ${fn:length(gender.female)}, name: "Female", color: "#4DB87D", indexLabel: "${fn:length(gender.female)}", indexLabelFontColor: "#FFF" }
      //           ]
      var options = {
          series: [${fn:length(gender.male)}, ${fn:length(gender.female)}],
          chart: {
          width: '100%',
          height: 390,
          type: 'donut',
        },
        plotOptions: {
          pie: {
            startAngle: -90,
            endAngle: 270
          }
        },
        dataLabels: {
          enabled: true
        },
        fill: {
          type: 'gradient',
        },
        legend: {
          position: 'bottom'
        },
        labels: ["Male","Female"]
        // title: {
        //   text: 'Gradient Donut with custom Start-angle'
        // },
        // responsive: [{
        //   breakpoint: 480,
        //   options: {
        //     chart: {
        //       width: 200
        //     },
        //     legend: {
        //       position: 'bottom'
        //     }
        //   }
        // }]
        };

        var chart = new ApexCharts(document.querySelector("#gender-diversity-v2"), options);
        chart.render();

        
        //ACTION POINTS (PENDING)
          
        var options = {
          series: [{
          name: 'Action Points',
          data: [${fn:length(action.assessmentStatus)},${fn:length(action.interviewStatus)}, ${fn:length(action.documentUploadStatus)},${fn:length(action.prarambhStatus)},${fn:length(action.fsdmApproval)}]
        }],
          chart: {
          type: 'bar',
          height: 300
        },
        plotOptions: {
          bar: {
            horizontal: false,
            columnWidth: '55%',
            endingShape: 'rounded'
          },
        },
        dataLabels: {
          enabled: true
        },
        stroke: {
          show: true,
          width: 2,
          colors: ['transparent']
        },
        xaxis: {
          categories: ['Assessments', 'Interview', 'Documents', 'Induction Course', 'FSDM Approval'],
        },
        fill: {
          opacity: 1
        },
        tooltip: {
          y: {
            formatter: function (val) {
              // return "$ " + val + " thousands"
              return val
            }
          }
        },
        onClick: function(e, legendItem) {console.log('Item:'+legendItem);}
        };

        var chart = new ApexCharts(document.querySelector("#action-points-v2"), options);
        chart.render();


        //SALES / NON SALES
        
        var options = {
          series: [ ${fn:length(designation.sales)},${fn:length(designation.nonSales)}],
          chart: {
          // width: 380,
          width: '100%',
          height: 350,
          type: 'pie',
        },
        legend: {
          position: 'bottom'

        },
        labels: ['Sales', 'Non-Sales'],
        dataLabels: {
          enabled: true
        },
        responsive: [{
          breakpoint: 480,
          options: {
            chart: {
              width: '100%',
              height: 350,
            },
            legend: {
              position: 'bottom'
            }
          }
        }]
        };

        var chart = new ApexCharts(document.querySelector("#sales-nosales-v2"), options);
        chart.render();
    

        //Demo
        
  //       var options = {
  //         series: [{
  //         name:'Not-Started',
  //         data: [44, 55, 41, 64]
  //       }, 
  //       {
  //         name:'In-Progress',
  //         data: [44, 55, 41, 64]
  //       }, 
  //       {
  //         name:'Completed',
  //         data: [53, 32, 33, 52]
  //       }],
  // colors:['#e30016', '#f1eb36', '#4ecb31'],

  //         chart: {
  //         type: 'bar',
  //         height: 500
  //       },
  //       plotOptions: {
  //         bar: {
  //           horizontal: true,
  //           dataLabels: {
  //           position: 'top',
  //           },
  //         }
  //       },
  //       dataLabels: {
  //         enabled: true,
  //         offsetX: 23,
  //         style: {
  //           fontSize: '12px',
  //           colors: ['#555']
  //         }
  //       },
  //       stroke: {
  //         show: true,
  //         width: 2,
  //         colors: ['#fff']
  //       },
  //       tooltip: {
  //         shared: true,
  //         intersect: false
  //       },
  //       xaxis: {
  //         categories: ['Courses', 'Assessment', 'Survey', 'QOD'],
  //       },
  //       };

  //       var chart = new ApexCharts(document.querySelector("#chart"), options);
  //       chart.render();
      
      
      });
	
    </script>
    <script type="text/javascript">
      function exportToCSV(){
    	  var regionCode = $('#regionCode').val();
		    var stateCode =$('#stateCode').val();
		    var cityCode =$('#cityCode').val();
		    var dealershipName =$('#dealershipName').val();
		    var outletCode =$('#outletCode').val();
		    var dateFromm =$('#dateFromm').val();
		    var dateToo =$('#dateToo').val();
        var approved = null;
		    var form = document.createElement("form");
      	
		    form.method="post";
		    form.action="./dashboardCSVReport?outletCode="+outletCode+"&dealershipName="+dealershipName+"&regionCode="+regionCode+"&stateCode="+stateCode+"&cityCode="+cityCode+"&approved="+approved+"&dateFromm="+dateFromm+"&dateToo="+dateToo;
		    document.body.appendChild(form);
		    form.submit();
        }
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

    <script>
   function   redirectToReport(){
    window.location.href="irecruit/showAllLinksCSV";
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