<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import = "java.util.ResourceBundle" %>

<%
try
    {
      ResourceBundle resource = ResourceBundle.getBundle("application");
	  String baseServer = resource.getString("client.url");
	  String title = resource.getString("app.title");
	  if(session.getAttribute("role") != null)
	  {
		String role = session.getAttribute("role").toString().trim();
	%>
<!DOCTYPE html>
<html lang="en"><head>
<meta http-equiv="content-type" content="text/html; charset=windows-1252">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	  <link rel="icon" type="image/x-icon" href="<%=baseServer%>img/DuflonFavicon.png"/>
    <title><%=title %></title>
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
        input.ir-export-csv {background: #DC3545 !important;color: #fff !important;font-size: 13px !important;text-align: center !important;}
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
        <div ><p><b>* Data Period : </b>${defaultDate}</p></div>
        <div class="dashboard-section">
            <div class="dashboard-block ir-col-3 ">
              <h3>Recruitment Funnel</h3>
              <div class="ir-pyaramid">
                <div class="pyramid_wrap">
                  <div class="category_one" onclick="getAnalyticsByAccesskeyList('${overview.registered}','registered')">
                      <h6 class="value" >${fn:length(overview.registered)}</h6>
                  </div>
                  <div class="category_two" onclick="getAnalyticsByAccesskeyList('${overview.assessments}','assessment')">
                    <h6 class="value">${fn:length(overview.assessments)}</h6>
                  </div>
                  <div class="category_three" onclick="getAnalyticsByAccesskeyList('${overview.pass}','passed')">
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
                <!-- <h3>Sales / Non Sales</h3> -->
                <h3>Designation</h3>
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
    </div>
    <div class="blk-bg"></div>
     <script type="text/javascript" src="./js/apexcharts.js"></script>
    <script>
      $(document).ready(function () {
    	  
    	  var form = $('#formFilter');
    	  form.attr('action', 'analytics');
    	  
    	  
        // New apex charts
        //CANDIDATE EXPERIENCE
      
        var options = {
          series: [{
          name: 'Total Experience',
          data: [${fn:length(experience.lessThan3Months)},${fn:length(experience.months3To6)},${fn:length(experience.months6To1Year)},${fn:length(experience.year1To2Year)},${fn:length(experience.year2To5Year)}, ${fn:length(experience.year5To10Year)},${fn:length(experience.moreThan10Year)}],
          }],
          chart: {
          type: 'bar',
          height: 350,
          event: {
        	  click: function(chart, w,e){
        		  console.log('Mukesh');
        		  console.log(chart);
        	  }
          }
        },
        colors: ['#FF0000', '#00FF00', '#0000FF', '#FFFF00', '#FFC0CB', '#EE82EE', '#FFA500'],
        plotOptions: {
          bar: {
            horizontal: false,
            columnWidth: '55%',
            endingShape: 'rounded',
            distribted:true
          }
        },
        dataLabels: {
          enabled: true,
        },
        stroke: {
          show: true,
          width: 2,
          //colors: ['transparent']
        },
        xaxis: {
          categories: ['<3 M', '3 M to 6 M', '6 M - 1 Y', '1 - 2 Y', '2 - 5 Y', '5 - 10 Y', '>=10 Y'],
          labels: {
        	  style: {
        		  fontSize: '12px'
        	  }
          }
        },
        fill: {
          opacity: 1,
        },
        tooltip: {
          y: {
            formatter: function (val) {
              return val
            }
          }
        },
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
        },
        colors: ['#FF0000', '#00FF00', '#0000FF', '#FFFF00', '#FFC0CB', '#EE82EE', '#FFA500'] ,
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
    events: {
        click: function (event, chartContext, config) {
         //console.log(config.dataPointIndex);
      // Retrieve the data point index of the clicked bar
         const dataPointIndex = config.dataPointIndex;
         
         // Access the chart's data array and retrieve the data for the clicked bar
         const clickedBarData = chartContext.w.config.series[config.seriesIndex].data[dataPointIndex];
         getAnalyticsByAccesskeyList('${assessment.moreThan80}','ass');
         
       }
    }
  },
  colors: ['#FF0000', '#00FF00', '#0000FF', '#FFFF00'],
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
        return val;
      }
    }
  }
  
};

