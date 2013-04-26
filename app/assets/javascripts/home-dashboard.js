var chart;
$(document).ready(function () {
    if ($('#activity_chart').length != 0) {
        chart = new Highcharts.Chart({
            chart:{
                renderTo:'activity_chart',
                plotBackgroundColor:null,
                plotBorderWidth:null,
                plotShadow:false,
                backgroundColor:null
            },
            title:{
                text:'Current Social Media Activity'
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
                            return '<b>' + this.point.name + '</b>: ' + this.percentage + ' %';
                        }
                    }
                }
            },
            series:[
                {
                    type:'pie',
                    name:'Activity',
                    data:[
                        ['Facebook Likes', 45],
                        ['Foursquare Tips', 26],
                        ['Reviews', 19],
                        ['Twitter Flw.', 68],
                        ['Others', 21]
                    ]
                }
            ]
        });
    }
})