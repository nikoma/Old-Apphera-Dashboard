var Charts = function () {
	
	var colors = Theme.chartColors;
	
	return { 
		vertical: vertical,
		horizontal: horizontal,
		pie: pie,
		donut: donut,
		line: line
	};
	
	function vertical (target, data) {
		var options = {
			colors: colors,
	
			grid: {
				hoverable: true, 
				borderWidth: 2
			}, 
			bars: {
				horizontal: false, 
				show: true, 
				align: 'center', 
				lineWidth: 0,
				fillColor: { colors: [ { opacity: 1 }, { opacity: 0.5 } ] }
			}, 
			legend: {
				show: true
			},
			
			tooltip: true,
			tooltipOpts: {
				content: '%s: %y'
			},
		};
	
		var el = $(target);
		
		if (el.length) {
			$.plot(el, data, options );
		}
	}
	
	function horizontal (target, data) {
		var options = {
					colors: colors,

					grid: {
						hoverable: true, 
						borderWidth: 2
					}, 
					bars: {
						horizontal: true, 
						show: true, 
						align: 'center', 
						barWidth: .2,
						lineWidth: 0,
						fillColor: { colors: [ { opacity: 1 }, { opacity: 1} ] }
					}, 
					legend: {
						show: true
					},
			
					tooltip: true,
					tooltipOpts: {
						content: '%s: %y'
					},
				};
			
			var el = $(target);
				
				if (el.length) {
					$.plot(el, data, options );
				}
	}
	
	function pie (target, data) {
		var options = {
			colors: colors,
			
			series: {
				pie: {
					show: true,  
					innerRadius: 0, 
					stroke: {
						width: 4
					}
				}
			}, 
				
			legend: {
				position: 'ne'
			}, 
			
			tooltip: true,
			tooltipOpts: {
				content: '%s: %y'
			},
			
			grid: {
				hoverable: true
			}
		};

		var el = $(target);
				
			if (el.length) {
				$.plot(el, data, options );
			}
	}
	
	function donut (target, data) {
		var options = {
			colors: colors,
			
			series: {
				pie: {
					show: true,  
					innerRadius: .5, 
					stroke: {
						width: 4
					}
				}
			}, 
				
			legend: {
				position: 'ne'
			}, 
			
			tooltip: true,
			tooltipOpts: {
				content: '%s: %y'
			},
			
			grid: {
				hoverable: true
			}
		};
		
		var el = $(target);
						
		if (el.length) {
			$.plot(el, data, options );
		}
	}
	
	function line (target, data) {
		var options = {
				colors: colors,
				series: {
					lines: { 
						show: true, 
						fill: true, 
						lineWidth: 4, 
						steps: false, 
						fillColor: { colors: [{opacity: 0.4}, {opacity: 0}] } 
					},
					points: { 
						show: true, 
						radius: 4, 
						fill: true
					}
				}, 
				legend: {
					position: 'ne'
				},
				tooltip: true,
				tooltipOpts: {
					content: '%s: %y'
				},
				xaxis: { mode: "time" }, 
				grid: { borderWidth: 2, hoverable: true }
			};
			
			var el = $(target);
				
				if (el.length) {
					$.plot(el, data, options );
				}
	}
}();