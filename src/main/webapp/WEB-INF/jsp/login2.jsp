<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> 
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import = "java.util.ResourceBundle" %>

<%
try
    {
	ResourceBundle resource = ResourceBundle.getBundle("application");
String baseServer = resource.getString("client.url");String title = resource.getString("app.title");
	%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Clipboard Text to Lowercase</title>
    <link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<br><br><br><br><br>
    <button id="convert-button" class="btn btn-primary">Convert to Lowercase</button>
    <br><br><br><br><br>
    <p id="outputText"></p>
	
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function () {
            $('#convert-button').on('click', function () {
                // Read text from clipboard
                navigator.clipboard.readText()
                    .then(function (clipboardText) {
                        // Convert to lowercase
                        var lowercaseText = clipboardText.toLowerCase();

                        // Copy the lowercase text back to the clipboard
                        navigator.clipboard.writeText(lowercaseText)
                            .then(function () {
                            	$('#outputText').text(lowercaseText);
                                
                            })
                            .catch(function (error) {
                                console.error('Error writing to clipboard: ', error);
                            });
                    })
                    .catch(function (error) {
                        console.error('Error reading from clipboard: ', error);
                    });
            });
        });
    </script>
</body>
</html>
<%
 }catch(Exception e)
    {
    	 System.out.println("Errror....."+e);
    	  response.sendRedirect("login");
    }%>