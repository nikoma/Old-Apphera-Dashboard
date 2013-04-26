/*!
 * jQuery Lightbox Evolution - for jQuery 1.3+
 * http://codecanyon.net/item/jquery-lightbox-evolution/115655?ref=aeroalquimia
 *
 * Copyright (c) 2010, Eduardo Daniel Sada
 * Released under CodeCanyon Regular License.
 * http://codecanyon.net/licenses/regular_extended
 *
 * Version: 1.6.5 (May 28 2012)
 *
 * Includes jQuery Easing v1.3
 * http://gsgd.co.uk/sandbox/jquery/easing/
 * Copyright (c) 2008, George McGinley Smith
 * Released under BSD License.
 */

(function($) {
  
  var uagent        = (navigator && navigator.userAgent) ? navigator.userAgent.toLowerCase() : "";
  var is_ie6        = ($.browser.msie && parseInt($.browser.version, 10) < 7 && parseInt($.browser.version, 10) > 4);
  var is_smartphone = false;

  // detect android;
  if (uagent.search("mobile") > -1) {
    if (uagent.search("android") > -1 || uagent.search("googletv") > -1 || uagent.search("htc_flyer") > -1) {
      is_smartphone = true;
    }
  };

  // detect opera mini and mobile;
  if (uagent.search("opera") > -1) {
    if (uagent.search("mini") > -1 && uagent.search("mobi") > -1) {
      is_smartphone = true;
    }
  };

  // detect iOS;
  if (uagent.search("iphone") > -1) {
    is_smartphone = true;
  };

  // detect windows 7 phones;
  if (uagent.search("windows phone os 7") > -1) {
    is_smartphone = true;
  };

  // for jQuery 1.3;
  if ($.proxy === undefined) {
    $.extend({
      proxy: function( fn, thisObject ) {
        if ( fn ) {
          proxy = function() { return fn.apply(thisObject || this, arguments); };
        };
        return proxy;
      }
    });
  };
    
  // for jQuery 1.3;
  $.extend($.fx.prototype, {
    update: function() {
      if ( this.options.step ) {
        this.options.step.call( this.elem, this.now, this );
      }

      (jQuery.fx.step[this.prop] || jQuery.fx.step._default)( this );
    }
  });
	
  // jQuery Easing v1.3;
  $.extend($.easing, {
    easeOutBack: function (x, t, b, c, d, s) {
      if (s == undefined) s = 1.70158;
      return c*((t=t/d-1)*t*((s+1)*t + s) + 1) + b;
    }
  });

  $.extend({
    LightBoxObject: {
      defaults: {
        name  : 'jquery-lightbox',
        style : {
          zIndex : 99999,
          width  : 470,
          height : 280
        },
        modal    : false,
        overlay  : {
          opacity: 0.6
        },
        animation: {
          show: {
            duration: 400,
            easing  : "easeOutBack"
          },
          close: {
            duration: 200,
            easing  : "easeOutBack"
          },
          move: {
            duration: 800,
            easing  : "easeOutBack"
          },
          shake: {
            duration : 100,
            easing   : "easeOutBack",
            distance : 10,
            loops    : 2
          }
        },
        flash        : {
          width  : 640,
          height : 360
        },
        iframe       : {
          width  : 640,
          height : 360
        },
        emergefrom   : "top",
        ajax         : {
          type     : "GET",
          cache    : false,
          dataType : "html"
        }
      },
      options     : {},
      animations  : {},
      gallery     : {},
      image       : {},
      esqueleto   : {
        lightbox    : [],
        buttons     : {
          close     : [],
          prev      : [],
          max       : [],
          next      : []
        },
        background  : [],
        image       : [],
        title       : [],
        html        : []
      },
      visible     : false,
      maximized   : false,
      mode        : "image",
      videoregs   : {
        swf: {
          reg: /[^\.]\.(swf)\s*$/i
        },
        youtube: {
          reg: /youtube.com\/watch/i,
          split: '=',
          index: 1,
          iframe: 1,
          url: "http://www.youtube.com/embed/%id%?autoplay=1&amp;fs=1&amp;rel=0&amp;enablejsapi=1"
        },
        youtu: {
          reg: /youtu.be\//i,
          split: '/',
          index: 3,
          iframe: 1,
          url: "http://www.youtube.com/embed/%id%?autoplay=1&amp;fs=1&amp;rel=0&amp;enablejsapi=1"
        },
        metacafe: {
          reg: /metacafe.com\/watch/i,
          split: '/',
          index: 4,
          url: "http://www.metacafe.com/fplayer/%id%/.swf?playerVars=autoPlay=yes"
        },
        dailymotion: {
          reg: /dailymotion.com\/video/i,
          split: '/',
          index: 4,
          url: "http://www.dailymotion.com/swf/video/%id%?additionalInfos=0&amp;autoStart=1"
        },
        google: {
          reg: /google.com\/videoplay/i,
          split: '=',
          index: 1,
          url: "http://video.google.com/googleplayer.swf?autoplay=1&amp;hl=en&amp;docId=%id%"
        },
        vimeo: {
          reg: /vimeo.com/i,
          split: '/',
          index: 3,
          iframe: 1,
          url: "http://player.vimeo.com/video/%id%?hd=1&amp;autoplay=1&amp;show_title=1&amp;show_byline=1&amp;show_portrait=0&amp;color=&amp;fullscreen=1"
        },
        gametrailers: {
          reg: /gametrailers.com/i,
          split: '/',
          index: 5,
          url: "http://www.gametrailers.com/remote_wrap.php?mid=%id%"
        },
        collegehumornew: {
          reg: /collegehumor.com\/video\//i,
          split: 'video/',
          index: 1,
          url: "http://www.collegehumor.com/moogaloop/moogaloop.jukebox.swf?autostart=true&amp;fullscreen=1&amp;use_node_id=true&amp;clip_id=%id%"
        },
        collegehumor: {
          reg: /collegehumor.com\/video:/i,
          split: 'video:',
          index: 1,
          url: "http://www.collegehumor.com/moogaloop/moogaloop.swf?autoplay=true&amp;fullscreen=1&amp;clip_id=%id%"
        },
        ustream: {
          reg: /ustream.tv/i,
          split: '/',
          index: 4,
          url: "http://www.ustream.tv/flash/video/%id%?loc=%2F&amp;autoplay=true&amp;vid=%id%&amp;disabledComment=true&amp;beginPercent=0.5331&amp;endPercent=0.6292&amp;locale=en_US"
        },
        twitvid: {
          reg: /twitvid.com/i,
          split: '/',
          index: 3,
          url: "http://www.twitvid.com/player/%id%"
        },
        wordpress: {
          reg: /v.wordpress.com/i,
          split: '/',
          index: 3,
          url: "http://s0.videopress.com/player.swf?guid=%id%&amp;v=1.01"
        },
        vzaar: {
          reg: /vzaar.com\/videos/i,
          split: '/',
          index: 4,
          url: "http://view.vzaar.com/%id%.flashplayer?autoplay=true&amp;border=none"
        }
      },
      
      mapsreg: {
        bing: {
          reg: /bing.com\/maps/i,
          split: '?',
          index: 1,
          url: "http://www.bing.com/maps/embed/?emid=3ede2bc8-227d-8fec-d84a-00b6ff19b1cb&amp;w=%width%&amp;h=%height%&amp;%id%"
        },
        streetview: {
          reg: /maps.google.com(.*)layer=c/i,
          split: '?',
          index: 1,
          url: "http://maps.google.com/?output=svembed&amp;%id%"
        },
        googlev2: {
          reg: /maps.google.com\/maps\/ms/i,
          split: '?',
          index: 1,
          url: "http://maps.google.com/maps/ms?output=embed&amp;%id%"
        },
        google: {
          reg: /maps.google.com/i,
          split: '?',
          index: 1,
          url: "http://maps.google.com/maps?%id%&amp;output=embed"
        }
      },
      
      imgsreg: /\.(jpg|jpeg|gif|png|bmp|tiff)(.*)?$/i,
      
      overlay : {
        create: function(options) {
          this.options = options;
          this.element = $('<div id="'+new Date().getTime()+'" class="'+this.options.name+'-overlay"></div>');
          this.element.css($.extend({}, {
            'position'  : 'fixed',
            'top'       : 0,
            'left'      : 0,
            'opacity'   : 0,
            'display'   : 'none',
            'z-index'   : this.options.zIndex
          }, this.options.style));

          this.element.click($.proxy(function(e) {
            if (!this.options.modal)
            {
              if ($.isFunction(this.options.callback))
              {
                this.options.callback();
              }
              else
              {
                this.hide();
              }
            }
            e.preventDefault();
          }, this));
          
          this.hidden = true;
          this.inject();
          return this;
        },

        inject: function() {
          this.target = $(document.body);
          this.target.append(this.element);

          if (is_ie6) {
            this.element.css('position', 'absolute');
            var zIndex = parseInt(this.element.css('zIndex'));
            if (!zIndex)
            {
              zIndex = 1;
              var pos = this.element.css('position');
              if (pos == 'static' || !pos)
              {
                this.element.css('position', 'relative');
              }
              this.element.css('zIndex', zIndex);
            }

            zIndex = (!!(this.options.zIndex || this.options.zIndex === 0) && zIndex > this.options.zIndex) ? this.options.zIndex : zIndex - 1;
            if (zIndex < 0)
            {
              zIndex = 1;
            }

            this.shim = $('<iframe id="IF_'+new Date().getTime()+'" scrolling="no" frameborder=0 src=""></iframe>');
            this.shim.css({
              zIndex    : zIndex,
              position  : 'absolute',
              top       : 0,
              left      : 0,
              border    : 'none',
              width     : 0,
              height    : 0,
              opacity   : 0
            });

            this.shim.insertAfter(this.element);
            $('html, body').css({
              'height'      : '100%',
              'width'       : '100%',
              'margin-left' : 0,
              'margin-right': 0
            });
          }
        },

        resize: function(x, y) {
          this.element.css({ 'height': 0, 'width': 0 });
          if (this.shim) { this.shim.css({ 'height': 0, 'width': 0 }); };

          var win = { x: $(document).width(), y: $(document).height() };
          
          this.element.css({
            'width'   : '100%',
            'height'  : y ? y : win.y
          });
          
          if (this.shim)
          {
            this.shim.css({ 'height': 0, 'width': 0 });
            this.shim.css({
              'position': 'absolute',
              'left'    : 0,
              'top'     : 0,
              'width'   : this.element.width(),
              'height'  : y ? y : win.y
            });
          }
          return this;
        },

        show: function(callback) {
          if (!this.hidden) { return this; };
          if (this.transition) { this.transition.stop(); };
          if (this.shim) { this.shim.css('display', 'block'); };
          this.element.css({'display':'block', 'opacity':0});

          this.target.bind('resize', $.proxy(this.resize, this));
          this.resize();
          this.hidden = false;

          this.transition = this.element.fadeTo(this.options.showDuration, this.options.style.opacity, $.proxy(function(){
            if (this.options.style.opacity) { this.element.css(this.options.style) };
            this.element.trigger('show');
            if ($.isFunction(callback)) { callback(); };
          }, this));
          
          return this;
        },

        hide: function(callback) {
          if (this.hidden) { return this; };
          if (this.transition) { this.transition.stop(); };
          if (this.shim) { this.shim.css('display', 'none'); };
          this.target.unbind('resize');
          this.hidden = true;

          this.transition = this.element.fadeTo(this.options.closeDuration, 0, $.proxy(function(){
            this.element.trigger('hide');
            if ($.isFunction(callback)) { callback(); };
            this.element.css({ 'height': 0, 'width': 0, 'display': 'none' });
          }, this));

          return this;
        }
      },

      create: function(options) {
        this.options = $.extend(true, this.defaults, options);

        var name     = this.options.name;
        var lightbox = $('<div class="'+name+' '+name+'-mode-image"><div class="'+name+'-border-top-left"></div><div class="'+name+'-border-top-middle"></div><div class="'+name+'-border-top-right"></div><a class="'+name+'-button-close" href="#close"><span>Close</span></a><div class="'+name+'-navigator"><a class="'+name+'-button-left" href="#"><span>Previous</span></a><a class="'+name+'-button-right" href="#"><span>Next</span></a></div><div class="'+name+'-buttons"><div class="'+name+'-buttons-init"></div><a class="'+name+'-button-left" href="#"><span>Previous</span></a><a class="'+name+'-button-max" href="#"><span>Maximize</span></a><div class="'+name+'-buttons-custom"></div><a class="'+name+'-button-right" href="#"><span>Next</span></a><div class="'+name+'-buttons-end"></div></div><div class="'+name+'-background"></div><div class="'+name+'-html"></div><div class="'+name+'-border-bottom-left"></div><div class="'+name+'-border-bottom-middle"></div><div class="'+name+'-border-bottom-right"></div></div>');
        var e        = this.esqueleto;

        this.overlay.create({
          name          : name,
          style         : this.options.overlay,
          modal         : this.options.modal,
          zIndex        : this.options.style.zIndex-1,
          callback      : this.proxy(this.close),
          showDuration  : (is_smartphone ? 2 : this.options.animation.show.duration),
          closeDuration : (is_smartphone ? 2 : this.options.animation.close.duration)
        });
        
        e.lightbox       = lightbox;
        e.navigator      = $('.'+name+'-navigator', lightbox);
        e.buttons.div    = $('.'+name+'-buttons', lightbox);
        e.buttons.close  = $('.'+name+'-button-close', lightbox);
        e.buttons.prev   = $('.'+name+'-button-left', lightbox);
        e.buttons.max    = $('.'+name+'-button-max', lightbox);
        e.buttons.next   = $('.'+name+'-button-right', lightbox);
        e.buttons.custom = $('.'+name+'-buttons-custom', lightbox);
        e.background     = $('.'+name+'-background', lightbox);
        e.html           = $('.'+name+'-html', lightbox);

        e.move           = $('<div class="'+name+'-move"></div>').css({
          'position' : 'absolute',
          'z-index'  : this.options.style.zIndex,
          'top'      : -999
        }).append(lightbox);
        
        $('body').append(e.move);

        // this.win = (window!=window.top) ? window.top : window;
        this.win = $(window);
        
        this.addevents();
        return lightbox;
      },

      addevents: function() {
        var $win  = this.win;

        $win[0].onorientationchange = function() { 
          $win.trigger('resize');
        };
        
        $win.bind('resize', this.proxy(function() {
          if (this.visible)
          {
            this.overlay.resize();
            if (!this.maximized)
            {
              this.movebox();
            }
          }
        }));

        $win.bind('scroll', this.proxy(function() {
          if (this.visible && !this.maximized)
          {
            this.movebox();
          }
        }));

        $(document).bind('keydown', this.proxy(function(e) {
          if (this.visible)
          {
            if (e.keyCode == 27 && this.options.modal == false) // esc
            {
              this.close();
            }

            if (this.gallery.total > 1)
            {
              if (e.keyCode == 37) // left
              {
                this.esqueleto.buttons.prev.triggerHandler('click', e);
              }

              if (e.keyCode == 39) // right
              {
                this.esqueleto.buttons.next.triggerHandler('click', e);
              }
            }
          }
        }));
        
        this.esqueleto.buttons.close.bind('click touchend', {"fn": "close"}, this.proxy(this.fn));

        this.esqueleto.buttons.max.bind('click touchend', {"fn": "maximinimize"}, this.proxy(this.fn));
        
        // heredamos los eventos, desde el overlay:
        this.overlay.element.bind('show', this.proxy(function() {
          $(this).triggerHandler('show');
        }));
        
        this.overlay.element.bind('hide', this.proxy(function() {
          $(this).triggerHandler('close');
        }));
      },

      fn: function(e) {
        this[e.data.fn].apply(this);
        e.preventDefault();
      },

      proxy: function(fn) {
        return $.proxy(fn, this);
      },
      
      ex: function(ob, href, options) {
        var tmp = {
          type   : "",
          width  : "",
          height : "",
          href   : ""
        };

        $.each(ob, this.proxy(function(is, reg) {

          $.each(reg, this.proxy(function(i, e) {
            if ((is == "flash" && href.split('?')[0].match(e.reg)) || (is == "iframe" && href.match(e.reg)))
            {
              tmp.href = href;
              if (e.split)
              {
                var id   = is == "flash" ? href.split(e.split)[e.index].split('?')[0].split('&')[0] : href.split(e.split)[e.index];
                tmp.href = e.url.replace("%id%", id).replace("%width%", options.width).replace("%height%", options.height);;
              }

              tmp.type   = e.iframe ? "iframe" : is;
              tmp.width  = options.width || this.options[tmp.type].width;
              tmp.height = options.height || this.options[tmp.type].height;
              return false;
            }
          }));

          if (!!tmp.type) return false;

        }));

        return tmp;
      },
      
      create_gallery: function(href) {
        var $prev = this.esqueleto.buttons.prev;
        var $next = this.esqueleto.buttons.next;

        if ($.isArray(href) && href.length > 1)
        {
          this.gallery.images   = href;
          this.gallery.current  = 0;
          this.gallery.total    = href.length;
          href                  = href[0];

          $prev.unbind('click');
          $next.unbind('click');

          $prev.bind('click touchend', this.proxy(function(e){
            if (this.gallery.current - 1 < 0)
            {
              this.gallery.current = this.gallery.total - 1;
            }
            else
            {
              this.gallery.current = this.gallery.current - 1;
            }

            this.show(this.gallery.images[this.gallery.current]);
            e.preventDefault();
          }));

          $next.bind('click touchend', this.proxy(function(e){
            if (this.gallery.current + 1 >= this.gallery.total)
            {
              this.gallery.current = 0;
            }
            else
            {
              this.gallery.current = this.gallery.current + 1;
            }

            this.show(this.gallery.images[this.gallery.current]);
            e.preventDefault();
          }));
        }
        
        if (this.gallery.total > 1)
        {
          if (this.esqueleto.navigator.css("display") == "none")
          {
            this.esqueleto.buttons.div.show();
          }

          $prev.show();
          $next.show();
        }
        else
        {
          $prev.hide();
          $next.hide();
        }
      },
      
      custombuttons: function(buttons, anchor) {
        $.each(buttons, this.proxy(function(i, button) {

          var $a = $('<a href="#" class="'+button['class']+'">'+button['html']+'</a>');
          $a.bind('click', this.proxy(function(e) {
            if ($.isFunction(button.callback))
            {
              anchor = typeof anchor === "undefined" ? false : anchor[this.gallery.current || 0];
              button.callback(this.esqueleto.image.src, this, anchor);
            }
            e.preventDefault();
          }));

          this.esqueleto.buttons.custom.append($a);

        }));
        this.esqueleto.buttons.div.show();
      },
      
      show: function(href, options, callback, anchor) {
        var type       = '';
        var beforeopen = false;
        
        // is inline content? lightbox($("<div/>"));
        if (typeof href === "object" && href[0].nodeType)
        {
          var tmpElement = href;
          href = "#";
          type = 'element';
        }
        
        //is it an array and is it empty?
        if (($.isArray(href) && href.length <= 1) || href=='')
        {
          return false;
        };
        
        this.loading();
        beforeopen = this.visible;
        this.open();

        if (!beforeopen)
        {
          this.movebox();
        }
                
        // create gallery buttons and show the first image
        this.create_gallery(href, options);
        if ($.isArray(href) && href.length > 1)
        {
          href = href[0];
        }
        
        var temp  = href.split("%LIGHTBOX%");
        var href  = temp[0];
        var title = temp[1] || '';

        options = $.extend(true, {
          'width'      : 0,
          'height'     : 0,
          'modal'      : 0,
          'force'      : '',
          'title'      : title,
          'autoresize' : true,
          'move'       : -1,
          'iframe'     : false,
          'flashvars'  : '',
          'cufon'      : true,
          'onOpen'     : function() {},
          'onClose'    : function() {}
        }, options || {});
        
        // callbacks
        this.options.onOpen   = options.onOpen;
        this.options.onClose  = options.onClose;

        this.options.cufon    = options.cufon;
        
        urloptions = this.unserialize(href);
        options    = $.extend({}, options, urloptions);

        var size   = {
          x: this.win.width(),
          y: this.win.height()
        };

        // calcular porcentajes si es que existen:
        if (options.width && (""+options.width).indexOf("p") > 0)
        {
          options.width = (size.x-20) * options.width.substring(0, options.width.indexOf("p")) / 100;
        }

        if (options.height && (""+options.height).indexOf("p") > 0)
        {
          options.height = (size.y-20) * options.height.substring(0, options.height.indexOf("p")) / 100;
        }
        
        this.overlay.options.modal = options.modal;

        this.esqueleto.buttons.max.removeClass(this.options.name+'-button-min').addClass(this.options.name+'-button-max');

        this.maximized = !(options.move > 0 || (options.move == -1 && options.autoresize));
                
        if ($.isArray(options.buttons))
        {
          this.custombuttons(options.buttons, anchor);
        }
        
        if (!this.esqueleto.buttons.custom.is(":empty"))
        {
          this.esqueleto.buttons.div.show();
        }
        
        if (options.force != '')
        {
          type = options.force;
        }
        else if (options.iframe)
        {
          type = 'iframe';
        }
        else if (href.match(this.imgsreg))
        {
          type = 'image';
        }
        else
        {

          // Detectar si es un flash o un mapa o un video:
          var zap = this.ex({"flash": this.videoregs, "iframe": this.mapsreg}, href, options);
          if (!!zap.type)
          {
            href           = zap.href;
            type           = zap.type;
            options.width  = zap.width;
            options.height = zap.height;
          }

          // Si todavia no sabemos que es, lo mas probable es que sea una url ajax o un #inline:
          if (!!type == false)
          {
            if (href.match(/#/))
            {
              obj = href.substr(href.indexOf("#"));
              if ($(obj).length > 0)
              {
                type = 'inline';
                href = obj;
              }
              else
              {
                type = 'ajax';
              }
            }
            else
            {
              type = 'ajax';
            }
          }
        }

        if (type == 'image')
        {
          this.esqueleto.buttons.max.hide();

          this.esqueleto.image = new Image();

          $(this.esqueleto.image).load(this.proxy(function() {
            var image = this.esqueleto.image;
            $(image).unbind('load');
            
            if (!this.visible)
            {
              return false
            }
            
            // Si el tamaño viene definido en los parametros:
            if (options.width)
            {
              width   = parseInt(options.width);
              height  = parseInt(options.height);
            }
            // Si no sabemos el tamaño, entonces lo calcularemos:
            else
            {
              if (options.autoresize)
              {
                var objsize = this.calculate(image.width, image.height);
                width   = objsize.width;
                height  = objsize.height;

                // Si el tamaño calculado no coincide con el tamaño real, mostraremos la botonera para "agrandar" imagen:
                if (image.width != width || image.height != height)
                {
                  this.esqueleto.buttons.div.show();
                  this.esqueleto.buttons.max.show();
                }
              }
              else
              {
                width   = image.width;
                height  = image.height;
              }
            }

            this.esqueleto.title = (options.title == '') ? null : $('<div class="'+this.options.name+'-title"></div>').html(options.title);

            this.loadimage();

            this.resize(width, height);
          }));
          
          this.esqueleto.image.onerror = this.proxy(function() {
            this.error("The requested image cannot be loaded. Please try again later.");
          });
          
          this.esqueleto.image.src = href;
        }
        else if (type=='flash' || type=='inline' || type=='ajax' || type=='element')
        {
          if (type == 'inline')
          {
            var html = $(href).clone(true).show();
            width    = options.width > 0 ? options.width : $(href).outerWidth(true);
            height   = options.height > 0 ? options.height : $(href).outerHeight(true);
            this.appendhtml(html, width, height);
          }
          else if (type == 'ajax')
          {
            if (options.width)
            {
              width   = options.width;
              height  = options.height;
            }
            else
            {
              this.error("You have to specify the size. Add ?lightbox[width]=600&lightbox[height]=400 at the end of the url.");
              return false;
            }

            if (this.animations.ajax)
            {
              this.animations.ajax.abort();
            }

            this.animations.ajax = $.ajax($.extend({}, this.options.ajax, {
              "url"      : href,
              "error"    : this.proxy(function(jqXHR, textStatus, errorThrown) {
                this.error("AJAX Error " + jqXHR.status + " " + errorThrown);
              }),
              "success"  : this.proxy(function(html) {
                this.appendhtml($(html), width, height);
              })
            }));
          
          }
          else if (type == 'flash')
          {
            var flash = this.swf2html(href, options.width, options.height, options.flashvars);
            this.appendhtml($(flash), options.width, options.height, 'flash');
          }
          else if (type=='element')
          {
            width    = options.width > 0 ? options.width : tmpElement.outerWidth(true);
            height   = options.height > 0 ? options.height : tmpElement.outerHeight(true);
            this.appendhtml(tmpElement, width, height);
          }
        }
        else if (type=='iframe')
        {
          if (options.width)
          {
            width   = options.width;
            height  = options.height;
          }
          else
          {
            this.error("You have to specify the size. Add ?lightbox[width]=600&lightbox[height]=400&lighbox[iframe]=true at the end of the url.");
            return false;
          }
          this.appendhtml($('<iframe id="IF_'+(new Date().getTime())+'" frameborder="0" src="'+href+'" style="margin:0; padding:0;"></iframe>').css(options), options.width, options.height);
        }

        this.callback = $.isFunction(callback) ? callback : function(e) {};
      },

      loadimage: function() {
        this.esqueleto.background.bind('complete', this.proxy(function() {
          this.esqueleto.background.unbind('complete');

          if (!this.visible)
          {
            return false
          }

          this.changemode('image');

          this.esqueleto.background.empty();
          this.esqueleto.html.empty();

          if (this.esqueleto.title)
          {
            this.esqueleto.background.append(this.esqueleto.title);
          }

          this.esqueleto.background.append(this.esqueleto.image);
          
          if (is_ie6 || is_smartphone)
          {
            this.esqueleto.background.removeClass(this.options.name+'-loading');
          }
          else
          {
            $(this.esqueleto.image).stop().css("opacity", 0).animate({
              "opacity" : 1
            }, 400, this.proxy(function() {
              this.esqueleto.background.removeClass(this.options.name+'-loading');
            }));
          }

          this.options.onOpen.apply(this);
        }));
      },
            
      swf2html: function(href, width, height, flashvars) {
        if (typeof flashvars == 'undefined' || flashvars == '') flashvars = 'autostart=1&autoplay=1&fullscreenbutton=1';
        var str = '<object width="'+width+'" height="'+height+'" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"><param name="movie" value="'+href+'" style="margin:0; padding:0;"></param>';
        str += '<param name="allowFullScreen" value="true"></param><param name="allowscriptaccess" value="always"></param><param name="wmode" value="transparent"></param>';
        str += '<param name="autostart" value="true"></param><param name="autoplay" value="true"></param><param name="flashvars" value="'+flashvars+'"></param>';
        str += '<param name="width" value="'+width+'"></param><param name="height" value="'+height+'"></param>';
        str += '<embed src="'+href+'" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" autostart="true" autoplay="true" flashvars="'+flashvars+'" wmode="transparent" width="'+width+'" height="'+height+'" style="margin:0; padding:0;"></embed></object>';
        return str;
      },
      
      appendhtml: function(obj, width, height, mode) {
        this.changemode("html");
        
        this.resize(width + 30, height + 20);

        this.esqueleto.background.bind('complete', this.proxy(function() {
          this.esqueleto.background.removeClass(this.options.name+'-loading');
          this.esqueleto.html.append(obj);

          if (mode == "flash" && uagent.search("chrome") > -1)
          {
            this.esqueleto.html.html(obj); // double line to fix chrome bug
          }

          this.esqueleto.background.unbind('complete');
          if (this.options.cufon && typeof Cufon !== 'undefined')
          {
            Cufon.refresh();
          }
          this.options.onOpen.apply(this);
        }));
        
      },
      
      movebox: function(w, h) {
        var size   = {
          x: $(this.win).width(),
          y: $(this.win).height()
        };

        var scroll = {
          x: $(this.win).scrollLeft(),
          y: $(this.win).scrollTop()
        };

        var height = h!=null ? h : this.esqueleto.lightbox.outerHeight();
        var width  = w!=null ? w : this.esqueleto.lightbox.outerWidth();

        var y      = 0;
        var x      = 0;

         //vertically center
        x = scroll.x + ((size.x - width) / 2);

        if (this.visible)
        {
          y = scroll.y + (size.y - height) / 2;
        }
        else if (this.options.emergefrom == "bottom")
        {
          y = (scroll.y + size.y + 14);
        }
        // top
        else if (this.options.emergefrom == "top")
        {
          y = (scroll.y - height) - 14;
        }
        
        if (this.visible)
        {
          if (!this.animations.move)
          {
            this.morph(this.esqueleto.move, {
              'left' : x
            }, 'move');
          }

          this.morph(this.esqueleto.move, {
            'top'  : y
          }, 'move');

        }
        else
        {
          this.esqueleto.move.css({
            'left' : x,
            'top'  : y
          });
        }
      },

      morph: function(el, prop, mode, callback, queue) {
        var optall = $.speed({
          queue     : queue || false,
          duration  : (is_smartphone ? 2 : this.options.animation[mode].duration),
          easing    : this.options.animation[mode].easing,
          complete  : ($.isFunction(callback) ? this.proxy(callback, this) : null)
        });
        
        return el[ optall.queue === false ? "each" : "queue" ](function() {

          if (parseFloat($.fn.jquery) > 1.5)
          {
            if (optall.queue === false)
            {
              jQuery._mark( this );
            }
          }

          var opt = $.extend({}, optall), self = this;

          opt.curAnim = $.extend({}, prop);

          opt.animatedProperties = {};

          for (p in prop) {
            name = p;
            val = prop[ name ];
            opt.animatedProperties[ name ] = opt.specialEasing && opt.specialEasing[ name ] || opt.easing || 'swing';
          }

          $.each( prop, function( name, val ) {
            var e = new $.fx( self, opt, name );

            e.custom( e.cur(true) || 0, val, "px" );
          });

          return true;
        });
      },
      
      resize: function(x, y) {
        if (this.visible)
        {
          var size   = {
            x: $(this.win).width(),
            y: $(this.win).height()
          };

          var scroll = {
            x: $(this.win).scrollLeft(),
            y: $(this.win).scrollTop()
          };

          var left   = (scroll.x + (size.x - (x + 14)) / 2);
          var top    = (scroll.y + (size.y - (y + 14)) / 2);
          
          if ($.browser.msie || ($.browser.mozilla && (parseFloat($.browser.version) < 1.9)))
          {
            y += 4;
          }
          
          this.animations.move = true;

          this.morph(this.esqueleto.move.stop(), {
            'left': (this.maximized && left < 0) ? 0 : left,
            'top' : (this.maximized && (y + 14) > size.y) ? scroll.y : top
          }, 'move', $.proxy(function() { this.move = false; }, this.animations));

          this.morph(this.esqueleto.html, { 'height': y - 20 }, 'move');
          this.morph(this.esqueleto.lightbox.stop(), { 'width': (x + 14), 'height': y - 20 }, 'move', {}, true);
          this.morph(this.esqueleto.navigator, { 'width': x }, 'move');
          this.morph(this.esqueleto.navigator, { 'top': (y - 90) / 2 }, 'move');
          this.morph(this.esqueleto.background.stop(), { 'width': x, 'height': y }, 'move', function() { $(this.esqueleto.background).trigger('complete'); });
        }
        else
        {
          this.esqueleto.html.css({ 'height': y - 20 });
          this.esqueleto.lightbox.css({ 'width': x + 14, 'height': y - 20 });
          this.esqueleto.background.css({ 'width': x, 'height': y });
          this.esqueleto.navigator.css({ 'width': x, 'height': 90 });
        }
      },
      
      close: function(param) {
        this.visible = false;
        this.gallery = {};
        
        this.options.onClose();
        
        if ($.browser.msie || is_smartphone)
        {
          this.esqueleto.background.empty();
          this.esqueleto.html.hide().empty().show();
          this.esqueleto.buttons.custom.empty();
          this.esqueleto.move.css("display", "none");
          this.movebox();
        }
        else
        {
          this.esqueleto.move.animate({"opacity": 0, "top": "-=40"}, {
            queue     : false,
            complete  : (this.proxy(function() {
              this.esqueleto.background.empty();
              this.esqueleto.html.empty();
              this.esqueleto.buttons.custom.empty();
              this.movebox();
              this.esqueleto.move.css({
                "display": "none",
                "opacity": 1,
                "overflow": "visible"
              });
            }))
          });
        }
        
        this.overlay.hide(this.proxy(function() {
          if ($.isFunction(this.callback))
          {
            this.callback.apply(this, $.makeArray(param));
          }
        }));

        this.esqueleto.background.stop(true, false).unbind("complete");
      },
      
      open: function() {
        this.visible = true;

        if ($.browser.msie)
        {
          this.esqueleto.move.get(0).style.removeAttribute("filter");
        }

        this.esqueleto.move.css({
          "display"  : "block",
          "overflow" : "visible"
        }).show();

        this.overlay.show();
      },

      shake: function() {
        var z = this.options.animation.shake;
        var x = z.distance;
        var d = z.duration;
        var t = z.transition;
        var o = z.loops;
        var l = this.esqueleto.move.position().left;
        var e = this.esqueleto.move;

        for (i=0; i<o; i++)
        {
         e.animate({left: l+x}, d, t);
         e.animate({left: l-x}, d, t);
        };

        e.animate({left: l+x}, d, t);
        e.animate({left: l},   d, t);
      },
      
      changemode: function(mode) {
        if (mode != this.mode)
        {
          this.esqueleto.lightbox.removeClass(this.options.name+"-mode-"+this.mode);
          this.mode = mode;
          this.esqueleto.lightbox.addClass(this.options.name+"-mode-"+this.mode);
        }

        this.esqueleto.move.css("overflow", "visible");
      },
      
      error: function(msg) {
        alert(msg);
        this.close();
      },
      
      unserialize: function(data) {
        var regex       = /lightbox\[(.*)?\]$/i;
        var serialised  = {};

        if (data.match(/#/))
        {
          data = data.slice(0, data.indexOf("#"));
        }

        data = data.slice(data.indexOf('?') + 1).split("&");
        
        $.each(data, function() {
          var properties = this.split("=");
          var key        = properties[0];
          var value      = properties[1];
          
          if (key.match(regex))
          {
            if (isFinite(value))
            {
              value = parseInt(value)
            }
            else if (value.toLowerCase() == "true")
            {
              value = true;
            }
            else if (value.toLowerCase() == "false")
            {
              value = false;
            }
            serialised[key.match(regex)[1]] = value;
          }
        });

        return serialised;
      },
      
      calculate: function(x, y) {
        // Resizing large images
        var maxx = this.win.width() - 50;
        var maxy = this.win.height() - 50;

        if (x > maxx)
        {
          y = y * (maxx / x);
          x = maxx;
          if (y > maxy)
          {
            x = x * (maxy / y);
            y = maxy;
          }
        }
        else if (y > maxy)
        {
          x = x * (maxy / y);
          y = maxy;
          if (x > maxx)
          {
            y = y * (maxx / x);
            x = maxx;
          }
        }
        // End Resizing
        return {
          "width": parseInt(x),
          "height": parseInt(y)
        };
      },

      loading: function() {
        var size        = this.options.style;
        var $background = this.esqueleto.background;

        this.changemode('image');

        $background.children().stop(true);
        $background.empty();
        this.esqueleto.html.empty();

        $background.addClass(this.options.name+'-loading');
        this.esqueleto.buttons.div.hide();

        if (this.visible == false)
        {
          this.movebox(size["width"], size["height"]);
          this.resize(size["width"], size["height"]);
        }
      },

      maximinimize: function() {
        var $buttons = this.esqueleto.buttons;
        var $image   = this.esqueleto.image;
        var name     = this.options.name;

        if (this.maximized)
        {
          this.maximized = false;
          $buttons.max.removeClass(name + '-button-min');
          $buttons.max.addClass(name + '-button-max');

          this.loading();
          this.loadimage();
          $buttons.div.show();

          var size = this.calculate($image.width, $image.height);
          this.resize(size.width, size.height);
        }
        else
        {
          this.maximized = true;
          $buttons.max.removeClass(name+'-button-max');
          $buttons.max.addClass(name+'-button-min');

          this.loading();
          this.loadimage();
          $buttons.div.show();

          this.resize($image.width, $image.height);
        }
      }
      
    }, //end object
   
    lightbox: function(url, options, callback) {
      if (typeof url !== 'undefined')
      {
        return $.LightBoxObject.show(url, options, callback);
      }
      else
      {
        return $.LightBoxObject;
      }
    }
    
  });
  
  $.fn.lightbox = function(options, callback) {
    return $(this).live('click', function(e) {
      $(this).blur();
      
      var sel = [];
      var rel = $.trim($(this).attr('rel')) || '';
      var til = $.trim($(this).attr('title')) || '';
      var lnk = $(this);
      
      rel = rel.replace('[','\\\\[');
      rel = rel.replace(']','\\\\]');

      if (!rel || rel == '' || rel === 'nofollow')
      {
        sel = $(this).attr('href');
        copy_options = (til || til != '') ? $.extend({}, options, {'title': til}) : options;
      }
      else
      {
        var rels  = [];
        var antes = [];
        var desps = [];
        var encon = false;
        
        $("a[rel], area[rel]", this.ownerDocument).filter("[rel=\"" + rel + "\"]").each($.proxy(function(i, el) {
          if (this == el)
          {
            antes.unshift(el);
            encon = true;
          }
          else if (encon == false)
          {
            desps.push(el);
          }
          else
          {
            antes.push(el);
          }
        }, this));

        rels = lnk = antes.concat(desps);
        
        $.each(rels, function() {
          var title = $.trim($(this).attr('title')) || '';
          title = title ? "%LIGHTBOX%" + title : '';
          sel.push($(this).attr('href') + title);
        });
        
        if (sel.length == 1)
        {
          sel = sel[0];
        }

        copy_options = options;
      }

      $.LightBoxObject.show(sel, copy_options, callback, lnk);

      return false;
    });
  };
  
  $(function() {
    if (parseFloat($.fn.jquery) > 1.2)
    {
      $.LightBoxObject.create();
    }
    else
    {
      throw "The jQuery version that was loaded is too old. Lightbox Evolution requires jQuery 1.3+";
    }
  });
  
})(jQuery);