<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title><%=title %></title>
    <link rel="stylesheet" type="text/css" href="./css/common.css" />
    <link rel="stylesheet" type="text/css" href="./css/hiring-in-process.css" />
	 <link rel="stylesheet" type="text/css" href="./css/sweetalert.css"/>
    <script type="text/javascript" src="./js/sweetalert.min.js"></script>
	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.12.1/css/jquery.dataTables.min.css">
    <link rel="stylesheet" type="text/css" href="./css/datatable.css">
    <style>
        .left-panel > ul > li:nth-child(1) > a, .left-panel > ul > li:nth-child(1) > ul > li:nth-child(2) > a{opacity: 1;}
        .left-panel > ul > li:nth-child(1) > ul > li:nth-child(2) > a::after{content: ''; position: absolute; right: 0; top: 50%; transform: translate(0, -50%); border-right: 6px solid #fff; border-top: 6px solid transparent; border-bottom: 6px solid transparent;}
    </style>

    <script src="./js/jquery-3.4.1.min.js"></script>
    <script src="./js/jquery.dataTables.min.js"></script>
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
    <%-- <div class="page-filter-include">
		  <%@include file="./header/page-filter.jsp"%>
		</div> --%>
    
        <div class="dashboard-section">
            <div class="dashboard-block">
                <h3>Overview</h3>
                <div class="overview-section">
                    <div class="overview-data">
                        <div class="overview-data-block">
                            <h4><img src="./img/dashboard/d-icn01.svg" />Registered</h4>
                            <!-- <p>306</p> -->
                             <p>${overview.registered}</p>
                        </div>
                        <div class="overview-data-block">
                            <h4><img src="./img/dashboard/d-icn02.svg" />Assessments</h4>
                            <p>283</p>
                        </div>
                        <div class="overview-data-block">
                            <h4><img src="./img/dashboard/d-icn03.svg" />Passed</h4>
                            <p>137</p>
                        </div>
                        <div class="overview-data-block">
                            <h4><img src="./img/dashboard/d-icn04.svg" />Offered</h4>
                            <p>28</p>
                        </div>
                        <div class="overview-data-block">
                            <h4><img src="./img/dashboard/d-icn05.svg" />Recruited</h4>
                            <p>9</p>
                        </div>
                    </div>
                    <div class="overview-layout">
                        <div class="pyramid_wrap">
                            <div class="category_one">
                                <h6 class="value">306</h6>
                            </div>
                            <div class="category_two">
                              <h6 class="value">283</h6>
                            </div>
                            <div class="category_three">
                              <h6 class="value">137</h6>
                            </div>
                            <div class="category_four">
                              <h6 class="value">28</h6>
                            </div>
                            <div class="category_five">
                              <h6 class="value">9</h6>
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
                </div>
            </div>
        </div>
    </div>

    <script src="./js/jquery-3.4.1.min.js"></script>
    <script>
      $(document).ready(function () {
        $(".left-panel-include").load("/includes/left-panel/left-panel.html");
        $(".user-panel-include").load("/includes/user-panel/user-panel.html");
      });
    </script>
  </body>
</html>
