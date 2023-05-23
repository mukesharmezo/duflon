<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

  <script src="./js/moment.min.js"></script>
  <script src="/js/daterangepicker.js"></script>
  
  <c:set var="lastStart" value='${lastStart}'></c:set>
<c:set var="lastEnd" value='${lastEnd}'></c:set>
<c:set var="last3MStart" value='${last3MStart}'></c:set>
<c:set var="last3MEnd" value='${last3MEnd}'></c:set>
<c:set var="dateR" value='${payload.dateRange}'></c:set>
<style>
        .filters{display: flex;}
        .filters .filter{position: relative; font-size: 15px; line-height: 19px; font-weight: 500; color: #808080; padding: 12px 14px; background: #fff; border-radius: 5px; border: 1px solid #E8E8E8;}
        .filters .filter span{position: relative; display: inline-block; margin-left: 8px; padding-right: 25px; color: #259AEA; font-size: 15px; line-height: 19px; cursor: pointer;}
        .filters .filter span::after{content: ''; width: 10px; height: 6px; position: absolute; top: 50%; right: 0; transform: translate(0, -50%); background: url('../img/down-arrow.svg') no-repeat center top;}
        .filters .filter span.active::after{transform: translate(0, -50%) rotate(180deg);}
    </style>
<link rel="stylesheet" type="text/css" href="./css/daterangepicker.css" /> 
<link rel="stylesheet" type="text/css" href="./css/accesskeyFilter.css" /> 

<div class="page-filters">
    <div class="page-filters-block">
        <button class="page-filters-filter">Filter Page</button>
        <div class="page-filters-filter-block">
            <form action="accesskeyFilter" method="post" class="form-section" >                  
                 	<div class="filters">
        <div class="filter">
            Duration: <span id="reportrange">Today</span>
        </div>
                </div>
                <div>
                <input type="hidden" id="dateRange" name="dateRange" value="" >
                </div>
                    
                <div class="form-button">
                    <button class="cancel-btn">Cancel</button>
                    <button type="submit" class="submit-btn" onclick="dateValue()">Submit</button>
                </div>
                
            </form>
        </div>
    </div>
</div>


    <script>
    $(document).ready(function(){
    	var dateRangePayload = `${dateR}`;
    	$('.page-filters-filter').on('click', function(){
            $(this).toggleClass('active');
            $('.page-filters-filter-block, .blk-bg').toggle();
        });
        $('.page-filters-process').on('click', function(){
            $(this).toggleClass('active');
            $('.page-filters-process-block, .blk-bg').toggle();
        });
        $('.cancel-btn').on('click', function(){
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