$(document).ready(function () {
    if ($('#review_chart').length != 0) {
        var chart;
        chart = new Highcharts.Chart({
            chart:{
                renderTo:'review_chart',
                plotBackgroundColor:null,
                plotBorderWidth:null,
                plotShadow:false,
                backgroundColor:null
            },
            title:{
                text:'Reviews'
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
                            return '<b>' + this.point.name + '</b>';
                        }
                    }
                }
            },
            series:[
                {
                    type:'pie',
                    name:'Activity',
                    data:[
                        ['Neutral', gon.neutral_reviews],
                        ['Negative', gon.negative_reviews],
                        ['Positive', gon.positive_reviews]

                    ]
                }
            ]
        });
    }
})