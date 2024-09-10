<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="java.util.ResourceBundle"%>
<%
	try {
		ResourceBundle resource = ResourceBundle.getBundle("application");
		String baseServer = resource.getString("client.url");
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
<link rel="icon" type="image/x-icon"
	href="<%=baseServer%>img/iRecruit-favicon.ico" />
<title>iRecruit</title>
<link rel="stylesheet" type="text/css" href="./css/common.css" />
<link rel="stylesheet" type="text/css"
	href="./css/hiring-in-process.css" />
<link rel="stylesheet" type="text/css" href="css/dashboard-filter.css">
<link rel="stylesheet" type="text/css" href="./css/sweetalert.css" />
<script type="text/javascript" src="./js/sweetalert.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/1.12.1/css/jquery.dataTables.min.css">
<link rel="stylesheet" type="text/css" href="./css/datatable.css">
<script src="./js/jquery-3.4.1.min.js"></script>
<script src="./js/jquery.dataTables.min.js"></script>
<script
	src="https://cdn.datatables.net/fixedcolumns/4.2.1/js/dataTables.fixedColumns.min.js"></script>
<script src="./js/datatable.js"></script>
<style>
.dataTables_scrollBody {
	overflow-y: hidden !important;
	overflow-x: auto !important;
}

.dataTables_wrapper .dataTables_filter input {
	padding: 10px 0px 10px 0px !important;
}

@media ( max-width : 820px) {
	/* .page-filters-filter-block {width: 515px !important;} */
	.table-date {
		top: 55px !important;
	}
	/* .page-filters-process-block {width: 450px !important;left: -242px !important;} */
}

@media ( max-width : 768px) {
	.page-filters-filter-block .form-section .form-block {
		width: calc(100% - 20px) !important;
	}
	.page-filters-filter-block {
		width: 400px !important;
	}
	.communications-popup {
		width: 650px !important;
	}
	.table-date {
		top: 50px !important;
	}
}

@media ( max-width : 767px) {
	.page-filters-filter-block .form-section .form-block {
		width: calc(100% - 20px) !important;
	}
	/* .page-filters {margin-top: 60px !important;} */
	.page-filters-filter-block {
		width: 390px !important;
	}
}

@media ( max-width : 426px) {
	.fixdate-popup {
		width: 350px !important;
	}
	textarea#addressarea {
		width: 290px !important;
	}
	.communications-popup .form-section .form-block {
		width: calc(100% - 20px) !important;
	}
	.communications-popup {
		width: 385px !important;
	}
	.page-filters-process-block {
		width: 350px !important;
		left: -135px !important;
	}
}

@media ( max-width :400px) {
	.communications-popup .form-section .form-block {
		width: calc(100% - 20px) !important;
	}
	.page-filters-filter-block {
		width: 350px !important;
	}
	.page-filters-process-block {
		width: 320px !important;
		left: -150px !important;
	}
}

@media ( max-width : 376px) {
	/* .page-filters {margin-top: 20px !important;} */
	.add-remove-columns.irc-add-remove-columns {
		margin: 0 !important;
	}
	.fixdate-popup {
		width: 300px !important;
	}
	textarea#addressarea {
		width: 240px !important;
	}
	.communications-popup .form-section .form-block {
		width: calc(100% - 20px) !important;
	}
	div#data_filter {
		margin-top: -30px !important;
	}
	.export-to-csv {
		top: 0px !important;
		left: 0 !important;
	}
	.page-filters-process-block {
		width: 320px !important;
		left: -150px !important;
	}
	.page-filters-filter-block .form-section .form-block,
		.page-filters-process-block .form-section .form-block {
		width: calc(100% - 20px) !important;
	}
	.page-filters-filter-block {
		width: 350px !important;
	}
}