var chart = new ApexCharts(document.querySelector("#assessment-report-v2"), options);
chart.render();

      //GENDER DIVERSITY
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
        
        };

        var chart = new ApexCharts(document.querySelector("#gender-diversity-v2"), options);
        chart.render();

        
        //ACTION POINTS (PENDING)
        var options = {
          series: [{
          name: 'Action Points',
          data: [${fn:length(action.assessmentStatus)}, ${fn:length(action.documentUploadStatus)},${fn:length(action.interviewStatus)},${fn:length(action.fsdmApproval)}]
        }],
          chart: {
          type: 'bar',
          height: 300,
          events: {
              click: function (event, chartContext, config) {
               //console.log(config.dataPointIndex);
            // Retrieve the data point index of the clicked bar
               //const dataPointIndex = config.dataPointIndex;
               // Access the chart's data array and retrieve the data for the clicked bar
               //const clickedBarData = chartContext.w.config.series[config.seriesIndex].data[dataPointIndex];
               switch (config.dataPointIndex) {
               case 0:
               	getAnalyticsByAccesskeyList('${action.assessmentStatus}','Action');
                 break;
               case 1:
                 getAnalyticsByAccesskeyList('${action.documentUploadStatus}','Action');
                 break;
               case 2:
                 getAnalyticsByAccesskeyList('${action.interviewStatus}','Action');
                 break;
               case 3:
                 getAnalyticsByAccesskeyList('${action.fsdmApproval}','Action');
                 break;
             }
               
             }
          }
        },
        plotOptions: {
            bar: {
              horizontal: false,
              columnWidth: '55%',
              endingShape: 'rounded',
              distributed: true
            }
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
          categories: ['Assessments', 'Documents', 'Interview', 'Approval'],
        },
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
       /*  events: {
            dataPointSelection: function(event, chartContext, config) {
                  var accesskeyList;
                  var status;
                  switch (config.dataPointIndex) {
                  case 0:
                    status = 'interview';
                    accesskeyList = interviewStatus;
                    break;
                  case 1:
                    status = 'assessment';
                    accesskeyList = assessmentStatus;
                    break;
                  case 2:
                    status = 'documents';
                    accesskeyList = documentUploadStatus;
                    break;
                  case 3:
                    status = 'approval';
                    accesskeyList = fsdmApproval;
                    break;
                }
                  getAnalyticsByAccesskeyList(accesskeyList, status);
                }
              } */
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
        labels: ['Designation 1', 'Designation 2'],
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
         
      });
	
    </script>
    <script type="text/javascript">
      function exportToCSV(){
		    var outletCode =$('#outletCode').val();
		    var dateFromm =$('#dateFromm').val();
		    var dateToo =$('#dateToo').val();

		    var form = document.createElement("form");
      	
		    form.method="post";
		    form.action="./dashboardCSVReport?dateFromm="+dateFromm+"&dateToo="+dateToo;
		    document.body.appendChild(form);
		    form.submit();
        }
    	function getAnalyticsByAccesskeyList(list,status){
    		var role = '<%=role%>'; // This inserts the value of 'role' into the JavaScript code
            if (role === 'SA') {
    		var accesskeyList = JSON.stringify(list);
    		accesskeyList=accesskeyList.replace('[','');
    		accesskeyList=accesskeyList.replace(']','');
            	if(accesskeyList.length>5){	
        			mywindow=window.open("analyticsByAccesskey?accesskeyList="+accesskeyList+"&status="+status, "detailwindow","resizable=1,scrollbars=1,width=1170,height=600");
     	       		mywindow.moveTo(120,90);  
        		}   
            } /* else {
                console.log('User has a different role.');
            } */
    	}
    </script>

    <script>
   function   redirectToReport(){
    window.location.href="duflon/showAllLinksCSV";
}
    </script>
    <script>
$(document).ready(function() {
    var userType = "${role}"; // Replace with the actual user type value

    if (userType === "SA") {
        $(".category_one").click(function() {
            getAnalyticsByAccesskeyList(overview.registered, 'registered');
        });

        $(".category_two").click(function() {
            getAnalyticsByAccesskeyList(overview.assessments, 'assessment');
        });

        $(".category_three").click(function() {
            getAnalyticsByAccesskeyList(overview.pass, 'passed');
        });

        $(".category_four").click(function() {
            getAnalyticsByAccesskeyList(overview.offer, 'offred');
        });

        $(".category_five").click(function() {
            getAnalyticsByAccesskeyList(overview.recruited, 'recruited');
        });
    }
});
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
	  }else{
		    response.sendRedirect("login");
		}
 }catch(Exception e)
    {
    	 System.out.println("Errror....."+e);
    	  response.sendRedirect("login");
    }%>