// functions are called from chart partial

poppies = {
  // popovers in dashboard page
  popnow: function(){
    // === Popovers === //    
    var placement = 'bottom';
    var trigger = 'hover';
    var html = true;

    $('.popover-ambassadors').popover({
       placement: placement,
       content: '<span class="content-big">36094</span> <span class="content-small">Total Visits</span><br /><span class="content-big">220</span> <span class="content-small">Visits Today</span><br /><span class="content-big">200</span> <span class="content-small">Visits Yesterday</span><br /><span class="content-big">5677</span> <span class="content-small">Visits in This Month</span>',
       trigger: trigger,
       html: html   
    });
    $('.popover-points').popover({
       placement: placement,
       content: '<span class="content-big">1433</span> <span class="content-small">Total Users</span><br /><span class="content-big">0</span> <span class="content-small">Registered Today</span><br /><span class="content-big">0</span> <span class="content-small">Registered Yesterday</span><br /><span class="content-big">16</span> <span class="content-small">Registered Last Week</span>',
       trigger: trigger,
       html: html   
    });
    $('.popover-posts').popover({
       placement: placement,
       content: '<span class="content-big">8650</span> <span class="content-small">Total Orders</span><br /><span class="content-big">29</span> <span class="content-small">Pending Orders</span><br /><span class="content-big">32</span> <span class="content-small">Orders Today</span><br /><span class="content-big">64</span> <span class="content-small">Orders Yesterday</span>',
       trigger: trigger,
       html: html   
    });
    $('.popover-badges').popover({
       placement: placement,
       content: '<span class="content-big">2968</span> <span class="content-small">All Tickets</span><br /><span class="content-big">48</span> <span class="content-small">New Tickets</span><br /><span class="content-big">495</span> <span class="content-small">Solved</span>',
       trigger: trigger,
       html: html   
    });
  }
}

mainchart = {
  // main chart
  mychart: function(){
  // === Prepare the main chart data ===/
    var sin = [], cos = [];
    for (var i = 0; i < 90; i += 1) {
        sin.push([i, $('#serie_1 span.'+i).html()]);
        cos.push([i, $('#serie_2 span.'+i).html()]);
    }
  // === Make chart === //
    var plot = $.plot($(".chart"),
           [ { data: sin, label: $('#serie_1').attr('data-custom-label')}, { data: cos, label: $('#serie_2').attr('data-custom-label'), yaxis: 2 } ], {
               series: {
                   lines: { show: true },
                   points: { show: false }
               },
               grid: { hoverable: true, clickable: true },
               yaxes: [{min: 0, max: 10}, {min: 0, max: 50, position: 'right'}]
    });

    // === Point hover in chart === //
    var previousPoint = null;
    $(".chart").bind("plothover", function (event, pos, item) {
    
        if (item) {
            if (previousPoint != item.dataIndex) {
                previousPoint = item.dataIndex;
                
                $('#tooltip').fadeOut(200,function(){
          $(this).remove();
        });
                var x = item.datapoint[0].toFixed(2),
          y = item.datapoint[1].toFixed(2);
                    
                unicorn.flot_tooltip(item.pageX, item.pageY,item.series.label + " of " + x + " = " + y);
            }
            
        } else {
      $('#tooltip').fadeOut(200,function(){
          $(this).remove();
        });
            previousPoint = null;           
        }   
    }); 
  }
}

unicorn = {
    // === Peity charts === //
    peity: function(){    
      $.fn.peity.defaults.line = {
        strokeWidth: 1,
        delimeter: ",",
        height: 24,
        max: null,
        min: 0,
        width: 50
      };
      $.fn.peity.defaults.bar = {
        delimeter: ",",
        height: 24,
        max: null,
        min: 0,
        width: 50
      };
      $(".peity_line_good span").peity("line", {
        colour: "#B1FFA9",
        strokeColour: "#459D1C"
      });
      $(".peity_line_bad span").peity("line", {
        colour: "#FFC4C7",
        strokeColour: "#BA1E20"
      }); 
      $(".peity_line_neutral span").peity("line", {
        colour: "#CCCCCC",
        strokeColour: "#757575"
      });
      $(".peity_bar_good span").peity("bar", {
        colour: "#459D1C"
      });
      $(".peity_bar_bad span").peity("bar", {
        colour: "#BA1E20"
      }); 
      $(".peity_bar_neutral span").peity("bar", {
        colour: "#757575"
      });
    },

    // === Tooltip for flot charts === //
    flot_tooltip: function(x, y, contents) {
      
      $('<div id="tooltip">' + contents + '</div>').css( {
        top: y + 5,
        left: x + 5
      }).appendTo("body").fadeIn(200);
    }
}