@media ( max-width : 320px) {
	/* .page-filters {margin-top: 20px !important;} */
	button.page-filters-filter {
		margin-right: 30px !important;
	}
	.page-filters-block {
		display: contents !important;
		right: 30px !important;
	}
	.table-date {
		top: 50px !important;
	}
	div#data_filter {
		margin-top: -30px !important;
	}
	.export-to-csv {
		top: 0px !important;
		left: 0 !important;
	}
	.user-panel {
		right: 4px !important;
	}
	.communications-popup {
		width: 300px !important;
	}
	.communications-popup .form-section .form-block {
		width: calc(100% - 20px) !important;
	}
	.fixdate-popup {
		width: 300px !important;
	}
	.add-remove-columns {
		top: -45px !important;
		left: 0;
	}
	.page-filters-filter-block .form-section .form-block,
		.page-filters-process-block .form-section .form-block {
		width: calc(100% - 20px) !important;
	}
	.page-filters-filter-block {
		width: 300px !important;
		top: 152px !important;
		left: -20px !important;
	}
	.page-filters-filter-block, .page-filters-process-block {
		margin-left: 35px;
		width: 255px !important;
		top: 145px !important;
	}
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
		<h1>Dealer Login Details</h1>

		<div class="page-filter-include"></div>

		<!-- <h1  >In Progress</h1> -->
		<div class="container-1100">
			<div class="table-date">

				
				<table id="data" cellspacing="0" cellpadding="0" border="0" style="margin-left: 0px; width: 100%;"
					class="stripe display nowrap cell-border" width="50">
					<thead>
						<tr>
							<th data-head="Sr. No." style="z-index: 1 !important;"><em>Sr.
									No.</em></th>
							<th data-head="MSPIN" class="sorting"
								style="z-index: 1 !important;"><em>MSPIN</em></th>
							<th data-head="Dealer Name" class="sorting"><em>Dealer
									Name</em></th>
							<th data-head="Dealer Email" class="sorting"><em>Dealer
									Email</em></th>
							<th data-head="Dealer Mobile" class="sorting"><em>Dealer
									Mobile</em></th>
							<th data-head="Password" class="sorting"><em>Password</em></th>
							<th data-head="Status" class="sorting"><em>Status</em></th>
                                                       <th data-head="Activate Dealer" class="sorting"><em>Activate Dealer</em></th>
						</tr>
					</thead>
					<tbody>
						<%
							int i = 1;
						%>
						<c:forEach items="${dealerList}" var="list">
							<tr>
								<td><%=i%></td>
								<td>${list.mspin}</td>
								<td>${list.name}</td>
								<td>${list.email}</td>
								<td>${list.mobile }</td>
								<td>${list.password }</td>
								<td>
								<c:choose>
										<c:when test="${list.status eq 'true'}">
											<span <%-- onclick="deActivate('${list.mspin}')" --%>>Active</span>
										</c:when>
										<c:when test="${list.status eq 'false' }">
											<span <%--onclick="activate('${list.mspin}')"--%> >InActive</span>
										</c:when>
										<c:when test="${list.status eq '' || list.status eq null }">
											 <span <%--onclick="deActivate('${list.mspin}')"--%>>Active </span>
										</c:when>
										
									</c:choose></td>

                                                                 <td>
								   <c:choose>
										
										<c:when test="${list.status eq 'false' }">
											  <input type="button" class="btn btn-sm btn-dark" value="Activate Dealer" style="width: 100px;" onclick="activate('${list.mspin}')" />
										</c:when>
										<c:when test="${list.status eq '' || list.status eq null }">
											 
										</c:when>
										
									</c:choose></td>
							</tr>
							<%
								i++;
							%>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<div class="blk-bg"></div>
	<script>
		function deActivate(mspin) {

			swal({
				title : "Do you want inActive dealer",
				showCancelButton : true,
				confirmButtonColor : "#2d3393",
				confirmButtonText : "OK",
				cancelButtonText : "Cancel",
				closeOnConfirm : false
			}, function(isConfirm) {
				if (isConfirm) {
					$.ajax({
						url : 'deactivateDealerPro',
						type : 'post',
						data : 'mspin=' + mspin ,
						success : function(res) {
							if (res != "success") {
								showMSG(res);
							} else {
								location.reload();
							}
						},
						error : function(ress) {
							window.close();
						}
					});

				}
			});
		}
		
		function activate(mspin) {

			swal({
				title : "Do you want activate dealer ?",
				showCancelButton : true,
				confirmButtonColor : "#2d3393",
				confirmButtonText : "OK",
				cancelButtonText : "Cancel",
				closeOnConfirm : false
			}, function(isConfirm) {
				if (isConfirm) {
					$.ajax({
						url : 'activateDealerPro',
						type : 'post',
						data : 'mspin=' + mspin ,
						success : function(res) {
							if (res != "success") {
								showMSG(res);
							} else {
								location.reload();
							}
						},
						error : function(ress) {
							window.close();
						}
					});

				}
			});
		}
		
		 function showMSG(msg){	  
             swal({   
                  title:'Dealer has been updated',
					showCancelButton: false,
					confirmButtonColor: "#2d3393",   
					confirmButtonText: "OK",   
					closeOnConfirm: false },
					function(isConfirm){
						if(isConfirm){
						location.reload();
						}
					});	
}		
	</script>
</body>
</html>
<%
	} catch (Exception e) {
		System.out.println("Errror....." + e);
		response.sendRedirect("login");
	}
%>