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
    <link rel="stylesheet" type="text/css" href="./css/dashboard.css">
    <link rel="stylesheet" type="text/css" href="./css/dashboard-filter.css">
    <link rel="stylesheet" type="text/css" href="./css/hiring-in-process.css" />
    <link rel="stylesheet" type="text/css" href="./css/fsdm.css" />
    <link rel="stylesheet" type="text/css" href="./css/sweetalert.css"/>
    <script type="text/javascript" src="./js/sweetalert.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.12.1/css/jquery.dataTables.min.css">
    <link rel="stylesheet" type="text/css" href="./css/datatable.css">
	
	
    <style>
    	.dataTables_scroll{padding: 5px 0px 0px 0px;}
        .dataTables_scrollBody{position: relative;overflow: auto;width: 100%;max-height: 445px !important;}
        .export-to-csv .ecsvbutton {background: #DC3545 !important;color: #fff !important;}
        .export-to-csv{right: 0 !important;padding: 20px 0px 0px 0px !important;}
	    .csv-icn-button{font-family: Arial;display: inline-block;padding: 9px 17px 9px 15px;font-size: 13px !important;line-height: 18px;border:1px solid #DC3545;color: #DC3545;border-radius: 30px;cursor: pointer;position: relative;background-color: #fff;text-decoration: none;}
        .dt-buttons {display: inline-flex;width: calc(100% - 230px);}
        .dataTables_wrapper .dataTables_filter input{padding: 10px 0px 10px 0px !important;}
        .buttons-csv.buttons-html5.ecsvbutton {margin-left: auto;}
        .right-section h3{margin-top: 25px !important;}
   </style>
<script src="./js/savefile.js"></script>
   <script>
   

$(document).ready(function(){
 $('.table-date').hide();
setInterval(function () {
 $('.table-date').show();

}, 1000);
});

    function downloadExcel(){
		 
let table = $('#data').DataTable()
 

var header = 'Sr. No.,Candidate Name,Region,Dealer Code,Dealer City,Dealer Name,State,Designation Code,Designation Desc,Mobile, Email Id, Access Key, Registration Date, Assessment Date,Total Marks,Marks Obtain,Percentage, Assessment Status,';

for(i=1; i<=40; i++){
header+='Question '+i+',';
}
header+='\n';

let data = table
    .rows()
    .data();

let text = ''+header;
data.map( row => text += row.join( ',' ) + '\n' );
let blob = new Blob( [text], {type: "text/csv;charset=utf-8"} )
saveAs( blob, 'Assessment Report.csv' );

               
			
	}
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
        <h3>Assessment Report</h3>
        <div class="page-filter-include">
		  <%@include file="./filter/assessmentReportFilter.jsp"%>
	    </div>
        <a href="https://staging.irecruit.org.in/irecruit/showAllLinksCSV?flag" class="csv-icn-button">Back to report</a>
        <!-- <div class="container-1100"> -->
            <div class="table-date" style="display:none">
				 <!-- <div class="export-to-csv"><input type="button" onclick="downloadExcel()" value="Export To CSV" class="ecsvbutton"></div>-->
                <table id="data" cellspacing="0" cellpadding="0" border="0" class="display nowrap cell-border" width="50" style="width: 100% !important;height: auto !important;">
                   <thead>
                        <tr>
                            <th data-head="Sr. No." style="z-index: 1 !important;"><em>Sr. No.</em></th>
							<th data-head="Candidate Name" style="z-index: 1 !important;" ><em>Candidate Name</em></th>                       
							<th data-head="Region" class="sorting"><em>Region</em></th>
							<th data-head="Dealer Code" class="sorting"><em>Dealer Code</em></th>
							<th data-head="Dealer City" class="sorting"><em>Dealer City</em></th>
							<th data-head="Dealer Name" class="sorting"><em>Dealer Name</em></th>
							<th data-head="State" class="sorting"><em>State</em></th>
                            <th data-head="Designation Code" class="sorting"><em>Designation Code</em></th>
                            <th data-head="Designation Desc" class="sorting"><em>Designation Desc</em></th>
                            <th data-head="Mobile" class="sorting"><em>Mobile</em></th>						
                            <th data-head="Email Id" class="sorting"><em>Email Id</em></th>
							<th data-head="Access Key" class="sorting"><em>Access Key</em></th>
                            <th data-head="Registration Date" class="sorting"><em>Registration Date</em></th>
                            <!-- <th data-head="Assessment Completion Date" class="sorting"><em>Assessment Completion Date</em></th> -->
                            <th data-head="Assessment Date" class="sorting"><em>Assessment Date</em></th>
                            <th data-head="Total Marks" class="sorting"><em>Total Marks</em></th>
                            <th data-head="Marks Obtained" class="sorting"><em>Marks Obtained</em></th>
                            <th data-head="Percentage" class="sorting"><em>Percentage</em></th>
							<th data-head="Assessment Status" class="sorting"><em>Assessment Status</em></th>
                           <%for(int i=1; i<=40; i++){ %>
                           <th data-head="Question <%=i %>" class="sorting"><em>Question <%=i %></em></th>
                           <%} %>
                        </tr>
                    </thead>
                    <tbody>
                    <%int i=1;
					%>
                    <c:forEach items="${assessList}" var="participant">
					
						
						
                       <tr>
                            <td><span><%=i %></span></td>
							<td><span>${participant.name}</span></td>
							<td><span>${participant.region }</span></td>
							<td><span>${participant.dealerCode}</span></td>
							<td><span>${participant.city}</span></td>
							<td><span>${participant.dealerName}</span></td>
							<td><span>${participant.state}</span></td>
							<td><span>${participant.designationCode}</span></td>
                            <td><span>${participant.designationDesc}</span></td>
                            <td><span>${participant.mobile}</span></td>        
                            <td><span>${participant.email}</span></td>
                            <td><span>${participant.accesskey}</span></td>
                            <td><span>${participant.registrationDate}</span></td>
                            <td><span>${participant.assessmentDate}</td>
                            <td><span>${participant.totalMark}</span></td>
                            <td><span>${participant.markObtained}</span></td>
                            <td><span>${participant.percentage}%</span></td>
                            <td><span>${participant.assessmentStatus}</span></td>
                             <c:choose>
                              <c:when test="${participant.list.size() gt 0 }">
                               <c:forEach items="${participant.list}" var="list">
                                   <td><span> <c:out value="${list}" /></span></td>
                              </c:forEach>
                              </c:when>
                               <c:otherwise>
                             <%for(int j=1; j<=40; j++){ %>
                             <!-- <td><span></span></td> -->
                             <%} %>
                               </c:otherwise>
                             
                             </c:choose>
                        </tr>
					<%
					
					i++; %>
                        </c:forEach>
					
                    </tbody>
                </table>
            </div>
        <!-- </div> -->
    </div>
  </body>
  <style>
    #data-ov_paginate a.paginate_button.current, #data-ap_paginate a.paginate_button.current, #data-rs_paginate a.paginate_button.current, #data-sns_paginate a.paginate_button.current, #data-gd_paginate a.paginate_button.current, #data-ce_paginate a.paginate_button.current, #data-aw_paginate a.paginate_button.current, #data-ar_paginate a.paginate_button.current, #data-qa_paginate a.paginate_button.current, #data-ca_paginate a.paginate_button.current{background: rgb(193 193 193) !important}
    #data-ov_paginate a, #data-ap_paginate a, #data-rs_paginate a, #data-sns_paginate a, #data-gd_paginate a, #data-ce_paginate a, #data-aw_paginate a, #data-ar_paginate a, #data-qa_paginate a, #data-ca_paginate a {
        margin-left: 20px !important;
        text-decoration: none !important;
        display: inline-block !important;
        padding: 7px 20px !important;
        font-size: 13px;
        line-height: 20px;
        color: #fff !important;
        border-radius: 20px !important;
        border: none !important;
        background-color: #DC3545 !important;
        cursor: pointer !important;
    }
    #data-ov_paginate, #data-ap_paginate, #data-rs_paginate, #data-sns_paginate, #data-gd_paginate, #data-ce_paginate, #data-aw_paginate, #data-ar_paginate, #data-qa_paginate, #data-ca_paginate{
        margin: 30px 0 0;
        width: 100%;
        text-align: center;
    }
    table.dataTable thead>tr>th.sorting:nth-child(2) {
            left: 83px !important;
        }
    td.dtfc-fixed-left:nth-child(2) {
            left: 83px !important;
        }
        .page-filters {
    padding-top: 0px !important;
    padding-bottom: 7px !important;
    display: flex;
    flex-wrap: wrap;}
         /* table.dataTable tbody td{
            padding: 8px 14px !important;
        } */
    th.sorting {min-width: 50px !important;}
