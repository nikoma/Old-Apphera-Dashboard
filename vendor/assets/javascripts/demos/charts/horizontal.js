$(function () {
	
    var ds = [];
	var data = [];
	
	ds.push ([[25, 1],[34, 2],[37, 3],[45, 4],[56, 5]]);
	ds.push ([[13, 1],[29, 2],[25, 3],[23, 4],[31, 5]]);
	ds.push ([[8, 1],[13, 2],[19, 3],[15, 4],[14, 5]]);
							
	data.push ({
		data: ds[0], 
		label: 'Manufacturing', 
		bars: {
			order: 1
		}
	});
	
	data.push ({
		data: ds[1], 
		label: 'Energy & Utilities', 
		bars: {
			order: 2
		}
	});
	
	data.push ({
		data: ds[2], 
		label: 'Professional Services', 
		bars: { 
			order: 3
		}
	});
				
	Charts.horizontal ('#horizontal-chart', data);

});