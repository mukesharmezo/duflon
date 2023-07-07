<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
  <title>Custom Input Option for Selecting Languages</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.1.0-beta.1/css/select2.min.css">
  <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.1.0-beta.1/js/select2.min.js"></script>
</head>
<body>

  <div class="container">
    <strong>Select Language:</strong>
    <select id="language-select" multiple="multiple">
      <option value="php">PHP</option>
      <option value="javascript">JavaScript</option>
      <option value="java">Java</option>
      <option value="sql">SQL</option>
      <option value="jquery">Jquery</option>
      <option value=".net">.Net</option>
    </select>
  </div>

  <script type="text/javascript">
    $(document).ready(function() {
      $('#language-select').select2({
        tags: true, // Allow custom tags
        tokenSeparators: [','], // Specify token separators for custom tags
        placeholder: 'Select Language', // Default placeholder text
        width: '300px' // Width of the dropdown
      });
    });
  </script>

</body>
</html>



















<!-- <html>
<head>  
  <title>Jquery multiple select with checkboxes using bootstrap-multiselect.js</title>  
  <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.js"></script>  
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">  
  <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>  
  <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-multiselect/0.9.13/js/bootstrap-multiselect.js"></script>  
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-multiselect/0.9.13/css/bootstrap-multiselect.css">  
</head>  
<body>  
  
<div class="container">  
    <strong>Select Language:</strong>  
    <select id="multiple-checkboxes" multiple="multiple">  
        <option value="php">PHP</option>  
        <option value="javascript">JavaScript</option>  
        <option value="java">Java</option>  
        <option value="sql">SQL</option>  
        <option value="jquery">Jquery</option>  
        <option value=".net">.Net</option>  
    </select>  
</div>  
  
<script type="text/javascript">  
    $(document).ready(function() {  
        $('#multiple-checkboxes').multiselect({
            enableFiltering: true, // Enable search/filtering
            enableCaseInsensitiveFiltering: true, // Make search case-insensitive
            includeSelectAllOption: true, // Include select all option
            selectAllText: 'Select All', // Select all option text
            enableHTML: true, // Enable HTML support for options
            nonSelectedText: 'Select Language', // Default text for non-selected options
            buttonWidth: '300px', // Width of the dropdown button
            maxHeight: 200, // Maximum height of the dropdown menu
            enableClickableOptGroups: true, // Enable selection of optgroup labels
            templates: {
                li: '<li><a href="javascript:void(0);"><label></label></a></li>', // Customize the list item template
                filter: '<li class="multiselect-item filter"><div class="input-group"><input class="form-control multiselect-search" type="text"></div></li>' // Customize the search input template
            },
            onChange: function(option, checked, select) {
                // Custom logic when the selection changes
            }
        });  
    });  
</script>  
  
</body>  
</html> -->