</style>
</html>
<script src="./js/jquery-3.4.1.min.js"></script>
<script src="./js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/fixedcolumns/4.2.1/js/dataTables.fixedColumns.min.js"></script>
<!-- <script src="./js/datatable.js"></script> -->
<script>
    $(document).ready(function () {
    setTimeout(() => {
        $('th').on("click", function (event) {
            if($(event.target).is("input"))
                event.stopImmediatePropagation();
        });
    
        var table = $('#data').DataTable({
            "pageLength": 10,
            scrollY: '425px',
            scrollCollapse: true,
            scrollX: true,
            fixedColumns:   {
                left: 2
            },
            dom: 'Bfrtip',
            buttons: [ 
    { extend: 'csv', text: 'Export to CSV', className: 'ecsvbutton', title:$('#filename').val() } 
            ]
        });
    
        
        
        $('#data thead tr')
            .clone(true)
            .find('th')
            .removeClass('sorting_asc sorting_asc sorting')
            .off('click')
            .end()
            .appendTo('#data thead');
    
        $('.dataTables_scrollHead .dataTable thead tr:eq(0) th').each(function (i) {
            var title = $(this).data('head');
            if (title) {
                $(this).append('<input type="text" placeholder="' + title + '" />');
            } else {
                $(this).append('');
            }
    
            $('input', this).on('keyup change', function () {
                if (table.column(i).search() !== this.value) {
                    table
                        .column(i)
                        .search(this.value)
                        .draw();
                }
            });
        });
    
        $('.add-remove-columns span').click(function(){
            $(this).addClass('active');
            $('.add-remove-columns ul').show();
        });
     
        $('a.toggle-vis').on('click', function (e) {
            e.preventDefault();
     
            // Get the column API object
            var column = table.column($(this).attr('data-column'));
     
            // Toggle the visibility
            column.visible(!column.visible());
            $(this).parent().toggleClass('active');
        });
        
        $(document).mouseup(function(e) 
        {
            var container = $(".add-remove-columns ul");
            if (!container.is(e.target) && container.has(e.target).length === 0) 
            {
                container.hide();
                $('.add-remove-columns span').removeClass('active');
            }
        });
    }, 1000);
});
</script>
<script type="text/javascript" src="./js/table2csv.js"></script>

<script type="text/javascript" src="https://cdn.datatables.net/buttons/2.3.2/js/dataTables.buttons.min.js"></script> 
<script type="text/javascript" src="https://cdn.datatables.net/buttons/2.3.2/js/buttons.html5.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/buttons/2.3.2/js/buttons.print.min.js"></script>

<input type='hidden' id='filename' value='Assessment Report'>

<%
 }catch(Exception e)
    {
    	 System.out.println("Errror....."+e);
    	  response.sendRedirect("login");
    }%>