$(function () {
	
	/*--------------------------------------------------
	Plugin: Date Picker
	--------------------------------------------------*/
	
	$( "#datepicker-inline" ).datepicker();
	
	$( "#datepicker-multi" ).datepicker({
		numberOfMonths: 2,
		showButtonPanel: true
	});
	
	/*--------------------------------------------------
	Plugin: Slider
	--------------------------------------------------*/
		
	/* Increment Slider */
	$( "#incrementSlider" ).slider({
		range: "min",
		value:150,
		min: 0,
		max: 500,
		step: 50,
		slide: function( event, ui ) {
			$( "#incrementAmount" ).text ( "$" + ui.value );
		}
	});
		
	$( "#incrementAmount" ).text ( "$" + $( "#incrementSlider" ).slider( "value" ) );
		
		
	
	/* Min Value Slider */
	$( "#rangeMinSlider" ).slider({
		range: "min",
		value: 100,
		min: 50,
		max: 700,
		slide: function( event, ui ) {
			$( "#rangeMinAmount" ).text ( "$" + ui.value );
		}
	});
	
	$( "#rangeMinAmount" ).text ( "$" + $( "#rangeMinSlider" ).slider( "value" ) );
		
		
	/* Default Slider */
	$( "#defaultSlider" ).slider({ value: 65, range: 'min' });
	
	
	
	/* Vertical Slider */	
	$("#eq > span").each(function() {
		var value = parseInt($(this).text());
		$(this).empty().slider({
			value: value,
			range: "min",
			animate: true,
			orientation: "vertical"
		});
	});
    

	/* Horizontal Slider */
	$( "#rangeSlider" ).slider({
		range: true,
		min: 0,
		max: 500,
		values: [ 75, 250 ],
		slide: function( event, ui ) {
			$( "#amount" ).text ( "$" + ui.values[ 0 ] + " - $" + ui.values[ 1 ] );
		}
	});
				
	$( "#amount" ).text( "$" + $( "#rangeSlider" ).slider( "values", 0 ) +
		" - $" + $( "#rangeSlider" ).slider( "values", 1 ) );
	
	
});