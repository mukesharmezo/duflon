
<%
String log="",empCode="",name="",city="",state="",region="",roleType="",email="",hreName="";
if(session.getAttribute("lastLogin") != null){
	log = session.getAttribute("lastLogin").toString().trim();
}
if(session.getAttribute("empCode") != null){
	empCode = session.getAttribute("empCode").toString().trim();	
}
if(session.getAttribute("name") != null){
	name = session.getAttribute("name").toString().trim();	
}
if(session.getAttribute("city") != null){
	city = session.getAttribute("city").toString().trim();	
}
if(session.getAttribute("state") != null){
	state = session.getAttribute("state").toString().trim();	
}

if(session.getAttribute("region") != null){
	region = session.getAttribute("region").toString().trim();	
}
if(session.getAttribute("role") != null){
	roleType = session.getAttribute("role").toString().trim();
}
if(session.getAttribute("email") != null){
	email = session.getAttribute("email").toString().trim();	
}
if(session.getAttribute("hreName") != null){
	hreName = session.getAttribute("hreName").toString().trim();	
}
%>
<link rel="stylesheet" type="text/css" href="./includes/user-panel/user-panel.css" />
<link rel="stylesheet" type="text/css" href="./includes/user-panel/change-password.css" />
<link rel="stylesheet" type="text/css" href="./css/sweetalert.css"/>
<script type="text/javascript" src="./js/sweetalert.min.js"></script>

<div class="user-panel">
    <img src="./img/userimg.svg" />
   <span><%=name%>
	<%if(roleType.equalsIgnoreCase("HRE")) {%>
	<br><%-- <%=hreName %>, --%>
	<%}%>
	 <%=empCode%></span>
    <ul>
        <li>
           <em>Last Login Date: <%=log %></em>
        </li>
		
        <li>
            <em>Region: <%=region%></em>
        </li>
		<%if(roleType.equalsIgnoreCase("HRE")) {%>
        <li>
             <em>State: <%=state%></em>
        </li>
		<%}%>
        <li>
            <a href="#" onclick="showChangePassword()">Change Password</a>
        </li>
		<li>
            <a href="#" onclick="showChangeEmail()">Change official email ID</a>
        </li>
        <li>
            <a href="#" onclick="showLogOutPopup()">Logout</a>
        </li>
    </ul>
