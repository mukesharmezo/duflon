
$(document).ready(function () {
	
	 
//aggregate-report
	
	  var currentdate = new Date();
	    var day   =   currentdate.getDate() ;
	    var month =  currentdate.getMonth()+1 ;
	    var year  = currentdate.getFullYear();
        var hours = currentdate.getHours(); 
        var min   =  currentdate.getMinutes();
      
        for(var i=1; i<= 9; i++ ){
        	if(day == i){
        	day ='0'+day;	
           }
        }
        for(var j=1; j<= 9; j++ ){
        if(month==j){
        	month  ='0'+month;	
          }
        }
        for(var k=1; k <= 9; k++ ){
        if(hours==k){
        	hours ='0'+hours;	
          }
        }
        
        var completefile = day+'-'+month+'-'+year+' '+hours+"-"+min;
	
    var table = $('#data-agr').DataTable({
        "pageLength": 10,
        scrollY: '425px',
        scrollCollapse: true,
        scrollX: true,
		fixedColumns:   {
            left: 2
        },
		dom: 'Bfrtip',
        buttons: [ 
{ extend: 'csv', text: 'Export to CSV', className: 'ecsvbutton', title:$('#filename11').val()+'('+completefile+')' } 
        ]
    });

	
	
    $('#data-agr thead tr')
        .clone(true)
        .find('th')
        .removeClass('sorting_asc sorting_asc sorting')
        .off('click')
        .end()
        .appendTo('#data-agr thead');

      
    
    
    // Overview  
    $('th').on("click", function (event) {
        if($(event.target).is("input"))
            event.stopImmediatePropagation();
    });

    var table = $('#data-ov').DataTable({
        "pageLength": 10,
        scrollY: '425px',
        scrollCollapse: true,
        scrollX: true,
		fixedColumns:   {
            left: 2
        },
		dom: 'Bfrtip',
        buttons: [ 
{ extend: 'csv', text: 'Export to CSV', className: 'ecsvbutton', title:$('#filename1').val()+'('+completefile+')'  } 
        ]
    });

	
	
    $('#data-ov thead tr')
        .clone(true)
        .find('th')
        .removeClass('sorting_asc sorting_asc sorting')
        .off('click')
        .end()
        .appendTo('#data-ov thead');

    $('.dataTables_scrollHead .dataTable thead tr:eq(0) th').each(function (i) {
        var title = $(this).data('head');
        if (title) {
            $(this).append('<input type="text" placeholder="' + title + '" />');
        } else {
            $(this).append('');
        }

        $('input', this).on('keyup change', function () {
            if (table.column(i).search() !== this.value) {
                table
                    .column(i)
                    .search(this.value)
                    .draw();
            }
        });
    });

    $('.add-remove-columns span').click(function(){
        $(this).addClass('active');
        $('.add-remove-columns ul').show();
    });
 
    $('a.toggle-vis').on('click', function (e) {
        e.preventDefault();
 
        // Get the column API object
        var column = table.column($(this).attr('data-column'));
 
        // Toggle the visibility
        column.visible(!column.visible());
        $(this).parent().toggleClass('active');
    });
    
    $(document).mouseup(function(e) 
    {
        var container = $(".add-remove-columns ul");
        if (!container.is(e.target) && container.has(e.target).length === 0) 
        {
            container.hide();
            $('.add-remove-columns span').removeClass('active');
        }
    });



    // Action Points 
    $('th').on("click", function (event) {
        if($(event.target).is("input"))
            event.stopImmediatePropagation();
    });

    var tableAP = $('#data-ap').DataTable({
        "pageLength": 10,
        scrollY: '425px',
        scrollCollapse: true,
        scrollX: true,
		fixedColumns:   {
            left: 2
        },
dom: 'Bfrtip',
        buttons: [ 
{ extend: 'csv', text: 'Export to CSV', className: 'ecsvbutton', title:$('#filename2').val()+'('+completefile+')'  } 
        ]
    });

    $('#data-ap thead tr')
        .clone(true)
        .find('th')
        .removeClass('sorting_asc sorting_asc sorting')
        .off('click')
        .end()
        .appendTo('#data-ap thead');

    $('.dataTables_scrollHead .dataTable thead tr:eq(0) th').each(function (i) {
        var title = $(this).data('head');
        if (title) {
            $(this).append('<input type="text" placeholder="' + title + '" />');
        } else {
            $(this).append('');
        }

        $('input', this).on('keyup change', function () {
            if (tableAP.column(i).search() !== this.value) {
                tableAP
                    .column(i)
                    .search(this.value)
                    .draw();
            }
        });
    });

    $('.add-remove-columns span').click(function(){
        $(this).addClass('active');
        $('.add-remove-columns ul').show();
    });
 
    $('a.toggle-vis').on('click', function (e) {
        e.preventDefault();
 
        // Get the column API object
        var column = tableAP.column($(this).attr('data-column'));
 
        // Toggle the visibility
        column.visible(!column.visible());
        $(this).parent().toggleClass('active');
    });
    
    $(document).mouseup(function(e) 
    {
        var container = $(".add-remove-columns ul");
        if (!container.is(e.target) && container.has(e.target).length === 0) 
        {
            container.hide();
            $('.add-remove-columns span').removeClass('active');
        }
    });



    // Recruitment Source
    $('th').on("click", function (event) {
        if($(event.target).is("input"))
            event.stopImmediatePropagation();
    });

    var tableAP = $('#data-rs').DataTable({
        "pageLength": 10,
        scrollY: '425px',
        scrollCollapse: true,
        scrollX: true,
		fixedColumns:   {
            left: 2
        },
dom: 'Bfrtip',
        buttons: [ 
{ extend: 'csv', text: 'Export to CSV', className: 'ecsvbutton', title:$('#filename3').val()+'('+completefile+')'  } 
        ]
    });

    $('#data-rs thead tr')
        .clone(true)
        .find('th')
        .removeClass('sorting_asc sorting_asc sorting')
        .off('click')
        .end()
        .appendTo('#data-rs thead');

    $('.dataTables_scrollHead .dataTable thead tr:eq(0) th').each(function (i) {
        var title = $(this).data('head');
        if (title) {
            $(this).append('<input type="text" placeholder="' + title + '" />');
        } else {
            $(this).append('');
        }

        $('input', this).on('keyup change', function () {
            if (tableAP.column(i).search() !== this.value) {
                tableAP
                    .column(i)
                    .search(this.value)
                    .draw();
            }
        });
    });

    $('.add-remove-columns span').click(function(){
        $(this).addClass('active');
        $('.add-remove-columns ul').show();
    });
 
    $('a.toggle-vis').on('click', function (e) {
        e.preventDefault();
 
        // Get the column API object
        var column = tableAP.column($(this).attr('data-column'));
 
        // Toggle the visibility
        column.visible(!column.visible());
        $(this).parent().toggleClass('active');
    });
    
    $(document).mouseup(function(e) 
    {
        var container = $(".add-remove-columns ul");
        if (!container.is(e.target) && container.has(e.target).length === 0) 
        {
            container.hide();
            $('.add-remove-columns span').removeClass('active');
        }
    });




    // Sales non-sales
    $('th').on("click", function (event) {
        if($(event.target).is("input"))
            event.stopImmediatePropagation();
    });

    var tableAP = $('#data-sns').DataTable({
        "pageLength": 10,
        scrollY: '425px',
        scrollCollapse: true,
        scrollX: true,
		fixedColumns:   {
            left: 2
        },
dom: 'Bfrtip',
        buttons: [ 
{ extend: 'csv', text: 'Export to CSV', className: 'ecsvbutton', title:$('#filename4').val()+'('+completefile+')'  } 
        ]
    });

    $('#data-sns thead tr')
        .clone(true)
        .find('th')
        .removeClass('sorting_asc sorting_asc sorting')
        .off('click')
        .end()
        .appendTo('#data-sns thead');

    $('.dataTables_scrollHead .dataTable thead tr:eq(0) th').each(function (i) {
        var title = $(this).data('head');
        if (title) {
            $(this).append('<input type="text" placeholder="' + title + '" />');
        } else {
            $(this).append('');
        }

        $('input', this).on('keyup change', function () {
            if (tableAP.column(i).search() !== this.value) {
                tableAP
                    .column(i)
                    .search(this.value)
                    .draw();
            }
        });
    });

    $('.add-remove-columns span').click(function(){
        $(this).addClass('active');
        $('.add-remove-columns ul').show();
    });
 
    $('a.toggle-vis').on('click', function (e) {
        e.preventDefault();
 
        // Get the column API object
        var column = tableAP.column($(this).attr('data-column'));
 
        // Toggle the visibility
        column.visible(!column.visible());
        $(this).parent().toggleClass('active');
    });
    
    $(document).mouseup(function(e) 
    {
        var container = $(".add-remove-columns ul");
        if (!container.is(e.target) && container.has(e.target).length === 0) 
        {
            container.hide();
            $('.add-remove-columns span').removeClass('active');
        }
    });



    // Gender Diversity
    $('th').on("click", function (event) {
        if($(event.target).is("input"))
            event.stopImmediatePropagation();
    });

    var tableAP = $('#data-gd').DataTable({
        "pageLength": 10,
        scrollY: '425px',
        scrollCollapse: true,
        scrollX: true,
		fixedColumns:   {
            left: 2
        },
dom: 'Bfrtip',
        buttons: [ 
{ extend: 'csv', text: 'Export to CSV', className: 'ecsvbutton', title:$('#filename5').val()+'('+completefile+')'  } 
        ]
    });

    $('#data-gd thead tr')
        .clone(true)
        .find('th')
        .removeClass('sorting_asc sorting_asc sorting')
        .off('click')
        .end()
        .appendTo('#data-gd thead');

    $('.dataTables_scrollHead .dataTable thead tr:eq(0) th').each(function (i) {
        var title = $(this).data('head');
        if (title) {
            $(this).append('<input type="text" placeholder="' + title + '" />');
        } else {
            $(this).append('');
        }

        $('input', this).on('keyup change', function () {
            if (tableAP.column(i).search() !== this.value) {
                tableAP
                    .column(i)
                    .search(this.value)
                    .draw();
            }
        });
    });

    $('.add-remove-columns span').click(function(){
        $(this).addClass('active');
        $('.add-remove-columns ul').show();
    });
 
    $('a.toggle-vis').on('click', function (e) {
        e.preventDefault();
 
        // Get the column API object
        var column = tableAP.column($(this).attr('data-column'));
 
        // Toggle the visibility
        column.visible(!column.visible());
        $(this).parent().toggleClass('active');
    });
    
    $(document).mouseup(function(e) 
    {
        var container = $(".add-remove-columns ul");
        if (!container.is(e.target) && container.has(e.target).length === 0) 
        {
            container.hide();
            $('.add-remove-columns span').removeClass('active');
        }
    });



    // Candidate experience
    $('th').on("click", function (event) {
        if($(event.target).is("input"))
            event.stopImmediatePropagation();
    });

    var tableAP = $('#data-ce').DataTable({
        "pageLength": 10,
        scrollY: '425px',
        scrollCollapse: true,
        scrollX: true,
		fixedColumns:   {
            left: 2
        },
dom: 'Bfrtip',
        buttons: [ 
{ extend: 'csv', text: 'Export to CSV', className: 'ecsvbutton', title:$('#filename6').val()+'('+completefile+')'  } 
        ]
    });

    $('#data-ce thead tr')
        .clone(true)
        .find('th')
        .removeClass('sorting_asc sorting_asc sorting')
        .off('click')
        .end()
        .appendTo('#data-ce thead');

    $('.dataTables_scrollHead .dataTable thead tr:eq(0) th').each(function (i) {
        var title = $(this).data('head');
        if (title) {
            $(this).append('<input type="text" placeholder="' + title + '" />');
        } else {
            $(this).append('');
        }

        $('input', this).on('keyup change', function () {
            if (tableAP.column(i).search() !== this.value) {
                tableAP
                    .column(i)
                    .search(this.value)
                    .draw();
            }
        });
    });

    $('.add-remove-columns span').click(function(){
        $(this).addClass('active');
        $('.add-remove-columns ul').show();
    });
 
    $('a.toggle-vis').on('click', function (e) {
        e.preventDefault();
 
        // Get the column API object
        var column = tableAP.column($(this).attr('data-column'));
 
        // Toggle the visibility
        column.visible(!column.visible());
        $(this).parent().toggleClass('active');
    });
    
    $(document).mouseup(function(e) 
    {
        var container = $(".add-remove-columns ul");
        if (!container.is(e.target) && container.has(e.target).length === 0) 
        {
            container.hide();
            $('.add-remove-columns span').removeClass('active');
        }
    });



    // Age Wise
    $('th').on("click", function (event) {
        if($(event.target).is("input"))
            event.stopImmediatePropagation();
    });

    var tableAP = $('#data-aw').DataTable({
        "pageLength": 10,
        scrollY: '425px',
        scrollCollapse: true,
        scrollX: true,
		fixedColumns:   {
            left: 2
        },
dom: 'Bfrtip',
        buttons: [ 
{ extend: 'csv', text: 'Export to CSV', className: 'ecsvbutton', title:$('#filename7').val()+'('+completefile+')'  } 
        ]
    });

    $('#data-aw thead tr')
        .clone(true)
        .find('th')
        .removeClass('sorting_asc sorting_asc sorting')
        .off('click')
        .end()
        .appendTo('#data-aw thead');

    $('.dataTables_scrollHead .dataTable thead tr:eq(0) th').each(function (i) {
        var title = $(this).data('head');
        if (title) {
            $(this).append('<input type="text" placeholder="' + title + '" />');
        } else {
            $(this).append('');
        }

        $('input', this).on('keyup change', function () {
            if (tableAP.column(i).search() !== this.value) {
                tableAP
                    .column(i)
                    .search(this.value)
                    .draw();
            }
        });
    });

    $('.add-remove-columns span').click(function(){
        $(this).addClass('active');
        $('.add-remove-columns ul').show();
    });
 
    $('a.toggle-vis').on('click', function (e) {
        e.preventDefault();
 
        // Get the column API object
        var column = tableAP.column($(this).attr('data-column'));
 
        // Toggle the visibility
        column.visible(!column.visible());
        $(this).parent().toggleClass('active');
    });
    
    $(document).mouseup(function(e) 
    {
        var container = $(".add-remove-columns ul");
        if (!container.is(e.target) && container.has(e.target).length === 0) 
        {
            container.hide();
            $('.add-remove-columns span').removeClass('active');
        }
    });




    // Assisment Report
    $('th').on("click", function (event) {
        if($(event.target).is("input"))
            event.stopImmediatePropagation();
    });

    var tableAP = $('#data-ar').DataTable({
        "pageLength": 10,
        scrollY: '425px',
        scrollCollapse: true,
        scrollX: true,
		fixedColumns:   {
            left: 2
        },
dom: 'Bfrtip',
        buttons: [ 
{ extend: 'csv', text: 'Export to CSV', className: 'ecsvbutton', title:$('#filename8').val()+'('+completefile+')'  } 
        ]
    });

    $('#data-ar thead tr')
        .clone(true)
        .find('th')
        .removeClass('sorting_asc sorting_asc sorting')
        .off('click')
        .end()
        .appendTo('#data-ar thead');

    $('.dataTables_scrollHead .dataTable thead tr:eq(0) th').each(function (i) {
        var title = $(this).data('head');
        if (title) {
            $(this).append('<input type="text" placeholder="' + title + '" />');
        } else {
            $(this).append('');
        }

        $('input', this).on('keyup change', function () {
            if (tableAP.column(i).search() !== this.value) {
                tableAP
                    .column(i)
                    .search(this.value)
                    .draw();
            }
        });
    });

    $('.add-remove-columns span').click(function(){
        $(this).addClass('active');
        $('.add-remove-columns ul').show();
    });
 
    $('a.toggle-vis').on('click', function (e) {
        e.preventDefault();
 
        // Get the column API object
        var column = tableAP.column($(this).attr('data-column'));
 
        // Toggle the visibility
        column.visible(!column.visible());
        $(this).parent().toggleClass('active');
    });
    
    $(document).mouseup(function(e) 
    {
        var container = $(".add-remove-columns ul");
        if (!container.is(e.target) && container.has(e.target).length === 0) 
        {
            container.hide();
            $('.add-remove-columns span').removeClass('active');
        }
    });




    // Question Analysis
    $('th').on("click", function (event) {
        if($(event.target).is("input"))
            event.stopImmediatePropagation();
    });

    var tableAP = $('#data-qa').DataTable({
        "pageLength": 10,
        scrollY: '425px',
        scrollCollapse: true,
        scrollX: true,
		fixedColumns:   {
            left: 2
        },
dom: 'Bfrtip',
        buttons: [ 
{ extend: 'csv', text: 'Export to CSV', className: 'ecsvbutton', title:$('#filename9').val()+'('+completefile+')'  } 
        ]
    });

    $('#data-qa thead tr')
        .clone(true)
        .find('th')
        .removeClass('sorting_asc sorting_asc sorting')
        .off('click')
        .end()
        .appendTo('#data-qa thead');

    $('.dataTables_scrollHead .dataTable thead tr:eq(0) th').each(function (i) {
        var title = $(this).data('head');
        if (title) {
            $(this).append('<input type="text" placeholder="' + title + '" />');
        } else {
            $(this).append('');
        }

        $('input', this).on('keyup change', function () {
            if (tableAP.column(i).search() !== this.value) {
                tableAP
                    .column(i)
                    .search(this.value)
                    .draw();
            }
        });
    });

    $('.add-remove-columns span').click(function(){
        $(this).addClass('active');
        $('.add-remove-columns ul').show();
    });
 
    $('a.toggle-vis').on('click', function (e) {
        e.preventDefault();
 
        // Get the column API object
        var column = tableAP.column($(this).attr('data-column'));
 
        // Toggle the visibility
        column.visible(!column.visible());
        $(this).parent().toggleClass('active');
    });
    
    $(document).mouseup(function(e) 
    {
        var container = $(".add-remove-columns ul");
        if (!container.is(e.target) && container.has(e.target).length === 0) 
        {
            container.hide();
            $('.add-remove-columns span').removeClass('active');
        }
    });



    // Competency analysis
    $('th').on("click", function (event) {
        if($(event.target).is("input"))
            event.stopImmediatePropagation();
    });

    var tableAP = $('#data-ca').DataTable({
        "pageLength": 10,
        scrollY: '425px',
        scrollCollapse: true,
        scrollX: true,
		fixedColumns:   {
            left: 2
        },
dom: 'Bfrtip',
        buttons: [ 
{ extend: 'csv', text: 'Export to CSV', className: 'ecsvbutton', title:$('#filename10').val()+'('+completefile+')'  } 
        ]
    });

    $('#data-ca thead tr')
        .clone(true)
        .find('th')
        .removeClass('sorting_asc sorting_asc sorting')
        .off('click')
        .end()
        .appendTo('#data-ca thead');

    $('.dataTables_scrollHead .dataTable thead tr:eq(0) th').each(function (i) {
        var title = $(this).data('head');
        if (title) {
            $(this).append('<input type="text" placeholder="' + title + '" />');
        } else {
            $(this).append('');
        }

        $('input', this).on('keyup change', function () {
            if (tableAP.column(i).search() !== this.value) {
                tableAP
                    .column(i)
                    .search(this.value)
                    .draw();
            }
        });
    });

    $('.add-remove-columns span').click(function(){
        $(this).addClass('active');
        $('.add-remove-columns ul').show();
    });
 
    $('a.toggle-vis').on('click', function (e) {
        e.preventDefault();
 
        // Get the column API object
        var column = tableAP.column($(this).attr('data-column'));
 
        // Toggle the visibility
        column.visible(!column.visible());
        $(this).parent().toggleClass('active');
    });
    
    $(document).mouseup(function(e) 
    {
        var container = $(".add-remove-columns ul");
        if (!container.is(e.target) && container.has(e.target).length === 0) 
        {
            container.hide();
            $('.add-remove-columns span').removeClass('active');
        }
    });

    
});