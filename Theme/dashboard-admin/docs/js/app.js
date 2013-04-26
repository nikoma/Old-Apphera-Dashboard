$(function () {
	
	$('pre').addClass ('prettyprint linenums');
	prettyPrint ();
	
	getToc ();
	
	routeContent ();
	
	$('#nav a').each (function (i) {
		
		if ($(this).parent ().is ('.misc')) { return; }
		
		var a = $(this).clone ();
		
		var shortcut = $('<a>', {
			'href': a.attr ('href'),
			'class': 'shortcut'			
		});
		
		var icon = $('<i>', {
			'class': 'shortcut-icon ' + a.find ('i').attr ('class')
		});
		
		var label = $('<span>', {
			'class': 'shortcut-label',
			'text': a.text ()
		});		
		
		icon.appendTo (shortcut);
		label.appendTo (shortcut);		
		shortcut.appendTo ('.shortcuts');
		
	});	
	
	$('body').append ('<div id="toTop">^ Back to Top</div>');
	
	
	$(window).bind ('hashchange', function (e) {
		routeContent ();
	});
	
	
	$('#nav a, .shortcuts a, .brand').live ('click', function (e) {		
		e.preventDefault ();
		
		if ($(this).is ('.external')) { 
			window.location = $(this).attr ('href');
			return false;
		}
				
		location.hash = $(this).attr ('href').split ('#')[1];		
	});
	
	$('#toTop').click(function() {
		$('body,html').animate({scrollTop:0},800);
	});
	
	$('a.third-party-doc').attr ('target', '_blank');
	
	
	
});

function routeContent () {
	
	var hash = location.hash;
	hash = hash.split ('#')[1];
	
	if (hash === undefined || hash === '') {
		hash = 'home';
	}
	
	$('#nav li').removeClass ('active');
	
	$('a[href=#' + hash + ']').parent ().addClass ('active');
	
	$('.content').hide ();
	
	var newPage = $('#' + hash + '-content').show ();
	
	if (newPage.length < 1) {
		$("#error-content").show ();
	}
		
			
	$('body,html').animate({scrollTop:0},0);
	
	$(window).scroll(function() {
		if($(this).scrollTop() != 0) {
			$('#toTop').fadeIn();	
		} else {
			$('#toTop').fadeOut();
		}
	});
 
	
}

function getToc () {
		
		
	$('.content').each (function (i) {
		
		var toc = '<ol class="toc">';
		
		$(this).find ('h3').each (function (i) {
			var h3, id, pageSlug, slug;
			
			h3 = $(this);
			pageSlug = slugify ($.trim ($(this).parents ('.content').find ('h1').text ()));
			id = slugify (h3.text ());
			slug = pageSlug + '-' + id;
			
			
			
			toc += '<li><a href="#' + slug + '">' + h3.text () + '</a></li>';
			
			h3.attr ('id', slug);
			h3.text ((i+1) + '. ' + h3.text ());

		});
		
		
		toc += '</ol>';
		
		$(this).find ('hr').eq (0).before (toc);
	});
		
	
	
	$('.toc').find ('a').bind ('click', function (e) {
		e.preventDefault ();	
		$.scrollTo ( $(this).attr ('href') , 1000 );
	});
}

function slugify(text) {
	text = text.replace(/[^-a-zA-Z0-9,&\s]+/ig, '');
	text = text.replace(/-/gi, "_");
	text = text.replace(/\s/gi, "-");
	text = text.toLowerCase ();
	return text;
}