$(function () {
	
var data = [
	{ label: "Manufacturing", data: Math.floor (Math.random() * 100 + 250) }, 
	{ label: "Finance", data: Math.floor (Math.random() * 100 + 350) }, 
	{ label: "Energy & Utilities", data: Math.floor (Math.random() * 100 + 650) }, 
	{ label: "Advertising & Marketing", data: Math.floor (Math.random() * 100 + 50) },
	{ label: "Professional Services", data: Math.floor (Math.random() * 100 + 250) }
];
			
Charts.pie ('#pie-chart', data);
	
});