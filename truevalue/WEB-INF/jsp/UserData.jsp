<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="com.msil.irecruit.Entities.ParticipantRegistration"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page import = "java.util.ResourceBundle" %>
<%
try
    {
	ResourceBundle resource = ResourceBundle.getBundle("application");
String baseServer = resource.getString("client.url");
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="icon" type="image/x-icon" href="<%=baseServer%>img/iRecruit-favicon.ico"/>
<title>User Details</title>
</head>
<body>
 <div align="center">
            <caption><h2>List of all Participants</h2></caption>
            
         
                        <table align="center" border="1" cellpadding="5" cellspacing="0" width="50%" class="tblreport" id="tableShow">
                            <tr class="headerrow" height="30">
                                <td>Sr.No.</td>
                                <td>Source</td>                                            
                                <td>FirstName</td>
                                <td>MiddleName</td>
                                <td>LastName</td>
                                <td>Image-Upload</td>
                                <td>MobileNumber</td>
                                 <td>Email</td>
                                <td>Dob</td>
                                
                                <td>Highes-Qualification</td>
                                <td>Position-Applied</td>
                                <td>Gender</td>
                                <td>TwoWheeler</td>
                                <td>FourWheeler</td>
                                <td>Work-Experience</td>
                                
                                
                                <td>Total</td>
                                <td>AutoMobile</td>
                                <td>NonAutomobile</td>
                                <td>CurrentAddress</td>
                                <td>Pincode</td>
                                <td>Resume-Upload</td> 
                                <td>Exel-Upload</td>                                    
                              </tr>
      
                      
                             
                          <c:forEach var="user" items="${particnt}" varStatus="status">
                          <tr>
                         
                              <td class="txt1" align="center">${status.index + 1}</td>
                              
                              <td class="txt1" align="center" >${user.source}</td>
                              <td class="txt1" align="center" >${user.firstName}</td>
                              <td class="txt1" align="center" >${user.middleName}</td>
                              <td class="txt1" align="center" >${user.lastName}</td>
                              <td class="txt1" align="center" >${user.images}</td>
                              <td class="txt1" align="center" >${user.mobileNumber}</td>
                              <td class="txt1" align="center">${user.email}</td>
                              <td class="txt1" align="center" >${user.dob}</td>
                              <td class="txt1" align="center" >${user.highestQualification}</td>
                              <td class="txt1" align="center" >${user.positionApplied}</td>
                              <td class="txt1" align="center" >${user.gender}</td>
                              <td class="txt1" align="center">${user.twoWheeler}</td>
                         
                              <td class="txt1" align="center">${user.fourWheeler}</td>
                              <td class="txt1" align="center" >${user.workExperience}</td>
                              <td class="txt1" align="center" >${user.total}</td>
                              <td class="txt1" align="center" >${user.autoMobile}</td>
                              <td class="txt1" align="center" >${user.nonAutomobile}</td>
                              <td class="txt1" align="center">${user.currentAddress}</td>
                              <td class="txt1" align="center" >${user.pincode}</td>
                              <td class="txt1" align="center" >${user.resume}</td>
                              <td class="txt1" align="center">${user.exel}</td>
                          </tr>
                        </c:forEach>
                  
        </table>
    </div>
</body>
</html>
<%
 }catch(Exception e)
    {
    	 System.out.println("Errror....."+e);
    	  response.sendRedirect("login");
    }%>