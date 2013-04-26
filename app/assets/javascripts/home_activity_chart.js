var chart;
$(document).ready(function () {
    if ($('#home_activity_chart').length != 0) {
        // // Radialize the colors
        //        Highcharts.getOptions().colors = $.map(Highcharts.getOptions().colors, function(color) {
        //            return {
        //                radialGradient: { cx: 0.5, cy: 0.3, r: 0.7 },
        //                stops: [
        //                    [0, color],
        //                    [1, Highcharts.Color(color).brighten(-0.3).get('rgb')] // darken
        //                ]
        //            };
        //        });

        // Build the chart
        chart = new Highcharts.Chart({
            chart:{
                renderTo:'home_activity_chart',
                plotBackgroundColor:null,
                plotBorderWidth:null,
                plotShadow:false
            },
            title:{
                text:'Social Activities'
            },
            tooltip:{
                pointFormat:'{series.name}: <b>{point.percentage}%</b>',
                percentageDecimals:1
            },
            plotOptions:{
                pie:{
                    allowPointSelect:true,
                    cursor:'pointer',
                    dataLabels:{
                        enabled:true,
                        color:'#000000',
                        connectorColor:'#000000',
                        formatter:function () {
                            return '<b>' + this.point.name + '</b>: ' + Math.round(this.percentage) + ' %';
                        }
                    }
                }
            },
            series:[
                {
                    type:'pie',
                    name:'Activities',
                    data:[
                        ['Fans', gon.followers],
                        ['Checkins', gon.fs_checkins],
                        ['Tips', gon.fs_tips],
                        ['Tweets', gon.reviews]
                    ]
                }
            ]
        });
    }
})