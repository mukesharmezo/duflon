<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<script src="./js/jquery.validate.js"></script>
  <script src="./js/filterPage.js"></script>
  
<c:set var="dateFrom" value='${payload.dateFrom}'></c:set>
<c:set var="dateTo" value='${payload.dateTo}'></c:set>
  
<style>
        .filters{display: flex;}
        .filters .filter{position: relative; font-size: 15px; line-height: 19px; font-weight: 500; color: #808080; padding: 12px 14px; background: #fff; border-radius: 5px; border: 1px solid #E8E8E8;}
        .filters .filter span{position: relative; display: inline-block; margin-left: 8px; padding-right: 25px; color: #259AEA; font-size: 15px; line-height: 19px; cursor: pointer;}
        .filters .filter span::after{content: ''; width: 10px; height: 6px; position: absolute; top: 50%; right: 0; transform: translate(0, -50%); background: url('../img/down-arrow.svg') no-repeat center top;}
        .filters .filter span.active::after{transform: translate(0, -50%) rotate(180deg);}
        .cross-btn {cursor: pointer;border-radius: 5px;margin-bottom: 10px;margin-left: 95%;top: 0;font-size: 20px;background-color: #fff !important;color: #DC3545 !important;border: 1px solid #DC3545 !important;}
        .error {color: red;}
    </style>
<link rel="stylesheet" type="text/css" href="./css/page-filter.css" />
<!-- <link rel="stylesheet" type="text/css" href="./includes/page-filter/daterangepicker.css" />  -->

<div class="page-filters">
    <div class="page-filters-block">
        <button class="page-filters-filter">Filter</button>
        <div class="page-filters-filter-block">
            <button class="cross-btn" aria-label="Dismiss alert" type="button" data-close>
                <span aria-hidden="true">&times;</span>
              </button>
            <form method="get" class="form-section" id="formFilter" >
                 	<div class="form-block">
                    From : <input type="date" id="dateFromm" name="dateFromm">
                </div>
                <div class="form-block">
                    To : <input type="date" id="dateToo" name="dateToo">
                </div>
                    
                <div class="form-button">
                    <!-- <button class="cancel-btn">Cancel</button> -->
                    <input type="reset" id="reset" value="Reset" class="cancel-btn">
                    <button type="submit" class="submit-btn" >Submit</button>
                    <!-- <button type="button" class="submit-btn" onclick="searchFilter()">Submit</button> -->
                </div>
            </form>
        </div>
    </div>
</div>
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