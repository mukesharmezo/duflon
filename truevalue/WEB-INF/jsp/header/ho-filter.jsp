<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%
try{
%>

<%-- <c:set var="totalDays" value="12"></c:set> --%>
<%-- 
<c:set var="lastMonth" value="10"></c:set>

<c:set var="currentYear" value="2022">   call me</c:set>  --%>


<c:set var="lastStart" value='${lastStart}'></c:set>
<c:set var="lastEnd" value='${lastEnd}'></c:set>
<c:set var="last3MStart" value='${last3MStart}'></c:set>
<style>
        .filters{display: flex;}
        .filters .filter{position: relative; font-size: 15px; line-height: 19px; font-weight: 500; color: #808080; padding: 12px 14px; background: #fff; border-radius: 5px; border: 1px solid #E8E8E8;}
        .filters .filter span{position: relative; display: inline-block; margin-left: 8px; padding-right: 25px; color: #259AEA; font-size: 15px; line-height: 19px; cursor: pointer;}
        .filters .filter span::after{content: ''; width: 10px; height: 6px; position: absolute; top: 50%; right: 0; transform: translate(0, -50%); background: url('../img/down-arrow.svg') no-repeat center top;}
        .filters .filter span.active::after{transform: translate(0, -50%) rotate(180deg);}
    </style>
<link rel="stylesheet" type="text/css" href="./css/ho-filter.css" />
<link rel="stylesheet" type="text/css" href="./css/common.css" />
<link rel="stylesheet" type="text/css" href="./includes/page-filter/daterangepicker.css" />

<div class="page-filters">
    <div class="page-filters-block">
        <button class="page-filters-filter">Search</button>
        <div class="page-filters-filter-block">
            <form <%-- action="hoFilter" method="post" --%> class="form-section" >
            	<div class="form-block">
                    <div class="custom-select">
                        <span>Region</span>
                        <ul id="region" onchange="regionChange()" >
                        <c:forEach items="${regionMap}" var="map">
                            <li >
                                <label><input type="checkbox" class="reg"  id="${map.key}" value="${map.key}" name="regionList"  />${map.value}</label>
                            </li>
                            </c:forEach>
                        </ul>
                    </div>
                    </div>
                    <div class="form-block">
                    <div class="custom-select">
                        <span>State</span>
                        <ul id="statesUL" onchange="stateChange()" >
                        <c:forEach items="${stateMap}"  var="map">
                            <li>
                                 <label><input type="checkbox"  class="regs"  id="${map.key}"  value="${map.key}" name="stateList"/>${map.value}</label>
                            </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
                <div class="form-block">
                    <div class="custom-select">
                        <span>City</span>
                        <ul id="cityUL" onchange="cityChange()">
                            <c:forEach items="${cityMap}" var="map">
                            <li>
                                 <label><input type="checkbox" class="city" id="${map.key}" value="${map.key}" name="cityList" />${map.value}</label>
                            </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>                
              
                <div class="form-block">
                     <div class="custom-select">
                        <span>Parent Dealer</span>
                        <ul id="pdUL" onchange="pdChange()">
                        <li>
                        		<label><input type="checkbox"><input type ="text" class="pd"  value="Custom"/></input></label>
                        	</li>
                            <c:forEach items="${parentDMap}" var="map">
                            <li>
                                 <label><input type="checkbox" class="pd" id="${map.key}" value="${map.key}" name="pdList"/>${map.value}</label>
                            </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
                <div class="form-block">
                     <div class="custom-select">
                        <span>FSDM</span>
                        <ul id="fsdmUL" onchange="fsdmChange()">
                            <c:forEach items="${FSDMMap}" var="map">
                            <li>
                                 <label><input type="checkbox" class="fsdm" id="${map.key}" value="${map.key}" name="fsdmList"/>${map.value}</label>
                            </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
                <div class="form-block">
                     <div class="custom-select">
                        <span>Dealer</span>
                        <ul id="dealerUL" >
                            <c:forEach items="${dealerMap}" var="map">
                            <li>
                                 <label><input type="checkbox" class="dealer" id="${map.key}" value="${map.key}"  name="dlList"/>${map.value}</label>
                            </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
                 
                 	<div class="filters">
        <div class="filter">
            Duration: <span id="reportrange">Today</span>
        </div>
                </div> 
                
                
                <div class="form-button">
                    <input type="button" class="cancel-btn" value="Cancel" >
                    <input type="button"  class="submit-btn" onclick="searchForm()" value="Search">
                </div>   
            </form>
        </div>
    </div>
</div>
             <!--   *********************************************************   ***************************************************************  -->

  <script src="./js/moment.min.js"></script>
  <script src="./js/daterangepicker.js"></script>
  
  
<script type="text/javascript">
function searchForm(){
	
	var regionCheckBox=[];
	var stateCheckBox=[];
	var cityCheckBox=[];
	var pdCheckBox=[];
	var dealerCheckBox=[];
	var fsdmCheckBox=[];
	var spanDate = document.getElementById("reportrange").innerText;
	$('input.reg:checked').map(function(){
		regionCheckBox.push($(this).val());
	});
	$('input.regs:checked').map(function(){
		stateCheckBox.push($(this).val());
	});
	$('input.city:checked').map(function(){
		cityCheckBox.push($(this).val()); 
        });
	$('input.pd:checked').map(function(){
		pdCheckBox.push($(this).val()); 
        });
	$('input.fsdm:checked').map(function(){
		fsdmCheckBox.push($(this).val()); 
        });
	$('input.dealer:checked').map(function(){
		dealerCheckBox.push($(this).val()); 
        });
	
	/* create form */
	//var form = new FormData();    
	var form = document.createElement("form");   
	//document.body.appendChild(form);
    form.method="POST";
	form.action="hoFilter";

    form.append("regions", regionCheckBox);
    form.append("states",stateCheckBox);
    form.append("cities",cityCheckBox);
    form.append("pDealers",pdCheckBox);
    form.append("dealers",dealerCheckBox);
    form.append("fsdms",fsdmCheckBox);
    //alert(stateCheckBox);
	var region=document.createElement("input");
    region.setAttribute("type","hidden");
    region.setAttribute("name","regions");
    region.setAttribute("value", regionCheckBox);     //var regionCheckBox=[];
    form.appendChild(region);
    
    var state=document.createElement("input");
    state.setAttribute("type","hidden");
    state.setAttribute("name","states");
    state.setAttribute("value", stateCheckBox); 
    form.appendChild(state);
	
    var city=document.createElement("input");
    city.setAttribute("type","hidden");
    city.setAttribute("name","cities");
    city.setAttribute("value", cityCheckBox);
    form.appendChild(city);
    
    var pd = document.createElement("input");
    pd.setAttribute("type","hidden");
    pd.setAttribute("name","pDealers");
    pd.setAttribute("value", pdCheckBox);
    form.appendChild(pd);
    
    var fsdm = document.createElement("input");
    fsdm.setAttribute("type","hidden");
    fsdm.setAttribute("name","fsdms");
    fsdm.setAttribute("value", fsdmCheckBox);
    form.appendChild(fsdm);
    
    var dealer = document.createElement("input");
    dealer.setAttribute("type","hidden");
    dealer.setAttribute("name","dealers");
    dealer.setAttribute("value", dealerCheckBox);
    form.appendChild(dealer);
    
    var dateR = document.createElement("input");
    dateR.setAttribute("type","hidden");
    dateR.setAttribute("name","dateRange");
    dateR.setAttribute("value",spanDate);
    form.appendChild(dateR);
  // $(document.body).append(form);
   document.body.appendChild(form);
    form.submit(this);
    

}

	function fsdmChange(){}
	function pdChange(){
		var pds=[];
		$('input.pd:checked').map(function(){
			pds.push($(this).val());
		});
		$.ajax({
			type:"get",
			url:"allDealerHO",
			cache:false,
			data:"pdCodes="+pds,
			success:function(data){
				$("#dealerUL").empty().append(data);
				console.log(data);
			},
			error:function(data){
				console.log();
			}
		});
	}
	function cityChange(){
		var cities=[];
		$('input.city:checked').map(function(){
           cities.push($(this).val()); 
        });
        $.ajax({
           type:"get",
           url:"allParentDealerHO",
            cache:false,
            data:"cityCode="+cities,
            success:function(data){
            	$("#pdUL").parents('li').remove();
                $("#pdUL").empty().append(data);
              /*  $('#pdUL')
		        	    .find('li')
		        	    .remove()
		        	    .end()
		        	    .append(data); */
                console.log(data);
            },
            error:function(data){
                console.log(data);
            }
        });
	}

	function stateChange(){
		var stateCheckBox=[];
		$('input.regs:checked').map(function(){
			stateCheckBox.push($(this).val());
		});
		$.ajax({
			type:"get",
			url:"allCityHO",
			cache:false,
			data:"stateCode="+stateCheckBox,
			success:function(response){
				$("#cityUL").empty().append(response);
				//console.log(response);
				},
			error:function(data){
				console.log(data);
			}
		});
	}
	function regionChange(){
		var regionCheckBox = [];
		$('input.reg:checked').map(function(){
			regionCheckBox.push($(this).val());
		});
		$.ajax({
			type : "get",
			url: "allStateHO",
			cache: false,
			//dataType: 'json',
			data:"regions="+regionCheckBox,
			success:function(response){
				$('#statesUL').empty().append(response);
				//console.log(response);
			},
			error:function(data){
				console.log(data);
				alert('Error loaded');
			}
		});
	}
	

    $(document).ready(function(){
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
    	
        /* $('.page-filters-filter').on('click', function(){
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
        }); */
  
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
    /*
    var lastStart = `01/${lastMonth}/${currentYear}`;
    var lastEnd = `${totalDays}/${lastMonth}/${currentYear}`;
    
    
    
    

    // Last 3 Months
    var last3MStart = `01/${lastMonth - 2}/${currentYear}`;   */
    
    var lastStart=`${lastStart}`;
    var lastEnd=`${lastEnd}`;
    var last3MStart=`${last3MStart}`;
	var selectDate="Select Date";
    function cb(start, end) {
    	console.log('end date :'+end);
        $('#reportrange').html(start.format('D MMMM, YYYY') + ' - ' + end.format('D MMMM, YYYY'));
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
            'Last 3 Months': [last3MStart, lastEnd],
        }
    }, cb);
    console.log(end);
    cb(start, end);
    /* Date filter */
    $('#reportrange').html('Select Date');
});
    </script>
<%
}catch(Exception e){
	System.out.println("ca...........");
}
%>

    