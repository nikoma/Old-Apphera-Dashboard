var chart; // global

var chartreviews;

$(document).ready(function () {
    if ($('#reviewchart').length != 0) {
        chart = new Highcharts.Chart({
            chart:{
                renderTo:'reviewchart',
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
                        ['Neutral', 33],
                        ['Negative', 22],
                        ['Positive', 11]

                    ]
                }
            ]
        });
    }
});