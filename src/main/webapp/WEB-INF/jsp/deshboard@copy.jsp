<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en"><head>
<meta http-equiv="content-type" content="text/html; charset=windows-1252">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="icon" type="image/x-icon" href="https://staging.irecruit.org.in/irecruit/img/iRecruit-favicon.ico"/>
    <title><%=title %></title>
    <link rel="stylesheet" type="text/css" href="./css/common.css">
    <link rel="stylesheet" type="text/css" href="./css/dashboard.css">
    <link rel="stylesheet" type="text/css" href="./css/dashboard-filter.css">
    <link rel="stylesheet" type="text/css" href="./css/daterangepicker.css" />
    <script src="js/jquery-3.4.1.min.js"></script>
    <script type="text/javascript" src="./js/sweetalert.min.js"></script>
    <script src="./js/moment.min.js"></script>
    <script src="./js/daterangepicker.js"></script>
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
        <div id="data-time"></div>
        <div class="dashboard-section">
            <div class="dashboard-block">
                <h3>Overview</h3>
                <div class="overview-section">
                    <div class="overview-layout">
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
                    <div class="overview-data">
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
                </div>
                <!-- <div class="overview-section">
                    <div class="overview-layout">
                        <div class="pyramid_wrap">
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
                    </div>
                    <div class="overview-data">
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
            </div>
        </div>
        <div class="dashboard-section">
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
                            <h4><img src="./img/dashboard/course.png"  style="width: 20px; height: 20px;"  />Praarambh</h4>
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
            <div class="dashboard-block half">
                <h3>Recruitment Source</h3>
                <div class="dashboard-layout-full" id="recruitment-source" style="height: 350px; width: 971px; left: 50%; transform: translate(-50%, 0);"></div>
            </div>
            <div class="dashboard-block half">
                <h3>Candidate Experience</h3>
                <div class="dashboard-layout-full" id="candidate-experience" style="height: 350px; width: 471px;"></div>
            </div>
        </div>
        <div class="dashboard-section">
            <div class="dashboard-block half">
                <h3>Assessment Report</h3>
                <div class="dashboard-layout-full" id="assessment-report" style="height: 350px; width: 471px;"></div>
            </div>
            <div class="dashboard-block half">
                <h3>Sales / Non Sales</h3>
                <div class="dashboard-layout-full" id="sales-nosales" style="height: 350px; width: 471px;"></div>
            </div>
        </div>
        <div class="dashboard-section">
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
		  
       
      });
	
    </script>
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
</body>
</html>