</div>
<style>
	.submit-btn{padding:11px 5px !important; width: 120px;}
	.cancel-btn{background-color:#fff !important; color: #DC3545 !important; border: 1px solid #DC3545 !important; width: 120px;}
	.form-button{justify-content: center !important;}
</style>
 <div class="change-password-popup">
        <h2>Change Password</h2>
        <div class="form-block">
           <input type="password" placeholder="Old Password" id="oldPassword" />
        </div>
        <div class="form-block">
            <input type="password" placeholder="New Password" id="newPassword"/>
        </div>
        <div class="form-block">
            <input type="password" placeholder="Confirm New Password" id="confirmPassword"/>
        </div>
        <div class="error-chage-pass" id="errorPass"></div>
        <div class="form-button">
            <input type="button" class="cancel-btn" onclick="hideChangePassword()" value="Cancel" />
            <input type="button" class="submit-btn" onclick="changePassword()" value="Change Password">
        </div>
    </div>
    
	<div class="logout-popup">
        	<p>Are you sure you want to Logout?</p>
        	<div class="form-button">
            		<button class="cancel-btn outline-btn" onclick="hideLogoutPopup()">No</button>
            		<button class="submit-btn" onclick="logout()">Yes</button>

        	</div>
    	</div>
    <div class="change-email-popup">
        <h2>Change official email ID</h2>
        <div class="form-block">
            <input type="email" placeholder="Old Email" value="<%=email %>" readonly id="oldEmail"/>
        </div>
        <div class="form-block">
            <input type="email" placeholder="New Email" id="newEmail"/>
        </div>
        <div class="error-chage-email" id="errorEmail"></div>
        <div class="form-button">
            <input type="button" class="cancel-btn" value="Cancel" onclick="hideChangeEmail()"  />
            <input type="button" class="submit-btn" value="Update" onclick="changeEmail()"/>
        </div>
    </div>
   <input type="hidden" value="<%=empCode %>" id="empCode" />
<script>
 function logout(){
	 
	 window.history.forward();
	 if(parent.window.history.forward(1) != null)
		 parent.window.history.forward(1);
	 
	   // document.forms[0].action="logout";
		//document.forms[0].method="post";
		//document.forms[0].submit(); 

          var form = document.createElement("form");
         	
		 form.method="post";
		 form.action="logout";
		 document.body.appendChild(form);
		 form.submit();		
 }

 function showChangePassword(){
	 $('#oldPassword').val('');
	 $('#newPassword').val('');
	 $('#confirmPassword').val('');
	 $('.change-password-popup, .blk-bg').show();
     return false;
 }
 
 function hideChangePassword(){
	 $('.change-password-popup, .blk-bg').hide();
     return false;
 }
 
 function showChangeEmail(){
	 $('#newEmail').val('');
	 $('.change-email-popup, .blk-bg').show();
     return false;
 }
 
 function hideChangeEmail(){
	// document.getElementById("oldEmail").value = "";
	    document.getElementById("newEmail").value = "";
	    document.getElementById("errorEmail").textContent = "";
	 $('.change-email-popup, .blk-bg').hide(); 
     return false;
 }

 function showLogOutPopup()
	{
	    $('.logout-popup, .blk-bg').show();
	    return false;
	}
 function hideLogoutPopup(){
	   $('.logout-popup, .blk-bg').hide();
	    $('.error-chage-pass').show();
	   return false;
  }
 

 function changePassword(){
	    var oldPassword     = $('#oldPassword').val();
		var newPassword     = $('#newPassword').val();
		var confirmPassword =  $('#confirmPassword').val();
		var empCode           = $('#empCode').val();
		var errorPass       = $("#errorPass");
		 
		
		
		 if (newPassword != confirmPassword) {
			 $('.error-chage-pass').text('');
    		 $('.error-chage-pass').append('New Password & Confirm password did not match');
			 $('.error-chage-pass').show();  
			 return false;
		 }
		 if(newPassword.length<6){
			 $('.error-chage-pass').text('');
    		 $('.error-chage-pass').append('Password must be atleast 6 characters');
			 $('.error-chage-pass').show();  
			 return false; 
		 }
		 
		 if(oldPassword == newPassword){
			 $('.error-chage-pass').text('');
    		 $('.error-chage-pass').append('New password cannot be same as old password');
			 $('.error-chage-pass').show();  
			 return false; 
		 }
		 
		
		$.ajax({
	         url: 'changePassword',
	         type:'post',
	         data:'empCode='+empCode+'&oldPassword='+oldPassword+'&newPassword='+newPassword,
	         success:function(res){
	        	 if(res =='0'){
	        		 $('.error-chage-pass').text('');
	        		 $('.error-chage-pass').append('Old password did not match, Please try again');
	    			 $('.error-chage-pass').show();   
	        	 }
	        	 if(res =='1'){
	        		 $('.success-chage-pass').text('');
	        		 errorPass.removeClass( "error-chage-pass" );
	        		 errorPass.addClass('success-chage-pass' );
	        		 $('.success-chage-pass').append('Password has been changed');
	    			 $('.success-chage-pass').show();  
	    			 $('#newPassword').val('');
					 swal({   
				  title: 'Password have been Changed',     
				  showCancelButton: false,
				  confirmButtonColor: "#DC3545",   
				  confirmButtonText: "OK",   
				  closeOnConfirm: true },
				  function(isConfirm){			  
					  logout(); 
				}); 
					 
	        	 }
	    	  },
	          error:function(ress){
				window.close();
	    	  }
 			}); 
 }
 
 function changeEmail(){
	    var oldEmail  = $('#oldEmail').val();
		var newEmail  = $('#newEmail').val();
		var empCode           = $('#empCode').val();
		var errorEmail= $('#errorEmail');
		 if (!validateEmail(newEmail)) {
			 $('.error-chage-email').text('');
 		     $('.error-chage-email').append('Please enter a valid email');
			 $('.error-chage-email').show();  
			 return false; 
	        }
			
			 if (oldEmail == newEmail) {
			 $('.error-chage-email').text('');
 		     $('.error-chage-email').append('Entered email id already used, please enter a different id');
			 $('.error-chage-email').show();  
			 return false; 
	        }
			
			
		 
		$.ajax({
	         url: 'changeEmail',
	         type:'post',
	         data:'empCode='+empCode+'&oldEmail='+oldEmail+'&newEmail='+newEmail,
	         success:function(res){
	        	 if(res =='0'){
	        		 $('.error-chage-email').text('');
	        		 $('.error-chage-email').append('Email Not Update');
	    			 $('.error-chage-email').show();   
	    			
	        	 }
	        	 if(res =='1'){
	        		
	        		 errorEmail.removeClass( "error-chage-email" );
	        		 errorEmail.addClass('success-chage-email' );
	        		 $('.success-chage-email').text('');
	        		 $('.success-chage-email').append('Email id updated successfully');
	    			 $('.success-chage-email').show(); 
	    			 $('#newEmail').val('');
					  swal({   
				 					title: "Email id updated successfully",     
                                     
				 					showCancelButton: false,
				 					confirmButtonColor: "#DC3545",   
				 					confirmButtonText: "OK",   
				 					closeOnConfirm: false },
				 					function(isConfirm){
				 						if(isConfirm){
				 						location.reload();
										}
									});	
					 
	        	 }
	    	  },
	          error:function(ress){
				window.close();
	    	  }
			}); 
}
 
 function validateEmail(email) {
	    var re = /^[A-Za-z0-9]+(\.[A-Za-z0-9]+)?@[A-Za-z]+\.[A-Za-z]+$/;
	    return re.test(email);
	}

 
/*  function validateEmail(email) 
 {
     var re = /\S+@\S+\.\S+/;
     return re.test(email);
 } */
 
  function showMSG(msg){
		 
		  swal({   
				  title: msg,     
				  showCancelButton: false,
				  confirmButtonColor: "#DC3545",   
				  confirmButtonText: "OK",   
				  closeOnConfirm: true },
				  function(isConfirm){			  
					  return false; 
				}); 
	 }
</script>