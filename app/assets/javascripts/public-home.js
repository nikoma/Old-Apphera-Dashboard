// var chart; // global
// 
// $(window).load(function() {
// 
//     chart = new Highcharts.Chart({
//         chart: {
//             renderTo: 'realtime_chart_home',
//             defaultSeriesType: 'spline',
//             events: {
//                 load: requestData
//             }
//         },
//         title: {
//             text: 'Realtime view Apphera analyzed items per second'
//         },
//         xAxis: {
//             type: 'datetime',
//             tickPixelInterval: 150,
//             maxZoom: 20 * 1000
//         },
//         yAxis: {
//             minPadding: 0.2,
//             maxPadding: 0.2,
//             title: {
//                 text: 'Items',
//                 margin: 80
//             }
//         },
//         series: [{
//             name: 'Processed items',
//             data: []
//         }]
//     });        
// });
// function requestData() {
// 
//     $.ajax({
//         url: '/examples/network.json',
//         success: function(point) {
//             var series = chart.series[0],
//                 shift = series.data.length > 20; // shift if the series is longer than 20
// 
//             // add the point
//             chart.series[0].addPoint(point, true, shift);
// 
//             // call it again after one second
//             setTimeout(requestData, 1000);
//         },
//         cache: false
//     });
// }
