<%@ page language="java" import=" java.net.*, java.io.*,java.util.*"%>
<%@ page import="java.util.ResourceBundle"%>
<%
try
{
ResourceBundle resource = ResourceBundle.getBundle("application");
String baseServer = resource.getString("client.url");String title = resource.getString("app.title");
      if(session.getAttribute("role") != null)
	  {
		String role = session.getAttribute("role").toString().trim();
		String st = "";
 %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
	 <link rel="icon" type="image/x-icon" href="https://staging.irecruit.org.in/irecruit/img/iRecruit-favicon.ico"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="icon" type="image/x-icon" href="<%=baseServer%>img/DuflonFavicon.png"/>
    <title><%=title %></title>
    
    <style>
      .form {
    margin: 80px auto 25px;
    /* max-width: 450px; */
    max-width: 450px;
    width: 100%;
    background-color: #fff;
    box-shadow: 0px 3px 10px rgba(0,0,0,0.1);
    border-radius: 10px;
    padding: 29px;
    box-sizing: border-box;
  }
       .form p {
    font-size:22px;
    line-height: 36px;
    color: #000;
    text-align: center;}
    </style>
    </head>
  
      <body>
	  
        <div class="form"  style="text-align:center;width: 100%;padding: 24px 14px;background-color: #f4f4f4;">
        <p>Something went wrong</p>
        </div>
</body>    

</html>
<%     }else{
    response.sendRedirect("login");
}
}catch(Exception e){
	response.sendRedirect("login");
}
    %>
