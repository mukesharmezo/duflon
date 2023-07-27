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
String baseServer = resource.getString("client.url");String title = resource.getString("app.title");
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
ul li { margin: 0 !important;}
.form-btn{width: 100% !important;}

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
		<h1>Family Member Details</h1>
		<div class="container-1100">
			<div class="profile-container">
				<%@include file="./header/profileMenu.jsp"%>

				<div class="profile-content">
                              <c:if test="${(partcipant.documents_status != 'final') && partcipant.status !='H'}">
				   <%if(role.equalsIgnoreCase("HRE")) { %>
					<form action="./savefamilydetails" method="post" class="form"
						id="testForm">
						<input type="hidden" name="accessKey" id="accessKey"
							value="${partcipant.accessKey}" />

						<div class="form-section">
							<div class="form-block">
								<h5>Full Name</h5>
								<input type="text" name="memberName"  placeholder="Full Name" id="memberName" value="" required />
							</div>
							<div class="form-block">
								<h5>Relationship</h5>
								<select name="relationship" id="relationship" required>
									<option value="">Select</option>
									<c:forEach items="${relationship}" var="relationship">
									<option value="${relationship.listDesc }">${relationship.listDesc }</option>
									</c:forEach>
								</select>
							</div>
							<div class="form-block">
								<div class="form-btn">
									<input class="btn blue-btn"  type="submit" value="Add"
										id="submit" />
								</div>
							</div>
						</div>
					</form>
                      <%} %>
                     </c:if>
					<div class="table-date">
						<table width="100%" border="0" cellpadding="0" cellspacing="0"
							id="data">
							<thead>
								<tr>
									<th><span><em>Sr. No.</em></span></th>
									<th data-head="Name"><span><img 	src="./img/filter-icn.svg" /></span></th>
									<th data-head="Relationship"><span><img src="./img/filter-icn.svg" /></span></th>
											<c:if test="${(partcipant.hiredStatus != 'Y') && partcipant.status !='H'}">
											   <%if(role.equalsIgnoreCase("HRE")) { %>
												<th data-head="Edit"><span></span></th>
												<th data-head="Delete"><span></span></th>
									<%} %>
									</c:if>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="family" items="${familyDetail}"
									varStatus="status">

									<tr>
										<td>${status.index + 1}</td>
										<td>${family.memberName}</td>
										<td>${family.relationship}</td>
										<c:if test="${(partcipant.hiredStatus != 'Y') && partcipant.status !='H'}">
										   <%if(role.equalsIgnoreCase("HRE")) { %>
										<td><a onclick="edit('${family.fid}','${family.memberName}','${family.relationship}')"><img	src="./img/edit-icn.svg" /></a></td>
										<td><a onclick="deletePop('${family.fid}')"><img src="./img/delete-icn.svg" /></a></td>
									   <%} %>
									   </c:if>
									</tr>
								</c:forEach>

							</tbody>
						</table>
					</div>
					<c:if test="${(partcipant.hiredStatus != 'Y' ) && partcipant.status !='H'}">
   <%if(role.equalsIgnoreCase("HRE")) { %>
					<div class="form-btn" style="position: relative; right: -10px;">
						 <a href="#"class="btn blue-btn" onclick="openEmargencyContact()">Next</a>
					</div>
                <%} %>
				  </c:if>
				</div>
			</div>
		</div>
	</div>
	<div class="edit-popup">
		<h3>Edit Details</h3>
		<form class="form-section" action="updateFamilyDetails" method="post"  >
			
				<div class="form-block">
					<input type="hidden" name="fid" id="fid" value="" placeholder="Name" />
					<h5>Name</h5>
					<input type="text" id="memnber" value="" placeholder="Name"  />
				</div>
				<div class="form-block">
					<h5>Relationship</h5>
					<select name="relationship" id="relationShip">
									<option value="">Select</option>
									<option value="Brother">Brother</option>
									<c:forEach items="${relationship}" var="relationship">
									<option value="${relationship.listDesc}" <c:if test="${family.relationship eq relationship.listDesc}"> selected</c:if>>${relationship.listDesc}</option>
									</c:forEach>
									
								</select>
				</div>
				<div class="form-button">
					<input type="button" ton class="cancel-btn" onclick="closePop(event)" value="Cancel">
					<input type="button"  class="submit-btn"
						onclick="submitEntry()" value="Submit">
				</div>
			
		</form>
	</div>
 <%if(role.equalsIgnoreCase("HRE")) { %>
	<div class="delete-popup">
		<p>Are you sure you want to delete?</p>
		<div class="form-button">
			
			<button class="cancel-btn outline-btn" onclick="closePop(event)">No</button>
			<button class="submit-btn"
				onclick="deleteEntry(event); deleteParticipant('fid');">Yes</button>
		</div>
	</div>
	<div class="blk-bg"></div>
	 <%} %>
	<input type="hidden" id="accesskey" value="${partcipant.accessKey}">
	<input type="hidden" id="fid_value" value="">

	<script>
      $(document).ready(function () {
        var profile = document.getElementById("profile");
		var family_member_details = document.getElementById("family_member_details");
		
		profile.className -= 'tab-btn tab_selected scroll_tab_first';
        family_member_details.className += 'tab-btn tab_selected scroll_tab_first';
        $('#tabs').scrollTabs();


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
      });
      
      
       function edit(fid,memberName,relationship) {  	  
  	  
  	   $("#fid").val(fid);
  	   $("#memnber").val(memberName);
  	   $('.edit-popup, .blk-bg').show();
  	   $("#relationShip").val(relationship);
 	   
  	   }  
       
    
       
     /*   function editPop(event) {
   	    $('.edit-popup, .blk-bg').show();
   	}
        */
     

    	function submitEntry(event) {
        	  var accesskey =$("#accesskey").val();
        	  var fid= $("#fid").val();
        	  var member= $("#memnber").val();
        	  var relationShip=$("#relationShip").val();
        	  if(member == "")
					{
						swal("Please enter name.");
						return;
					}
					
			if(relationShip == "")
			{
			  swal("Please select relationship.");
				return;
			}
        	 
        	 	$.ajax({
 			  type: "POST",
 			  url:  "updateFamily",
 			  data: "accesskey="+accesskey+"&fid="+fid+"&member="+member+"&relatonShip="+relationShip,
 			  success: function(data){
 				 window.location.reload();
 			  },
 			  error: function(errorThrown){
 				  alert("something Went Wrong");
 			  }
 		  }); 
    	    $('.edit-popup, .blk-bg').hide();
    	}

    	function deletePop(fid) {
    		  $('#fid_value').val(fid);  
      	  $('.delete-popup, .blk-bg').show(); 		
    	}
    	
    	function deleteEntry(event) {
    		var fid= $('#fid_value').val();  
    		$.ajax({
	 			  type: "GET",
	 			  url:  "deleteOneFamilyDetails",
	 			  data: "fid="+fid,
	 			  success: function(data){
	 				 window.location.reload();
	 			  },
	 			  error: function(errorThrown){
	 			  }
	 		  });
    	    $('.delete-popup, .blk-bg').hide();
    	}
    	
    	
    	function closePop(event) {
    	    $('.edit-popup, .delete-popup, .blk-bg').hide();
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