<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import = "java.util.ResourceBundle" %>
<%
   try
    {
		
		ResourceBundle resource = ResourceBundle.getBundle("application");
    		  String baseServer = resource.getString("client.url");
   /*   String userid=(String)session.getAttribute("userId");
	 String clientName = (String)session.getAttribute("clientName"); 
	 String roleId = (String)session.getAttribute("userType");   	
    	if(userid.length()>0 )
    	{   	 */	
    %>

<!DOCTYPE html>
<html>
<head>
 <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <link rel="icon" type="image/x-icon" href="<%=baseServer%>img/iRecruit-favicon.ico"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>iRecruit</title>
    <link rel="stylesheet" type="text/css" href="./css/common.css" />
    <link rel="stylesheet" type="text/css" href="./css/hiring-new.css" />
	<link rel="stylesheet" type="text/css" href="./css/sweetalert.css"/>
    <script type="text/javascript" src="./js/sweetalert.min.js"></script>
	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.12.1/css/jquery.dataTables.min.css">
    <link rel="stylesheet" type="text/css" href="./css/datatable.css">
	
    <script src="./js/jquery-3.4.1.min.js"></script>
      <script src="./js/jquery.dataTables.min.js"></script>
 <script src="https://cdn.datatables.net/fixedcolumns/4.2.1/js/dataTables.fixedColumns.min.js"></script> 
	<script src="./js/datatable.js"></script>

 <style>
        .left-panel > ul > li:nth-child(1) > a, .left-panel > ul > li:nth-child(1) > ul > li:nth-child(1) > a{opacity: 1;}
        .left-panel > ul > li:nth-child(1) > ul > li:nth-child(1) > a::after{content: ''; position: absolute; right: 0; top: 50%; transform: translate(0, -50%); border-right: 6px solid #fff; border-top: 6px solid transparent; border-bottom: 6px solid transparent;}
		.th.sorting.sorting_asc.dtfc-fixed-left{z-index:1 !important;}
		.table.dataTable thead>tr>th.sorting, table.dataTable thead>tr>th.sorting_asc, table.dataTable thead>tr>th.sorting_desc, table.dataTable thead>tr>th.sorting_asc_disabled, table.dataTable thead>tr>th.sorting_desc_disabled, table.dataTable thead>tr>td.sorting, table.dataTable thead>tr>td.sorting_asc, table.dataTable thead>tr>td.sorting_desc, table.dataTable thead>tr>td.sorting_asc_disabled, table.dataTable thead>tr>td.sorting_desc_disabled{z-index: 1 !important;}
		.sorting .dtfc-fixed-left{z-index: 1 !important;}
		.th.sorting.dtfc-fixed-left{z-index: 1 !important;}
		.cancel-btn{color: #2d3393 !important;background-color:#fff !important;}
		#data_paginate a:hover{background-color: #2d3393 !important;}
		.dataTables_scrollBody {overflow-y: hidden !important;overflow-x: auto !important;}  
		.dataTables_wrapper .dataTables_filter input{padding: 10px 0px 10px 0px !important;}
		.dataTables_wrapper .dataTables_scroll div.dataTables_scrollBody>table>tbody>tr>td {vertical-align: middle;z-index: 1;}
		@media (max-width:1024px){
			.communications-popup{width: 850px !important;}}
		@media (max-width:820px){
			.table-date {margin-top: 55px !important;}
			.communications-popup{width: 800px !important;}}
		@media (max-width: 768px){
			.table-date {margin-top: 50px !important;}
  			.communications-popup{width: 750px !important;}}
  
  		@media (max-width: 426px){
			.communications-popup{width: 415px !important;} 
			.sweet-alert{width: 80% !important; left:65% !important;}
			.add-remove-columns{left: 0 !important;top: -45px !important;}
  			/* .table-date {top: 50px !important;} */
  			}
		@media (max-width: 400px){
			.communications-popup{width: 350px !important;} 
			.sweet-alert{width: 80% !important; left:70% !important;}
  			.communications-popup .form-section .form-block{width: calc(50% - 20px) !important;}
		}
  
	@media (max-width: 376px){
			.communications-popup{width: 300px !important;} 
			.add-remove-columns{top:-12px !important;left: 0;}
			.table-date{top:-30px !important;}
			.sweet-alert{width: 80% !important; left:73% !important;}

		}
		
		@media (max-width: 320px){
			.communications-popup{width: 300px !important;} 
			.table-date{top:-35px !important;}
			.add-remove-columns{top:-10px !important;left: 0;}
			.sweet-alert{width: 80% !important; left:85% !important;}
			.gray-btn{margin-left: 0px !important;}
			
	}

.communications-popup1{padding: 30px; box-sizing: border-box; background-color: #fff; border-radius: 15px; width: 580px; position: fixed; top: 50%; left: 50%; z-index: 99999; transform: translate(-50%, -50%); display: none;}
.communications-popup1 h3{margin: 0 0 30px; text-align: center; font-weight: 500; font-size: 24px; line-height: 32px; color: #000;}
.communications-popup1 .form-section{display: flex; flex-wrap: wrap; margin: 0 -10px;}
.communications-popup1 .form-section .form-block{width: calc(38.33% - 20px); margin: 0 10px 40px;margin-left: 50px;}
.communications-popup1 .form-section .form-block input[type="text"], .communications-popup1 .form-section .form-block input[type="email"], .communications-popup1 .form-section .form-block input[type="number"], .communications-popup1 .form-section .form-block select{width: 100%; box-sizing: border-box; background-color: #F7F7F7; border: 1px solid #D0D0D0; border-radius: 7px; padding: 11px 15px; font-weight: 400; font-size: 13px; line-height: 18px; color: #333;}
.form-button{display: flex; justify-content: center; align-items: center; margin-top: 30px; width: 100%;}

   </style>

<script> 
	function openPopup(location,map,parent,outlet_code)
{
	 $("#location").val(location);
	 $("#map").val(map);
	 $("#parent").val(parent);
	 $("#outlet_code").val(outlet_code);
	 
	 $('.communications-popup, .blk-bg').show();	
	
}

function cancle(){
	 $('#reSendMail').prop('disabled', false);
	 $('#reSendMail').val('Submit');
     $('.communications-popup, .blk-bg').hide();		
}

  function updateDealer(){	  
	   var location   =   $("#location").val();
	   var map        =   $("#map").val();
	   var parent     =	  $("#parent").val();
	   var outletCode =   $("#outlet_code").val();		 
	    $.ajax({
	         url: 'updateDealerrr',
	         type:'post',
	         data:'location='+location+'&map='+map+'&parent='+parent+'&outletCode='+outletCode,
	         success:function(res){
	        	 if(res =='success'){
					  swal({   
	 					title: "Dealer has been updated.",     
	 					showCancelButton: false,
	 					confirmButtonColor: "#2d3393",   
	 					confirmButtonText: "OK",   
	 					closeOnConfirm: false },
	 					function(isConfirm){
	 						window.location.reload();
	 					});	
	        	 }
	    	  },
	          error:function(ress){
	        	  alert(ress);
				//window.close();
	    	  }
			}); 
	  
  }
  
   function updateDealerPro(){	   
	   swal({   
			title: "Do you want update dealer",     
			showCancelButton: true,
			confirmButtonColor: "#2d3393",   
			confirmButtonText: "OK",   
			closeOnConfirm: false },
			function(isConfirm){
				if(isConfirm){
					updateDealer();
				}else{
					return false;
				}
			});
   }
   
   function updateMSPINPopup(mspin,outlet_code)
   {
   	 $("#old_mspin").val(mspin);
   	 $("#outlet_code_mspin").val(outlet_code);
   	
   	 $('#mspin_popup, .blk-bg').show();	
   	
   }
   
   //
   /*  function updateMSPINPro(){	  
	  
	   var mspin     =	  $("#new_mspin").val();
	   var outletCode =   $("#outlet_code_mspin").val();
	   if(mspin == ""){	   
		   showMSG("Please enter MSPIN");
		   return false;
	   }
	   swal({   
			title: "Do you want update dealer",     
			showCancelButton: true,
			confirmButtonColor: "#2d3393",   
			confirmButtonText: "OK",   
			closeOnConfirm: true },
			function(isConfirm){
				if(isConfirm){
	    $.ajax({
	         url: 'updateOutletMSPIN',
	         type:'post',
	         data:'outletCode='+outletCode+'&mspin='+mspin,
	         success:function(res){
	        	 $('#mspin_popup, .blk-bg').hide();	
	        	 if(res =='success'){					   
	 					 //alert("Dealer has been updated.");  
	 					 window.location.reload();
	        	 }
	        	 if(res =='error'){					   
	 					alert("Details not updated");     	 					
	        	 }
	        	 
	    	  },
	          error:function(ress){
	        	  alert(ress);
				//window.close();
	    	  }
			}); 
	    
				}else{
					return false;
				}
			});
	  
  }*/
  
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
  
  function showMSGRes(msg){
		 
	  swal({   
			  title: msg,     
			  showCancelButton: false,
			  confirmButtonColor: "#2D3392",   
			  confirmButtonText: "OK",   
			  closeOnConfirm: true },
			  function(isConfirm){			  
				  window.location.reload();
			}); 
 }


        function openMSPIN(outlet_code)
  {
  	 $("#outlet_code1").val(outlet_code); 	 
  	 $('#mspin_update').show();	
  	 $('.blk-bg').show();	
  	
  }
  
  function cancle1(){
	  $('#mspin_update').hide();	
	  	 $('.blk-bg').hide();	
	}
  
  
  function updateMSPINPro(){	  
	  
	   var mspin     =	  $("#MSPIN1").val();
	   var outletCode =   $("#outlet_code1").val();
	   if(mspin == ""){	   
		   showMSG("Please enter MSPIN");
		   return false;
	   }
	   swal({   
			title: "Do you want update MSPIN",     
			showCancelButton: true,
			confirmButtonColor: "#2d3393",   
			confirmButtonText: "OK",   
			closeOnConfirm: true },
			function(isConfirm){
				if(isConfirm){
	    $.ajax({
	         url: 'updatemspin',
	         type:'post',
	         data:'outletCode='+outletCode+'&mspin='+mspin,
	         success:function(res){
	        	 $('#mspin_update, .blk-bg').hide();	
	        	 if(res =='1'){					   
	 					alert("Please add MSPIN.");  
	 					 window.location.reload();
	        	 }
	        	 if(res =='2'){					   
	 					alert("Details not updated");     	 					
	        	 }
	        	 
	        	 if(res =='0'){					   
	 					alert("Details updated"); 
                                                window.location.reload();    	 					
	        	 }
	        	 
	    	  },
	          error:function(ress){
	        	  alert(ress);
				//window.close();
	    	  }
			}); 
	    
				}else{
					return false;
				}
			});
	  
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
        <h1>Dealer List </h1>
        <div class="container-1100">
            

            <div class="table-date">
			
			 
                
                <table  id="data" cellspacing="0" cellpadding="0" border="0" class="stripe display nowrap cell-border" width="50">
                   <thead>
                            <tr>
                                <th data-head="Sr. No."><em >Sr.No.</em></th>
			        <th data-head="MSPIN" class="sorting" style="z-index: 1 !important;"><em >MSPIN</em></th>                                                          
				<th data-head="Outlet Code" ><em>Outlet Code</em></th>
                                <th data-head="Name" class="sorting"><em>Name</em></th>
				<th data-head="Outlet Name" class="sorting"><em>Outlet Name</em></th>
                                <th data-head="Region" class="sorting"><em>Region</em></th>
                                <th data-head="City" class="sorting"><em>City</em></th>
                                <th data-head="State" class="sorting"><em>State</em></th>
                                <th data-head="Location" class="sorting"><em>Location</em></th>
                                <th data-head="Dealer Map Code" class="sorting"><em>Dealer Map Code</em></th>
                                <th data-head="Parent Dealer Group" class="sorting"><em>Parent Dealer Group</em></th>
                                <th data-head="Update Dealer" class="sorting"><em>Update Dealer</em></th>
                                <th data-head="Update MSPIN" class="sorting"><em>Update MSPIN</em></th>
                            </tr>
                        </thead>
                    <tbody>
                    <%int p=1; %>
                    <c:forEach items="${dealerList}" var="dealer">
                        <tr>
                            <td><%=p %></td>
                            <td>${dealer.mspin}</td>
                           <td>${dealer.outletcode}</td>
			   <td>${dealer.name}</td>						
			   <td>${dealer.outletName}</td>
			   <td>${dealer.region}</td>
                            <td>${dealer.city}</td>
                            <td>${dealer.state}</td>
                            <td>${dealer.location}</td>
                            <td>${dealer.mapeCode}</td>                               
                            <td>${dealer.parentDealer }</td>
                            <td>                         
                               <input type="button" class="btn btn-sm btn-dark" value="Update" onclick="openPopup('${dealer.location}','${dealer.mapeCode}','${dealer.parentDealer }','${dealer.outletcode}')" />                            
                            </td>
                            <td> <input type="button" class="btn btn-sm btn-dark" value="Update" onclick="openMSPIN('${dealer.outletcode}')" />  </td> 
                           
                        </tr>
                       <%p++; %>
                       </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

   <div class="communications-popup">
        <h3>Update Dealer</h3>
        <form class="form-section" action="">
            <div class="form-block">
               Location <span style="color:red;"></span><input type="text" placeholder="Location"  id="location"  maxlength="10" />
            </div>
            <div class="form-block">
                Dealer Map Code <input type="text" placeholder="Dealer Map Code" id="map"  maxlength="10" />
            </div>
            
            
            <div class="form-block">
			Parent Dealer Group <span style="color:red;"></span>
                <select id="parent" onchange="showDataScienceProfile()">
                    <option value="">Select</option>
                      <c:forEach items="${parent}" var="parent">
                    <option value="${parent.parentDealerCode}">${parent.parentDealerCode}</option>
                   
                    </c:forEach>
                </select>
            </div>   
            <div class="form-button">
                <input type="button" class="cancel-btn" onclick="cancle()" value="Cancel">
                <input type="button" class="submit-btn" onclick="updateDealerPro()" value="Update" id="update">
              
                <input type="hidden"  value="" id="outlet_code">
            </div>
        </form>
    </div>

  
  <div class="communications-popup1" id="mspin_update">
        <h3>Update MSPIN with outlet</h3>
        <form class="form-section" action="">
         <div class="form-block">
                Outlet Code <input type="text" placeholder="Outlet Code" id="outlet_code1" readonly="readonly" maxlength="10" />
            </div> 
            <div class="form-block">
               MSPIN <span style="color:red;"></span><input type="text" placeholder="MSPIN"  id="MSPIN1"  maxlength="10" />
            </div>
                   
            <div class="form-button">
                <input type="button" class="cancel-btn" onclick="cancle1()" value="Cancel">
                <input type="button" class="submit-btn" onclick="updateMSPINPro()" value="Update" id="updateMSPIN">                 
            </div>
        </form>
    </div>   

 <%-- <div class="communications-popup1" id="mspin_update">
        <h3>Update MSPIN with outlet</h3>
        <form class="form-section" action="">
         <div class="form-block">
                Outlet Code <input type="text" placeholder="Outlet Code" id="outlet_code1" readonly="readonly" maxlength="10" />
            </div> 
            <div class="form-block">
               MSPIN <span style="color:red;"></span><input type="text" placeholder="MSPIN"  id="MSPIN1"  maxlength="10" />
            </div>
                   
            <div class="form-button">
                <input type="button" class="cancel-btn" onclick="cancle1()" value="Cancel">
                <input type="button" class="submit-btn" onclick="updateMSPINPro()" value="Update" id="updateMSPIN">                 
            </div>
        </form>
    </div>   --%> 
    

    <div class="blk-bg"></div>
	<!--<script src="./js/datatable.js"></script> -->
  
</body>
</html>

<%
    	/* }else
    	{
    		 response.sendRedirect("login");
        }	 */
    	
     }catch(Exception e)
    {
    	 System.out.println("Errror....."+e);
    	  response.sendRedirect("login");
    }
   %>