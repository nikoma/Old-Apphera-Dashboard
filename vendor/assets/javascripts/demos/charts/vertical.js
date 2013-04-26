$(function () {
	
    var ds = [];
	var data = [];
	
	ds.push ([[1,25],[2,34],[3,37],[4,45],[5,56]]);
	ds.push ([[1,13],[2,29],[3,25],[4,23],[5,31]]);
	ds.push ([[1,8],[2,13],[3,19],[4,15],[5,14]]);
						
	data.push ({
		data: ds[0], 
		label: 'Finance', 
		bars: {
		barWidth: 0.15, 
			order: 1
		}
	});
	data.push	({
		data: ds[1], 
		label: 'Advertising & Marketing', 
		bars: {
		barWidth: 0.15, 
			order: 2
		}
	});
	data.push ({
		data: ds[2], 
		label: 'Manufacturing', 
		bars: {
		barWidth: 0.15, 
			order: 3
		}
	});
	
	Charts.vertical ('#vertical-chart', data);
				
});

