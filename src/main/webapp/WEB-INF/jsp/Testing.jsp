<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
  <head>
  
 <!--  <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" rel="stylesheet" />
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>
 -->
 <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.14.0/css/bootstrap-select.min.css">

<!--  <link rel="stylesheet" type="text/css" href="./css/select2-4.0.13.min.css" /> -->
    <link rel="stylesheet" type="text/css" href="./css/common.css" />
    <link rel="stylesheet" type="text/css" href="./css/hiring-in-process.css" />
    <link rel="stylesheet" type="text/css" href="css/dashboard-filter.css">
	 <link rel="stylesheet" type="text/css" href="./css/sweetalert.css"/>
    <script type="text/javascript" src="./js/sweetalert.min.js"></script>
	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.12.1/css/jquery.dataTables.min.css">
    <link rel="stylesheet" type="text/css" href="./css/datatable.css">

    <script src="./js/jquery-3.7.0-min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.14.0/js/bootstrap-select.min.js"></script>
	<!-- <script src="./js/select2-4.0.13.min.js"></script> -->
    <script src="./js/jquery.dataTables.min.js"></script>
	<script src="https://cdn.datatables.net/fixedcolumns/4.2.1/js/dataTables.fixedColumns.min.js"></script>
	<script src="./js/datatable.js"></script>
	
	<style>
    .tag {
      display: inline-block;
      padding: 4px 8px;
      margin: 4px;
      background-color: #f0f0f0;
      border-radius: 4px;
    }
  </style>


</head>

</head>
<body>
  <form>
    <div>
      <!-- <label for="country-input">Country:</label>
      <select id="country-input" multiple="multiple" style="width: 300px;">
        <option value="IND">India</option>
        <option value="USA">United States</option>
        <option value="CAN">Canada</option>
        <option value="UK">United Kingdom</option>
        <option value="AUS">Australia</option>
        <option value="NZ">New Zealand</option>
        Add more country options here
      </select> -->
    
    
    <select class="selectpicker" multiple data-live-search="true" data-live-search-placeholder="Search">
    <option>Option 1</option>
    <option>Option 2</option>
    <option>Option 3</option>
    <option>Option 4</option>
    <!-- Add more options as needed -->
  </select>
   
  
    <button type="submit">Submit</button>
    </div>
  </form>





  <script>
    $(document).ready(function() {
    	$('.selectpicker').selectpicker();
      /* $('#country-input').select2({
    	  tags : true,
        maximumSelectionLength: 3,
      }); */
    });
  </script>
</body>


</html>