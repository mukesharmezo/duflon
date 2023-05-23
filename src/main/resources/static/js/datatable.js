$(document).ready(function () {
    $('th').on("click", function (event) {
        if($(event.target).is("input"))
            event.stopImmediatePropagation();
    });

    
   
  
    var table = $('#data').DataTable({
        "pageLength": 10,
        scrollY: '425px',
        scrollCollapse: true,
        scrollX: true,
		fixedColumns:   {
            left: 2
        },
		dom: 'Bfrtip',
        buttons: [ 
{ extend: 'csv', text: 'Export to CSV', className: 'ecsvbuttonsd', title:$('#filename').val()} 
        ]
    });

	
	
    $('#data thead tr')
        .clone(true)
        .find('th')
        .removeClass('sorting_asc sorting_asc sorting')
        .off('click')
        .end()
        .appendTo('#data thead');

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

    // var dt = $('#data').DataTable();
    // dt.columns([0,2]).visible(false);
});
