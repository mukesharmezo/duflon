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
String title = resource.getString("app.title");
String role="";
if(session.getAttribute("role") != null){
	role = session.getAttribute("role").toString().trim();
%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="icon" type="image/x-icon" href="<%=baseServer%>img/DuflonFavicon.png"/>
    <title><%=title %></title>
    <link rel="stylesheet" type="text/css" href="./css/common.css" />
    <link rel="stylesheet" type="text/css" href="./css/hiring-in-process.css" />
    <link rel="stylesheet" type="text/css" href="css/dashboard-filter.css">
    <link rel="stylesheet" type="text/css" href="./css/sweetalert.css"/>
    <link rel="stylesheet" type="text/css" href="./css/jquery.datatable.min.css"/>
    <link rel="stylesheet" type="text/css" href="./css/datatable.css">
    <link rel="stylesheet" type="text/css" href="./css/style.css" />
    <script src="./js/jquery-3.4.1.min.js"></script>
    <script type="text/javascript" src="./js/sweetalert.min.js"></script>
    <script src="./js/jquery.dataTables.min.js"></script>
	<script src="https://cdn.datatables.net/fixedcolumns/4.2.1/js/dataTables.fixedColumns.min.js"></script>
	<script src="./js/datatable.js"></script>
    <style>
		.dataTables_scrollBody {overflow-y: hidden !important;overflow-x: auto !important;}  
        .table-date table tr td {    padding-top: 10px !important;    padding-bottom: 10px !important;}
h1 {    text-align: inherit;}
.delete-popup {    width: 40%;    }
#customMaster, #customMasterEdit {      display: none;    }
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
        <h1>Master Data</h1>
        <div class="container-1100">
        <form class="form"	id="testForm">
						<div class="form-section">
							<div class="form-block">
								<h5>Master Data</h5>
								<input type="text" name="masterDescription"  placeholder="Master Data" id="masterDescription" value="" required />
							</div>
							<div class="form-block">
								<h5>Master List</h5>
								<select name="masterName" id="masterName" required>
									<option value="">Select</option>
									<c:forEach items="${uniqueMaster}" var="master">
									<option value="${master}">${master}</option>
									</c:forEach>
									<option value="Custom">Custom</option>
								</select>
							</div>
							<div class="form-block" id="customMaster">
								<h5>New Master</h5>
								<input type="text" name="masterNew"  placeholder="New Master" id="masterNew" value="" required />
							</div>
							<!-- <div class="form-block">
								<div class="form-btn">
									<input class="btn blue-btn"  type="submit" value="Add"
										id="submit" />
								</div>
							</div> -->
						</div>
						<div class="center">
					<button type="button" class="submit-btn" id=master-button>Add</button>
				</div>
					</form>
            <div class="table-date">
                <table id="data" cellspacing="0" cellpadding="0" border="0" class="display nowrap cell-border" width="50" style="width: 100% !important">
                    <thead>
                        <tr>
                           <th data-head="Sr. No." style="z-index: 1 !important;"><em>Sr. No.</em></th>
							<th data-head="Master Data" class="sorting" style="z-index: 1 !important;"><em>Master Data</em></th>
							<th data-head="Master Name" class="sorting"><em>Master Name</em></th>
							<th data-head="Edit" class="sorting"><em>Edit</em></th>
							<th data-head="Delete" class="sorting"><em>Delete</em></th>
                        </tr>
                    </thead>
                    <tbody>
								<c:forEach var="master" items="${masters}" varStatus="status">
									<tr>
										<td>${status.count}</td>
										<td>${master.masterDescription}</td>
										<td>${master.masterName}</td>
										<td><a onclick="edit('${master.id}','${master.masterDescription}','${master.masterName}')"><img	src="./img/edit-icn.svg" /></a></td>
										<td><a onclick="deletePop('${master.id}')"><img src="./img/delete-icn.svg" /></a></td>
									</tr>
								</c:forEach>
							</tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="edit-popup">
		<h3>Edit Details</h3>
		<form class="form-section" id=editForm>
			<input type="hidden" name="id" id="idEdit" />
			<div class="form-block">
				<h5>Master Data</h5>
				<input type="text" id="masterDescriptionEdit" value=""	name="masterDescription" />
			</div>
			<div class="form-block">
				<h5>Master List</h5>
				<select name="masterName" id="masterNameEdit">
					<option value="">Select</option>
					<c:forEach items="${uniqueMaster}" var="master">
					<option value="${master}">${master}</option>
					</c:forEach>
					<option value="Custom">Custom</option>
				</select>
			</div>
			<div class="form-block" id="customMasterEdit">
				<h5>New Master</h5>
				<input type="text" name="masterNew"  placeholder="New Master" id="masterNewEdit" value="" required />
			</div>
			<div class="form-button">
				<input type="button" ton class="cancel-btn" onclick="closePopup()" value="Cancel"> 
				<input	type="button" class="submit-btn" id="edit-submit" value="Submit">
			</div>
		</form>
	</div>
	<%
	if (role.equalsIgnoreCase("HOD") || role.equalsIgnoreCase("SA")) {
	%>
	<div class="delete-popup">
		<input type="hidden" id="id_value" value="">
		<p>Are you sure you want to delete?</p>
		<div class="form-button">
			<button class="cancel-btn outline-btn" onclick="closePopup()">No</button>
			<button class="submit-btn"
				onclick="deleteEntry(event); deleteParticipant('fid');">Yes</button>
		</div>
	</div>
	 <%} %>
 <div class="blk-bg"></div>
    <script src="./js/jquery.validate.js"></script>
	<script>
      $(document).ready(function () {
       
    	  $("#masterName, #masterNameEdit").change(function() {
    	        var selectedValue = $(this).val();
    	        var customDiv;
    	        if ($(this).attr('id') === 'masterName') {
    	            customDiv = $("#customMaster");
    	        } else {
    	            customDiv = $("#customMasterEdit");
    	        }
    	        if (selectedValue === "Custom") {
    	          customDiv.show();
    	        } else {
    	          customDiv.hide();
    	        }
    	      });
    	  
    	  function submitForm(formId, successMsg, errorMsg) {
    		    var formData = $('#' + formId).serialize();
    		    var masterName = $('#' + formId + ' select[name="masterName"]').val(); // Get the value of masterName field
    		    var masterDescription = $('#' + formId + ' input[name="masterDescription"]').val(); // Get the value of masterDescription field
    		    var masterNew = $('#' + formId + ' input[name="masterNew"]').val(); // Get the value of masterNew field
    		    
    		    if (masterDescription === '') {
    		        swal('Please enter master data.');
    		        return;
    		    }
    		    if (masterName === '') {
    		        swal('Please select master name.');
    		        return;
    		    }
    		    if (masterName === 'Custom' && masterNew === '') {
    		        swal('Please enter new master.');
    		        return;
    		    }
    		    
    		    $.ajax({
    		        type: 'POST',
    		        url: 'saveMasterData',
    		        data: formData,
    		        success: function(data) {
    		            //window.location.reload();
    		            showMSG(successMsg);
    		            $('#' + formId)[0].reset();
    		        },
    		        error: function() {
    		        	showMSG(errorMsg);
    		        }
    		    });
    		}

    		$('#master-button').click(function() {
    		    submitForm(
    		        'testForm',
    		        'New master data has been added successfully.',
    		        'Error while adding new master data.'
    		    );
    		});
    		$("#edit-submit").click(function() {
    			submitForm(
    			        'editForm',
    			        'Master data updated successfully.',
    			        'Error updating the master data.'
    			    );
    		});

      });  // Doc ready
      function showMSG(msg){
		  swal({   
				  title: msg,     
				  showCancelButton: false,
				  confirmButtonColor: "#DC3545",   
				  confirmButtonText: "OK",   
				  closeOnConfirm: true },
				  function(isConfirm){
					  window.location.reload();
					  return false; 
				}); 
	 }
	
      function closePopup(){
    	  $('.edit-popup, .delete-popup, .blk-bg').hide(); 
    	  $('#customMasterEdit').hide();
      }
      
       function edit(id,masterDescription,masterName) {  	  
    	 $("#idEdit").val(id);
      	 $("#masterDescriptionEdit").val(masterDescription);
      	 $("#masterNameEdit").val(masterName);
  	   $('.edit-popup, .blk-bg').show();
  	   }

    	function deletePop(id) {
    		  $('#id_value').val(id);  
      	  $('.delete-popup, .blk-bg').show(); 		
    	}
    	function deleteEntry(event) {
    		 $('.delete-popup, .blk-bg').hide();
    		var id= $('#id_value').val();  
    		$.ajax({
	 			  type: "GET",
	 			  url:  "deleteMasterData",
	 			  data: "id="+id,
	 			  success: function(data){
	 				 showMSG(data);
	 				 //window.location.reload();
	 			  },
	 			  error: function(errorThrown){
	 				 showMSG('Error in delete process.');
	 			  }
	 		  });
    	}
    </script>
  </body>
</html>
<%}else{
	 response.sendRedirect("login");
}
 }catch(Exception e)
    {
    	 System.out.println("Errror....."+e);
    	  response.sendRedirect("login");
    }%>
