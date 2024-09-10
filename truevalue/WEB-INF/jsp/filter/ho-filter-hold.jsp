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

<script src="./js/filterPage.js"></script>
<c:set var="dateFrom" value='${payload.dateFrom}'></c:set>
<c:set var="dateTo" value='${payload.dateTo}'></c:set>

<style>
        .filters{display: flex;}
        .filters .filter{position: relative; font-size: 15px; line-height: 19px; font-weight: 500; color: #808080; padding: 12px 14px; background: #fff; border-radius: 5px; border: 1px solid #E8E8E8;}
        .filters .filter span{position: relative; display: inline-block; margin-left: 8px; padding-right: 25px; color: #259AEA; font-size: 15px; line-height: 19px; cursor: pointer;}
        .filters .filter span::after{content: ''; width: 10px; height: 6px; position: absolute; top: 50%; right: 0; transform: translate(0, -50%); background: url('../img/down-arrow.svg') no-repeat center top;}
        .filters .filter span.active::after{transform: translate(0, -50%) rotate(180deg);}
        .cross-btn {cursor: pointer;border-radius: 5px;margin-bottom: 10px;margin-left: 95%;top: 0;font-size: 20px;background-color: #fff !important;color: #2d3393 !important;border: 1px solid #2d3393 !important;}
    </style>
<link rel="stylesheet" type="text/css" href="./css/ho-filter.css" />
<link rel="stylesheet" type="text/css" href="./css/common.css" />
<link rel="stylesheet" type="text/css" href="./includes/page-filter/daterangepicker.css" />

<div class="page-filters">
    <div class="page-filters-block">
        <button class="page-filters-filter">Filter</button>
        <div class="page-filters-filter-block">
            <button class="cross-btn" aria-label="Dismiss alert" type="button" data-close>
                <span aria-hidden="true">&times;</span>
              </button>
            <form action="hoFilterHold" method="post"  class="form-section"  id="formFilter">
            	<div class="form-block">
                    <select name="regionCode" id="regionCode" onchange="regionChange()">
                    <option value="" >Region</option>
                    <c:forEach items="${regions}" var="list">
                        <option value="${list.regionCode}" <c:if test="${payload.regionCode eq list.regionCode}"> selected</c:if>>${list.regionCode}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-block">
                    <select name="stateCode" id="stateCode" onchange="stateChange()">
                    <option value="" >State</option>
                    <c:forEach items="${states}" var="list">
                        <option value="${list.stateCode}"  <c:if test="${payload.stateCode eq list.stateCode}"> selected</c:if>>${list.stateName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-block">
                    <select name="cityCode" id="cityCode" onchange="cityChange()">
                    <option value="" >City</option>
                    <c:forEach items="${cities}" var="list">
                        <option value="${list.cityCode}"  <c:if test="${payload.cityCode eq list.cityCode}"> selected</c:if>>${list.cityName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-block">
                    <select name="parentDealerCode" id="parentDealerCode" onchange="pdChange2()">
                    <option value="" >Parent Dealer</option>
                    <c:forEach items="${pDealers}" var="list">
                        <option value="${list.parentDealerCode}"  <c:if test="${payload.parentDealerCode eq list.parentDealerCode}"> selected</c:if>>${list.parentDealerCode}-${list.parentDealerName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-block">
                    <select name="fsdmId" id="fsdmId"  onchange="fsdmChange()">
                    <option value="" >FSDM</option>
                    <c:forEach items="${fsdms}" var="list">
                        <option value="${list.id}"  <c:if test="${payload.fsdmId eq list.id}"> selected</c:if>>${list.name}</option>
                        </c:forEach>
                    </select>
                </div>
                 <div class="form-block">
                    <select name="dealerId" id="dealerId" >
                    <option value="" >Dealer</option>
                    <c:forEach items="${dealers}" var="list">
                        <option value="${list.id}"  <c:if test="${payload.dealerId eq list.id}"> selected</c:if>>${list.name}</option>
                        </c:forEach>
                    </select>
                </div>
                 
                 	<div class="form-block">
                    From : <input type="date" id="dateFromm" name="dateFromm">
                    <span id="spanFrom"></span>
                </div>
                <div class="form-block">
                    To : <input type="date" id="dateToo" name="dateToo">
                    <span id="spanTo"></span>
                </div>
                
                
                <div class="form-button">
                    <!-- <input type="button" class="cancel-btn" value="Cancel" > -->
                    <input type="reset"  id="reset" value="Reset" class="cancel-btn">
                    <button type="submit" class="submit-btn" >Search</button>
                </div>   
            </form>
        </div>
    </div>
</div>
             <!--   *********************************************************   ***************************************************************  -->

  <script src="./js/moment.min.js"></script>
  <script src="./js/daterangepicker.js"></script>
  
  
<script type="text/javascript">
    function fsdmChange(){
		var fsdmId = document.getElementById('fsdmId').value;
		$.ajax({
			type:"post",
			url:"dealerByFSDM",
			data:"fsdmId="+fsdmId,
			success:function(data){
				$("#dealerId").html(data);
			},
			error:function(data){
			}
		});
		}
	function pdChange2(){
		var pdCode = document.getElementById('parentDealerCode').value;
		$.ajax({
			type:"post",
			url:"fsdmByParentDealer",
			data:"pdCode="+pdCode,
			success:function(data){
				$("#fsdmId").html(data);
				$("#dealerId").empty().append("<option value=''>Dealer</option>");
			},
			error:function(data){
			}
		});
	}
	function pdChange(){
		var pdCode = document.getElementById('parentDealerCode').value;
		$.ajax({
			type:"post",
			url:"dealerByParentDealerCode",
			data:"pdCode="+pdCode,
			success:function(data){
				$("#dealerId").html(data);
			},
			error:function(data){
			}
		});
	}
	function cityChange(){
		var cityCode = document.getElementById('cityCode').value;
        $.ajax({
           type:"post",
           url:"parentDealerByCityCode",
            data:"cityCode="+cityCode,
            success:function(data){
            	$("#parentDealerCode").html(data);
            	$("#fsdmId").empty().append("<option value=''>FSDM</option>");
            	$("#dealerId").empty().append("<option value=''>Dealer</option>");
            },
            error:function(data){
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
				 $("#parentDealerCode").empty().append("<option value=''>Parent Dealer</option>");
				 $("#fsdmId").empty().append("<option value=''>FSDM</option>");
				 $("#dealerId").empty().append("<option value=''>Dealer</option>");
			 },
			 error:function(resp){
			 }
		 });
	}
	function regionChange(){
		var regionCode = document.getElementById('regionCode').value;
		 $.ajax({
			 type:"post",
			 url:"stateByRegionCode",
			 data:"regionCode="+regionCode,
			 success:function(response){
				 $("#stateCode").html(response);
				 $("#cityCode").empty().append("<option value=''>City</option>");
				 $("#parentDealerCode").empty().append("<option value=''>Parent Dealer</option>");
				 $("#fsdmId").empty().append("<option value=''>FSDM</option>");
				 $("#dealerId").empty().append("<option value=''>Dealer</option>");
				// regionChangeCall(regionCode);
			 },
			 error:function(resp){
			 }
		 });
	}
	function regionChangeCall(regionCode){
		$.ajax({
			type : "post",
			url: "fsdmByRegionCode",
			data:"regionCode="+regionCode,
			success:function(response){
				$('#fsdmId').html(response);
			},
			error:function(data){
			}
		});
    }

    $(document).ready(function(){
        var dateRangePayload = `${dateR}`;
        	var dateFrom = `${dateFrom}`;
        	var dateTo = `${dateTo}`;
        	if(dateFrom.length >0){
        		$('#dateFromm').val(dateFrom);
        	}
        	if(dateFrom.length >0){
        		$('#dateToo').val(dateTo);
        	}
        $("#reset").click(function() {
            $('#reportrange').html('Select Date');
        });
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
});
    </script>
<%
}catch(Exception e){
	System.out.println("ca...........");
}
%>

    