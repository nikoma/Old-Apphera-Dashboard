var chart; // global

Highcharts.setOptions({
    colors:['gray', '#50B432', 'red']
});

$(document).ready(function () {
    if ($('#home_review_chart').length != 0) {
        chart = new Highcharts.Chart({
            chart:{
                renderTo:"home_review_chart",
                plotBackgroundColor:null,
                plotBorderWidth:null,
                plotShadow:false
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
                        ['Positive', gon.positive_reviews],
                        ['Negative', gon.negative_reviews]

                    ]
                }
            ]
        });
    }
});