$.extend($.tablesorter.themes.bootstrap, {
    // these classes are added to the table. To see other table classes available,
    // look here: http://twitter.github.com/bootstrap/base-css.html#tables
    table: 'table table-bordered',
    caption: 'caption',
    header: 'bootstrap-header', // give the header a gradient background
    footerRow: '',
    footerCells: '',
    icons: '', // add "icon-white" to make them white; this icon class is added to the <i> in the header
    sortNone: 'fa fa-sort',
    sortAsc: 'icon-chevron-up fa fa-sort-up',     // includes classes for Bootstrap v2 & v3
    sortDesc: 'icon-chevron-down fa fa-sort-down', // includes classes for Bootstrap v2 & v3
    active: '', // applied when column is sorted
    hover: '', // use custom css here - bootstrap class may not override it
    filterRow: '', // filter row class
    even: '', // odd row zebra striping
    odd: ''  // even row zebra striping
});

$(function () {
    $("table.tablesorter").tablesorter({
        theme: "bootstrap",
        headerTemplate: '{content} {icon}',
        //widthFixed: true,

        widgets: [ "uitheme", "filter", "zebra" ],
        widgetOptions: {
            // using the default zebra striping class name, so it actually isn't included in the theme variable above
            // this is ONLY needed for bootstrap theming if you are using the filter widget, because rows are hidden
            zebra: ["even", "odd"]
        }
    });

    $(document).on("click", "tbody.expand tr, table:has(tbody.expand) thead", function (e) {

        var info_box = $("tr#" + $(this).data('id'));
        var was_hidden = (info_box.css('display')=='none') ;
        console.log(was_hidden);
        info_box.insertAfter(this);
        $("tr.info").css('display', 'none');
        $("td.time").attr('rowspan', 1);
        if (was_hidden) {
            info_box.removeClass('filtered');
            info_box.css('display', 'table-row');
            $($(this).children()[0]).attr('rowspan', 2);
        }
    })

    $('#myTable.infinite').infiniteScrollHelper({
        bottomBuffer: 10,
        loadMore: function(page, done) {
            // you should use the page argument to either select an anchor/href and load
            // the contents of that url or make a call to an API that accepts a page number

            $.ajax({
                url: '/more',
                type: 'POST',
                data: {
                    page: page,
                    loadTime: $("#loadTime").data('time')
                },
                success: function (data) {
                    $(data).appendTo("#table_body");
                    console.log("loaded page" + page);

                    done();
                }
            });

            /*$.get('/more', function(data) {
                $(data).find('.items').appendTo('#my-element-to-watch');
                // call the done callback to let the plugin know you are done loading
                done();
            });

            // or an API perhaps
            $.getJSON('http://myawesomeapi.com/data?p=' + page, function(data) {
                // parse json data and create new html then append

                done();
            });*/
        }
    });
});
