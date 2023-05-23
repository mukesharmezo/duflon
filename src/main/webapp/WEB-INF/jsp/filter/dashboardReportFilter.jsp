<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
String role2="";
if(session.getAttribute("role") != null){
	role2 = session.getAttribute("role").toString().trim();
%>
 <link rel="stylesheet" type="text/css" href="css/common.css">
    <link rel="stylesheet" type="text/css" href="css/sweetalert.css">
    <link rel="stylesheet" type="text/css" href="css/dashboard.css">
    <link rel="stylesheet" type="text/css" href="css/dashboard-filter.css">
    <link rel="stylesheet" type="text/css" href="css/daterangepicker.css" />
    <script type="text/javascript" src="js/sweetalert.min.js"></script>
    <script type="text/javascript" src="./js/jquery.canvasjs.min.js"></script>
    <script src="./js/jquery-3.4.1.min.js"></script>
    <script src="./js/moment.min.js"></script>
    <script src="./js/daterangepicker.js"></script>
	<script src="./js/filterPage.js"></script>
  
  <c:set var="lastStart" value='${lastMStart}'></c:set>
<c:set var="lastEnd" value='${last3MEnd}'></c:set>
<c:set var="last3MStart" value='${last3MStart}'></c:set>
<c:set var="last3MEnd" value='${last3MEnd}'></c:set>
<c:set var="approved" value='${payload.approved}'></c:set>
<c:set var="dateFrom" value='${payload.dateFrom}'></c:set>
<c:set var="dateTo" value='${payload.dateTo}'></c:set>
  
<style>
        .filters{display: flex;}
        .filters .filter{position: relative; font-size: 15px; line-height: 19px; font-weight: 500; color: #808080; padding: 12px 14px; background: #fff; border-radius: 5px; border: 1px solid #E8E8E8;}
        .filters .filter span{position: relative; display: inline-block; margin-left: 8px; padding-right: 25px; color: #259AEA; font-size: 15px; line-height: 19px; cursor: pointer;}
        .filters .filter span::after{content: ''; width: 10px; height: 6px; position: absolute; top: 50%; right: 0; transform: translate(0, -50%); background: url('../img/down-arrow.svg') no-repeat center top;}
        .filters .filter span.active::after{transform: translate(0, -50%) rotate(180deg);}
        .cross-btn {cursor: pointer;border-radius: 5px;margin-bottom: 10px;margin-left: 95%;top: 0;font-size: 20px;background-color: #fff !important;color: #DC3545 !important;border: 1px solid #DC3545 !important;}
        
    </style>
<div class="page-filters">
    <div class="page-filters-block">
        <button class="page-filters-filter">Filter</button>
        <div class="page-filters-filter-block">
<button class="cross-btn" aria-label="Dismiss alert" type="button" data-close>
                <span aria-hidden="true">&times;</span>
              </button>
            <form action="dashboardReportFilter" method="post"  class="form-section" id="formFilter" >
                 <div class="form-block">
                 <select name="regionCode" id="regionCode" onchange="regionChange()">
                    <%if(!role2.equalsIgnoreCase("DL")) { %>
                    <option value="" >Region</option>
                    <%}%>
                    <c:forEach items="${regions}" var="list">
                        <option value="${list.regionCode}" <c:if test="${payload.regionCode eq list.regionCode  || regions.size() eq 1}"> selected</c:if>>${list.regionCode}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-block">
                    <select name="stateCode" id="stateCode" onchange="stateChange()">
                    <%if(!role2.equalsIgnoreCase("DL")) { %>
                    <option value="" >State</option>
                    <%}%>
                    <c:forEach items="${states}" var="list">
                        <option value="${list.stateCode}"  <c:if test="${payload.stateCode eq list.stateCode  || states.size() eq 1}"> selected</c:if>>${list.stateName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-block">
                    <select name="cityCode" id="cityCode" onchange="cityChange()">
                    <option value="" >City</option>
                    <c:forEach items="${cities}" var="list">
                        <option value="${list.cityCode}"  <c:if test="${payload.cityCode eq list.cityCode  || cities.size() eq 1}"> selected</c:if>>${list.cityName}</option>
                        </c:forEach>
                    </select>
                </div>
                 <div class="form-block">
                   <select name="dealershipName" id="dealershipName" onchange="dealershipChange()">
                    <option value="" >Dealership</option>
                    <c:forEach items="${dealerShipList}" var="list">
                        <option value="${list.outletName}"  <c:if test="${payload.dealershipCode eq list.outletName || dealerShipList.size() eq 1}"> selected</c:if>>${list.outletName}</option>
                        </c:forEach>
                    </select> 
                </div>
                 <div class="form-block">
                    <select name="outletCode" id="outletCode">
                    <option value="" >Dealer Code</option>
                    <c:forEach items="${dealerCodeList}" var="list">
                        <option value="${list.outletCode}"  <c:if test="${payload.outletCode eq list.outletCode || dealerCodeList.size() eq 1}"> selected</c:if>>${list.outletCode}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-block">
                   <input type="checkbox" name="approved"   id="approved" value="2" /><label for="approved">Apporved</label>
                  <%-- <input type="hidden" name="approved" id="approved"> --%>
                </div> 
                 	<div class="form-block">
                    From : <input type="date" id="dateFromm" name="dateFromm" min='1999-01-01' max='3000-01-01'>
                    <span id="spanFrom"></span>
                </div>
                <div class="form-block">
                    To : <input type="date" id="dateToo" name="dateToo">
                    <span id="spanTo"></span>
                </div>
                <div class="form-button">
                    <input type="reset" id="reset" value="Reset" class="cancel-btn">
                    <button type="submit" class="submit-btn" onclick="dateValue()">Submit</button>
                    <!-- <input type="button" value ="Submit" class="submit-btn" onclick="submitSearchForm()"> -->

                </div>
                
            </form>
        </div>
    </div>
</div>
<script type="text/javascript">
 function regionChange(){
	 var regionCode = document.getElementById('regionCode').value;
	 $.ajax({
		 type:"post",
		 url:"stateByRegionCode",
		 data:"regionCode="+regionCode,
		 success:function(response){
			 $("#stateCode").html(response);
			// $("#cityCode").html("");
			// $("#outletCode").html("");
			// $("#dealershipCode").html("");
		 },
		 error:function(resp){
		 }
	 });
 }
 function stateChange(){
	 var stateCode = document.getElementById('stateCode').value;
	 $.ajax({
		 type:"post",
		 url:"cityByStateCode",
		 data:"stateCode="+stateCode,
		 success:function(response){
			 $("#cityCode").html(response);
		 },
		 error:function(resp){
		 }
	 });
 }
 function cityChange(){
	 var cityCode = document.getElementById('cityCode').value;
	 $.ajax({
		 type:"post",
		 url:"dealershipByCityCode",
		 data:"cityCode="+cityCode,
		 success:function(response){
			 $("#dealershipName").html(response);
		 },
		 error:function(resp){
		 }
	 });
 }
 function dealershipChange(){
	 var dealershipName = document.getElementById('dealershipName').value;
	 $.ajax({
		 type:"post",
		 url : "outletByOutletCode",
		 data:"outletCode="+dealershipName,
		 success:function(response){
			 $("#outletCode").html(response);
		 }
	 });
 }
 

</script>

    <script>
    $(document).ready(function(){
    	
        var dateFrom = `${dateFrom}`;
    	var dateTo = `${dateTo}`;
    	if(dateFrom.length >0){
    		$('#dateFromm').val(dateFrom);
    	}
    	if(dateFrom.length >0){
    		$('#dateToo').val(dateTo);
    	}
        var approve = `${approved}`;
    	if(approve==2){
			$('#approved').prop('checked', true);
        	}else{
        		$('#approved').prop('checked', false);
            	}
    	$('.page-filters-filter').on('click', function(){
            $(this).toggleClass('active');
            $('.page-filters-filter-block, .blk-bg').toggle();
        });
        $('.page-filters-process').on('click', function(){
            $(this).toggleClass('active');
            $('.page-filters-process-block, .blk-bg').toggle();
        });
        $('.cross-btn').on('click', function(){
            $('.page-filters-filter, .page-filters-process').removeClass('active');
            $('.page-filters-filter-block, .page-filters-process-block, .blk-bg').hide();
            return false;
        });

        // New JS
        $('.custom-select span').click(function(){
            $(this).addClass('active');
            $(this).parent().find('ul').show();
        });
        $(document).mouseup(function(e){
            var container = $(".custom-select ul");
            if (!container.is(e.target) && container.has(e.target).length === 0) 
            {
                container.hide();
                $('.custom-select span').removeClass('active');
            }
        });
  
    /* Date filter */
    var d = new Date();
    var start = moment().startOf('month');
    var end = moment().endOf('month');

    // Fiscal Year
    var currentYear = d.getFullYear();
    var nextYear = (d.getFullYear())+1;
    var fiscalStart = `01/04/${currentYear}`;
    var fiscalEnd = `31/03/${nextYear}`;

    // Last Month
    var lastMonth = d.getMonth();
    console.log(lastMonth);
    var totalDays;
    if(lastMonth == 1 || lastMonth == 3 ||  lastMonth == 5 ||  lastMonth == 7 ||  lastMonth == 8 ||  lastMonth == 10 ||  lastMonth == 12) {
        totalDays = 31;
    } else if(lastMonth == 2) {
        if(currentYear%4 == 0){
            totalDays = 29;
        } else {
            totalDays = 28;
        }
    } else {
        totalDays = 30;
    }

    console.log('last month date: '+'${totalDays}/${lastMonth}/${currentYear}');
    
    var lastStart=`${lastStart}`;
    var lastEnd=`${lastEnd}`;
    var last3MStart=`${last3MStart}`;
    var last3MEnd=`${last3MEnd}`;
	var selectDate="Select Date";
    function cb(start, end) {
    	console.log('end date :'+end);
        $('#reportrange').html(start.format('D MMMM, YYYY') + ' - ' + end.format('D MMMM, YYYY'));
        console.log('end..............:');
    }

    $('#reportrange').daterangepicker({
        opens: 'left',
        format: 'DD/MM/YYYY',
        startDate: start,
        endDate: end,
        locale: {
            format: 'DD/MM/YYYY',
        },
        ranges: {
            'Current Month': [moment().startOf('month'), moment().endOf('month')],
            'Last Month': [lastStart, lastEnd],
            'Last 3 Months': [last3MStart, last3MEnd],
        }
    }, cb);
    console.log(end);
    cb(start, end);
    /* Date filter */
     if(dateRangePayload.length==0){
        $('#reportrange').html('Select Date');}
        else{
        	$('#reportrange').html(dateRangePayload);
        }
   
});
    </script>
    <script type="text/javascript">
    function dateValue(){
    	document.getElementById("dateRange").value = document.getElementById("reportrange").innerText;
    } 
    </script>
      <%}else{
	 response.sendRedirect("login");
}%>