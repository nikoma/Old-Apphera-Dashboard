var Theme = function () {
	
	var chartColors, validationRules = getValidationRules ();
	
	// Black & Orange
	//chartColors = ["#FF9900", "#333", "#777", "#BBB", "#555", "#999", "#CCC"];
	
	// Ocean Breeze
	chartColors = ['#94BA65', '#2B4E72', '#2790B0', '#777','#555','#999','#bbb','#ccc','#eee'];
	
	// Fire Starter
	//chartColors = ['#750000', '#F90', '#777', '#555','#002646','#999','#bbb','#ccc','#eee'];
	
	// Mean Green
	//chartColors = ['#5F9B43', '#DB7D1F', '#BA4139', '#777','#555','#999','#bbb','#ccc','#eee'];
	
	return { init: init, chartColors: chartColors, validationRules: validationRules };
	
	function init () {		
		enhancedAccordion ();
		
		if ($.fn.lightbox) { 
			$('.ui-lightbox').lightbox();			
		}
		
		if ($.fn.cirque) {
			$('.ui-cirque').cirque ({  });
		}
	
		$('#wrapper').append ('<div class="push"></div>');
	}
	
	function enhancedAccordion () {
		$('.accordion').on('show', function (e) {
	         $(e.target).prev('.accordion-heading').parent ().addClass('open');
	    });
	
	    $('.accordion').on('hide', function (e) {
	        $(this).find('.accordion-toggle').not($(e.target)).parents ('.accordion-group').removeClass('open');
	    });
	    
	    $('.accordion').each (function () {	    	
	    	$(this).find ('.accordion-body.in').parent ().addClass ('open');
	    });
	}
	
	function getValidationRules () {
		var custom = {
	    	focusCleanup: false,
			
			wrapper: 'div',
			errorElement: 'span',
			
			highlight: function(element) {
				$(element).parents ('.control-group').removeClass ('success').addClass('error');
			},
			success: function(element) {
				$(element).parents ('.control-group').removeClass ('error').addClass('success');
				$(element).parents ('.controls:not(:has(.clean))').find ('div:last').before ('<div class="clean"></div>');
			},
			errorPlacement: function(error, element) {
				error.appendTo(element.parents ('.controls'));
			}
	    	
	    };
	    
	    return custom;
	}
	
}();