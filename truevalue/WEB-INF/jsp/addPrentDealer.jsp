
<% 
try {
	 String msg ="";  
	    if(session.getAttribute("msg") != null){
	  	  msg = (String)session.getAttribute("msg");
	  	  session.removeAttribute("msg");
	    }
	    System.out.println("D.....q.."+msg);
%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<link rel="shortcut icon" type="image/svg" href="http://staging.irecruit.org.in:8080/irecruit/img/iRecruit-favicon.ico"/>
    <title>iRecruit</title>
    <link rel="stylesheet" type="text/css" href="./css/login.css" />
    <style>
      .left-panel > ul > li:nth-child(1) a::after{content: ''; position: absolute; right: 0; top: 50%; transform: translate(0, -50%); border-right: 6px solid #fff; border-top: 6px solid transparent; border-bottom: 6px solid transparent;}
    
    .error-chage-email{
	margin: 20px 0;
color: #f00;
text-align: centre;
font-size: 14px;
line-height: 20px;
display:none;
}
    </style>
    <script src="./js/jquery-3.4.1.min.js"></script>
    <script>
    function addEmail(){
    	
		var parent_dealer     =  $("#parent_dealer").val();		
			
		
		alert(parent_dealer);
		if (parent_dealer =="") {
			   $('.error-chage-email').append('Please enter valid email.');
    		   $('.error-chage-email').show();   
	          return false;
	      }
		document.forms[0].action="addParentDealerGroupPro";
		document.forms[0].method="post";
		document.forms[0].submit(); 
		 
	}
    
    
     <%if(msg.equals("E")){
    	 System.out.println("D.....er.."+msg);
    	 msg="Parent Dealer Group already Added";
     %>
      // $('.error-chage-email').append('Parent Dealer Group already Added');
	   $('.error-chage-email').show();   
     <% }%> 
     <%if(msg.equals("S")){
    	 msg="Parebt Dealer Group added successfully";
     %>
    //   $('.error-chage-email').append('Parebt Dealer Group added successfully');
	   $('.error-chage-email').show();   
    <% }%>
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
    <div >
        <div class="form" style="max-width: 600px!important;   margin-left: 35%;" >
            <form class="form__section"   id="testForm">
                   
                <h1 style="font-size:25px !important;">Add Parent Dealer Group</h1>
                <div class="form__block">
                    <input type="text" name="parent_dealer" id="parent_dealer" placeholder="">
                </div>
                 <div id="parent" style="color:green;"><%=msg %></div>
                <div class="form__block">
                    <input type="button" class="form__button form__button--submit" onclick="addEmail()" value="Save">
                </div>
            </form>
        </div>
    </div>
</div>
  </body>
</html>

<%
	//}else{
		// response.sendRedirect("login");
		//}

	} catch (Exception e) {
		System.out.println("Errror....." + e);
		response.sendRedirect("login");
	}
%>
