<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<style>
        .filters{display: flex;}
        .filters .filter{position: relative; font-size: 15px; line-height: 19px; font-weight: 500; color: #808080; padding: 12px 14px; background: #fff; border-radius: 5px; border: 1px solid #E8E8E8;}
        .filters .filter span{position: relative; display: inline-block; margin-left: 8px; padding-right: 25px; color: #259AEA; font-size: 15px; line-height: 19px; cursor: pointer;}
        .filters .filter span::after{content: ''; width: 10px; height: 6px; position: absolute; top: 50%; right: 0; transform: translate(0, -50%); background: url('../img/down-arrow.svg') no-repeat center top;}
        .filters .filter span.active::after{transform: translate(0, -50%) rotate(180deg);}
    </style>
<link rel="stylesheet" type="text/css" href="/css/ho-filter.css" />

<link rel="stylesheet" type="text/css" href="/includes/page-filter/daterangepicker.css" />
<%

%>
<div class="page-filters">
    <div class="page-filters-block">
        <button class="page-filters-filter">Filter Page For HO</button>
        <div class="page-filters-filter-block">
            <form  class="form-section" >
            	
          <div class="filters">
        <div class="filter">
            Duration: <span id="reportrange">Today</span>
        </div>
                </div> 
                
                
                <div class="form-button">
                    <input type="button" class="cancel-btn" value="cancel" >
                    <input type="button"  class="submit-btn" onclick="searchForm()" value="Search">
                </div>   
            </form>
        </div>
    </div>
</div>
             <!--   *********************************************************   ***************************************************************  -->

  <script src="./js/moment.min.js"></script>
  <script src="/js/daterangepicker.js"></script>
  
  
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
                $("#pdUL").empty().append(data);
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

    var lastStart = `01/${lastMonth}/${currentYear}`;
    var lastEnd = `${totalDays}/${lastMonth}/${currentYear}`;

    // Last 3 Months
    var last3MStart = `01/${lastMonth - 2}/${currentYear}`;

    function cb(start, end) {
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
    cb(start, end);
    /* Date filter */
});
    </script>

    