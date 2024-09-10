<%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page import = "java.util.ResourceBundle" %>
<%try{ 
ResourceBundle resource = ResourceBundle.getBundle("application");
String baseServer = resource.getString("client.url");
%>
<html>
	
	<head>
		<title>iRecruit</title>
		   <meta name="viewport" content="width=device-width, initial-scale=1.0">
		   <link rel="icon" type="image/x-icon" href="<%=baseServer%>img/iRecruit-favicon.ico"/>   <title>iRecruit</title>
	<!-- Bootstrap core CSS -->
        <link rel="stylesheet" type="text/css" href="./css/instruction.css" />
 
		<script type="text/javascript">
		top.window.history.pushState( {} , 'thankyou', 'thank' ); 
		</script>
		<style>
		
		/* .middle-class{width:50%;} */
		@media only screen and (max-width: 1199px) {

		.middle-class{width:100%!important;}
		}
form {
    margin: 80px auto 25px;
    max-width: 450px;
    width: 100%;
    background-color: #f2f2f2;
    /* box-shadow: 0px 3px 10px rgb(0 0 0 / 10%); */
    border-radius: 10px;
    padding: 29px;
    box-sizing: border-box;
}
		</style>
	</head>

  <body topmargin="0">
	<div class="header">
		<div class="container">  <div class="logo"><h2 class="LOGO" style="color: #fff; font-size: 32px; font-weight: 700;"><b>iRecruit</b></h2></div>
	</div>
          

        </div>
    </div>
    </div>
  <section>
  <div class="container">
	 <div class="row">
        <div class="col">
            <div class="middle-class mx-auto  p-3">
			<div  style="text-align:center;">
           	<form>				

					
					  <p style="font-size: 15px">
					  Dear <b>${name}</b><br>
					  Thank you for registering with <b>${dealerShip}</b><br><br>
					  Wishing you all the best!<br>
					  <b>iRecruit Team</b>					  
					  </p>

					
					
				 
			   </form> 
			   
			   </div>
			    </div>
        </div>
		</div>
    </div>
	</section>


		
		  

  </body>
</html>

   <%}catch(Exception e){
	   out.print(e);
   }   
  %>
