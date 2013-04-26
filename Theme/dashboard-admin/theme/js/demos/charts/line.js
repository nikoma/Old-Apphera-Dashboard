$(function () {
	
	var d1 = [3.0, 3.0, 4.2, 4.4, 1.3, 2.9, 2.8, 1.9, 2.1, 3.4, 6.8, 8.1, 7.5, 7.1, 7.5, 9.5, 12.1, 12.4, 10.9, 10.4, 10.9, 9.1, 9.4, 10.5],
			d2 = [ 0.6, 1.2, 1.7, 0.7, 2.9, 4.1, 2.6, 3.7, 3.9, 1.7, 2.3, 3.0, 3.3, 4.8, 5.0, 4.8, 5.0, 3.2, 2.0, 2.4, 2.7, 3.5, 3.2, 2.8];			
				
	var dt1 = [], 
			dt2 = [], 
			st = new Date(2012, 8, 6).getTime();
	
	for( var i = 0; i < d2.length; i++ ) {
		dt1.push([st + i * 3600000, parseFloat( (d1[i]).toFixed( 3 ) )]);
		dt2.push([st + i * 3600000, parseFloat( (d2[i]).toFixed( 3 ) )]);
	}
	
	var data = [{ 
		data: dt1,
		label: 'Revenue'		
	 }, { 
	 	data: dt2, 
	 	label: 'Expenses', 
	 	points: { show: false }, 
	 	lines: { lineWidth: 2, fill: false }	 	
 	 }];
	
	Charts.line ( '#line-chart', data);
			
});