<%
	response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
	response.setHeader("Pragma","no-cache"); //HTTP 1.0
	response.setHeader("Pragma","no-store"); //HTTP 1.0
	response.setHeader("cache-control", "no-store");
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server 
	session.invalidate();
%>
<script  language="javascript">
if(parent.window.history.forward(1) != null)
	 parent.window.history.forward(1);
</script>