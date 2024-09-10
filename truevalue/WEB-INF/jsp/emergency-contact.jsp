<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="com.msil.irecruit.Entities.ParticipantRegistration"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import = "java.util.ResourceBundle" %>
<%
try
    {
	ResourceBundle resource = ResourceBundle.getBundle("application");
String baseServer = resource.getString("client.url");
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
	<link rel="icon" type="image/x-icon" href="<%=baseServer%>img/iRecruit-favicon.ico"/>
 <title>iRecruit</title>
    <link rel="stylesheet" type="text/css" href="./css/common.css" />
    <link rel="stylesheet" type="text/css" href="./css/profile.css" />
    <link rel="stylesheet" href="./css/scrolltabs.css">
    <link rel="stylesheet" type="text/css" href="./css/emergency-contact.css" />
    <link rel="stylesheet" type="text/css" href="./css/style.css" />
<link rel="stylesheet" type="text/css" href="./css/sweetalert.css"/>
 <script type="text/javascript" src="./js/sweetalert.min.js"></script>
    
    <style>
    .form-btn{width: 100% !important;}      
	   ul li{margin: 0px !important;}
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
        <h1>Emergency Contact Details</h1>
        <div class="container-1100">
            <div class="profile-container">
               <%@include file="./header/profileMenu.jsp"%>

              <div class="profile-content">  
			  <c:if test="${(emergencyContact.documents_status != 'final' || emergencyContact.fsdmApprovalStatus == '1') && emergencyContact.status != 'H'}">
                <%if(role.equalsIgnoreCase("DL")) { %>
                <form action="./saveEmergencyContact" method = "post" class="form" id = "testForm">
                <input type = "hidden" name = "accessKey" id = "accessKey" value = "${emergencyContact.accessKey}" /> 
                  <div class="form-section">
                    <div class="form-block">
                      <h5>Full Name</h5>
                      <input type="text" placeholder="Full Name" name = "cname"  id="cname"/>
                    </div>
                    <div class="form-block">
                      <h5>Contact Number</h5>
                      <input type="text" name="contactNo" placeholder="Contact Number" id="contactNo"  maxlength="10" onchange="getMobile()" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" />                 
				   </div>
                    <div class="form-block">
                      <div class="form-btn">
                         <!-- <input class="btn blue-btn" type = "submit" value = "Add" id = "submit" /> -->
						  <input class="btn blue-btn" type="submit" value="Add" id="submitbtn" />
                       
                      </div>
                    </div>
                  </div>
                </form>
                  <%} %>
				  </c:if>
                <div class="table-date">
                <form action="">
                  <table width="100%" border="0" cellpadding="0" cellspacing="0" id="data">
                      <thead>
                          <tr>
                              <th><span><em>Sr. No.</em></span></th>
                              <th data-head="Name"><span><img src="./img/filter-icn.svg" /></span></th>
                              <th data-head="Contact Number"><span><img src="./img/filter-icn.svg" /></span></th>
							   <c:if test="${(emergencyContact.documents_status != 'final' || emergencyContact.fsdmApprovalStatus == '1') && emergencyContact.status != 'H'}">
                                <%if(role.equalsIgnoreCase("DL")) { %>
                              <th></th>
                              <th></th>
                              <%} %>
							    </c:if>
                          </tr>
                      </thead>
                      <tbody>
                       <c:forEach var="emcy" items="${emergency}" varStatus="status">

                          <tr>
                              <td>${status.index + 1}</td>
                              <td>${emcy.cname}</td>
                              <td>${emcy.contactNo}</td>
							    <c:if test="${(emergencyContact.documents_status != 'final' || emergencyContact.fsdmApprovalStatus == '1') && emergencyContact.status != 'H'}">
                                 <%if(role.equalsIgnoreCase("DL")) { %>
                               <td><a onclick="editPop('${emcy.id}','${emcy.cname}','${emcy.contactNo}')"><img src="./img/edit-icn.svg" /></a></td>
                              <td><a onclick="deletePop('${emcy.id}')"><img src="./img/delete-icn.svg" /></a></td>
                              <%} %>
							     </c:if>
                          </tr>
                          </c:forEach>
                      </tbody>
                  </table>
                  </form>
                </div>
				  <c:if test="${(emergencyContact.documents_status != 'final' || emergencyContact.fsdmApprovalStatus == '1') && emergencyContact.status != 'H'}">
                 <%if(role.equalsIgnoreCase("DL")) { %>
                <div class="form-btn" style="position: relative; right: -10px;">
                  <a href="#" class="btn blue-btn" onclick="openAssessmentScore()">Next</a>
              </div>
               <%} %>
			      </c:if>
              </div>
    </div>
    	</div>
    </div>
    
    
    <div class="edit-popup">
      <h3>Edit Details</h3>
      <form class="form-section" action="updateEmergencyContact" method="post">
        <div class="form-block">
          <h5>Name</h5>
          <input type="text" value=""  id="name"  placeholder="Name" />
        </div>
        <div class="form-block">
          <h5>Contact Number</h5>
          <input type="text" value=""  placeholder="Contact Number"  id="mobile"  maxlength="12" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/>
        </div>
          <div class="form-button">
              <input type="hidden" value="" id="emgId"/>
              <input type="button" class="cancel-btn" onclick="closePop(event)" value="Cancel" />
              <input type="button" class="submit-btn" onclick="submitEntry(event)" value="Submit" />
          </div>
      </form>
  </div>

    <div class="delete-popup">
      <p>Are you sure to delete it?</p>
      <div class="form-button">
          <button class="cancel-btn outline-btn" onclick="closePop(event)">No</button>
          <input type="button" class="submit-btn" onclick="deleteEntry(event)" value="Yes">

      </div>
  </div>
  <div class="blk-bg"></div>
    <input type="hidden" id="accesskey" value="${emergencyContact.accessKey}">
	<input type="hidden" id="mobile_primery" value="${emergencyContact.mobile}">
    <input type="hidden" id="emgId" value="">
    <script src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/jquery.validate.min.js"></script>
     <script type="text/javascript" src="./js/emergency.js"></script>
    <script>
      $(document).ready(function () {
        $('#tabs').scrollTabs();
		var profile = document.getElementById("profile");
		var emergency_contact = document.getElementById("emergency_contact");
		
		profile.className -= 'tab-btn tab_selected scroll_tab_first';
        emergency_contact.className += 'tab-btn tab_selected scroll_tab_first';

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
      
      
      function editPop(id,name,mobile) {
    	    $("#emgId").val(id);
    	    $("#name").val(name);
    	    $("#mobile").val(mobile);
    	    $('.edit-popup, .blk-bg').show();
    	}

    	/* function submitEntry(event) {
    	    $('.edit-popup, .blk-bg').hide();
    	}
 */
    	function deletePop(id) {
    		
    		$("#emgId").val(id);
    	    $('.delete-popup, .blk-bg').show();
    	}
    	function deleteEntry(event) {
    	    $('.delete-popup, .blk-bg').hide();
    	}
    	function closePop(event) {
    	    $('.edit-popup, .delete-popup, .blk-bg').hide();
    	}
    	
    	
    	function submitEntry(event) {	
      	  var accesskey =$("#accesskey").val();
      	  var id= $("#emgId").val();
      	  var name= $("#name").val();
      	  var mobile=$("#mobile").val();
      	 	$.ajax({
			  type: "POST",
			  url:  "updateEmergency",
			  data: "accessKey="+accesskey+"&id="+id+"&name="+name+"&mobile="+mobile,
			  success: function(data){
				  $('.edit-popup, .blk-bg').hide();
				 window.location.reload();
			  },
			  error: function(errorThrown){
				  alert("something Went Wrong");
			  }
		  }); 
  	    $('.edit-popup, .blk-bg').hide();
  	}

  	
  	
  	function deleteEntry(event) {
  		var id= $("#emgId").val(); 
		var accesskey = $("#accesskey").val();
  		$.ajax({
	 			  type: "Post",
	 			  url:  "deleteEmergency",
	 			  data: "id="+id+"&accesskey="+accesskey,
	 			  success: function(data){
	 				 window.location.reload();
	 			  },
	 			  error: function(errorThrown){
	 			  }
	 		  });
  	    $('.delete-popup, .blk-bg').hide();
  	}
	
	 function getMobile(){
		
		 var contactNo=   $("#contactNo").val();
		 var mobile_primery = $("#mobile_primery").val();
		 if(contactNo == mobile_primery){
			showMSG("Emergency contact number should not be same as primary") ;
			$("#contactNo").val("");
		 }
		
	   }
	   
	   function showMSG(msg){
		 
		  swal({   
				  title: msg,     
				  showCancelButton: false,
				  confirmButtonColor: "#2D3392",   
				  confirmButtonText: "OK",   
				  closeOnConfirm: true },
				  function(isConfirm){			  
					  return false; 
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
    }
%>