<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="com.armezo.duflon.Entities.ParticipantRegistration"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
<link rel="stylesheet" type="text/css" href="./css/profile.css" />
<link rel="stylesheet" type="text/css" href="./css/sweetalert.css"/>
    <script type="text/javascript" src="./js/sweetalert.min.js"></script>
<link rel="stylesheet" href="./css/scrolltabs.css">
<link rel="stylesheet" type="text/css"	href="./css/family-member-details.css" />
<link rel="stylesheet" type="text/css" href="./css/style.css" />

<style>
.center {	display: flex;	justify-content: center;	margin-top: 20px;}
ul li { margin: 0 !important;}
.form-btn{width: 100% !important;}
#customMaster, #customMasterEdit {
      display: none;
    }
</style>

<script src="./js/jquery-3.4.1.min.js"></script>
<script src="./js/jquery.dataTables.min.js"></script>
<script src="./js/jquery.scrolltabs.js"></script>
</head>
<body>
	<div class="left-panel-include">
	<%@include file="./header/left-panel.jsp"%>
	</div>
	<div class="user-panel-include">
	<%@include file="./header/user-panel.jsp"%>
	</div>

	<div class="right-section">
		<h1>Upload Master Data</h1>
		<div class="container-1100">
			<div class="profile-container">
				<%-- <%@include file="./header/profileMenu.jsp"%> --%>
				<div class="profile-content">
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
						<table width="100%" border="0" cellpadding="0" cellspacing="0"
							id="data">
							<thead>
								<tr>
									<th><span><em>Sr. No.</em></span></th>
									<th data-head="Master Data"><span><img src="./img/filter-icn.svg" /></span></th>
									<th data-head="Master Name"><span><img 	src="./img/filter-icn.svg" /></span></th>
									<th data-head="Edit"><span></span></th>
									<th data-head="Delete"><span></span></th>
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
		</div>
	</div>
	<div class="edit-popup">
		<h3>Edit Details</h3>
		<%-- <form class="form-section" action="updateFamilyDetails" method="post"  > --%>
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
	<div class="hold-popup">
        <p></p>
        <div class="form-button">
            <button class="submit-btn" onclick="closePopup()">Ok</button>
        </div>
    </div>
	<div class="blk-bg"></div>
	 <%} %>
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
    		            $('.hold-popup, .blk-bg').show();
    		            var para = $('.hold-popup p');
    		            para.text(successMsg);
    		            $('#' + formId)[0].reset();
    		            window.location.reload();
    		        },
    		        error: function() {
    		            $('.hold-popup, .blk-bg').show();
    		            var para = $('.hold-popup p');
    		            para.text(errorMsg);
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

        var table = $('#data').DataTable({
                "orderCellsTop": true,
                "responsive": true,
                autoWidth: false
            });
            $('#data thead tr')
                .clone(true)
                .find('th')
                .removeClass('sorting_asc sorting_asc sorting')
                .off('click')
                .end()
                .appendTo('#data thead');

            $('#data thead tr:eq(1) th').each(function (i) {
                var title = $(this).data('head');
                if(title){
                    $(this).html('<input type="text" placeholder="' + title + '" />');
                } else{
                    $(this).html('');
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
            
            
      });  // Doc ready
      
      function closePopup(){
    	  $('.hold-popup, .edit-popup, .delete-popup, .blk-bg').hide(); 
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
	 				 window.location.reload();
 		            var para = $('.hold-popup p');
 		            para.text(data);
	 				 $('.hold-popup, .blk-bg').show();
	 			  },
	 			  error: function(errorThrown){
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