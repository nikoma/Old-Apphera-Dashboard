$(function () {
	
var data = [
	{ label: "Manufacturing", data: Math.floor (Math.random() * 100 + 650) }, 
	{ label: "Finance", data: Math.floor (Math.random() * 100 + 250) }, 
	{ label: "Energy & Utilities", data: Math.floor (Math.random() * 100 + 50) }
];
			
Charts.donut ('#donut-chart', data);
	
});