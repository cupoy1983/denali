(function($) {
    $.fn.lazyload = function(options) {
        var settings = {
            threshold    : 0,
            failurelimit : 0,
            event        : "scroll",
            effect       : "show",
            container    : window
        };
                
        if(options) {
            $.extend(settings, options);
        }

        /* Fire one scroll event per scroll. Not one scroll event per image. */
        var elements = this;
        if ("scroll" == settings.event) {
            $(settings.container).bind("scroll", function(event) {
                var counter = 0;
                elements.each(function() {
                    if ($.abovethetop(this, settings) ||
                        $.leftofbegin(this, settings)) {
                            /* Nothing. */
                    } else if (!$.belowthefold(this, settings) &&
                        !$.rightoffold(this, settings)) {
                            $(this).trigger("appear");
                    } else {
                        if (counter++ > settings.failurelimit) {
							if(!FANWE.NO_COUNTER)
                            	return false;
                        }
                    }
                });
                /* Remove image from array so it is not looped next time. */
                var temp = $.grep(elements, function(element) {
                    return !element.loaded;
                });
                elements = $(temp);
            });
        }
        
        this.each(function() {
            var self = this;
            
            /* Save original only if it is not defined in HTML. */
            if (undefined == $(self).attr("original")) {
                $(self).attr("original", $(self).attr("src"));     
            }

            if ("scroll" != settings.event || 
                    undefined == $(self).attr("src") || 
                    settings.placeholder == $(self).attr("src") || 
                    ($.abovethetop(self, settings) ||
                     $.leftofbegin(self, settings) || 
                     $.belowthefold(self, settings) || 
                     $.rightoffold(self, settings) )) {
                        
                if (settings.placeholder) {
                    $(self).attr("src", settings.placeholder);      
                } else {
                    $(self).removeAttr("src");
                }
                self.loaded = false;
            } else {
                self.loaded = true;
            }
            
            /* When appear is triggered load original image. */
            $(self).one("appear", function() {
                if (!this.loaded) {
                    var parent = $(self).parent();
					var img= new Image();
					img.src = $(self).attr("original");

					var scaleType = parseInt($(self).attr("scaleType"));
					var scaleWidth = parseInt($(self).attr("scaleWidth"));
					var scaleHeight = parseInt($(self).attr("scaleHeight"));

					var defaultLoad = function(){
						$(self).hide()
							.attr("src", $(self).attr("original"))
							[settings.effect](settings.effectspeed);
						self.loaded = true;
						delete img;
					};
					
					if(isNaN(scaleType) || isNaN(scaleWidth) || isNaN(scaleHeight) || scaleType < 1 || (scaleWidth < 1 && scaleHeight < 1))
					{
						defaultLoad();
						return;
					}
					
					var autoScale = function(){
						var width = 0;
						var height = 0;
						var scale = img.width / img.height;

						if(img.width == 0 || img.height == 0)
						{
							delete img;
							return;
						}

						switch(scaleType)
						{
							case 1:
								if(img.width > scaleWidth)
								{
									width = scaleWidth;
									height = scaleWidth / scale;
								}
								else
								{
									scale = scaleWidth / img.width;
									width = scaleWidth;
									height = img.height * scale;
								}
							break;

							case 2:
								if(img.height > scaleHeight)
								{
									height = scaleHeight;
									width = scaleHeight * scale;
								}
								else
								{
									scale = scaleHeight / img.height;
									height = scaleHeight;
									width = img.width * scale;
								}
							break;

							case 3:
								if(scaleWidth/img.width < scaleHeight/img.height)
								{
									scale = scaleHeight / img.height;
									height = scaleHeight;
									width = img.width * scale;
								}
								else
								{
									scale = scaleWidth / img.width;
									width = scaleWidth;
									height = img.height * scale;
								}
							break;
							
							case 4:
								if(scaleWidth/img.width > scaleHeight/img.height)
								{
									scale = scaleHeight / img.height;
									height = scaleHeight;
									width = img.width * scale;
								}
								else
								{
									scale = scaleWidth / img.width;
									width = scaleWidth;
									height = img.height * scale;
								}
							break;

							default:
								delete img;
								return;
							break;
						}
						
						if(scaleType == 3)
						{
							var left = (parent.width() - width) / 2;
							var top = (parent.height() - height) / 2;
							$(self).hide()
								.attr("src",$(self).attr("original"))
								.css({"margin-top":top,"margin-left":left,"width":width,"height":height})
								[settings.effect](settings.effectspeed);
						}
						else
						{
							$(self).hide()
								.attr("src",$(self).attr("original"))
								.css({"width":width,"height":height})
								[settings.effect](settings.effectspeed);
							
							if($(self).attr("updateParentSize") == "1")
								$(self).parent().css({"width":width,"height":height});
						}
						delete img;
					};

					if(img.complete){
						autoScale();
						return;
					}

					$(img).load(function(){
						autoScale();
						return;
					});
                };
            });

            /* When wanted event is triggered load original image */
            /* by triggering appear.                              */
            if ("scroll" != settings.event) {
                $(self).bind(settings.event, function(event) {
                    if (!self.loaded) {
                        $(self).trigger("appear");
                    }
                });
            }
        });
        
        /* Force initial check if images should appear. */
        $(settings.container).trigger(settings.event);
        
        return this;

    };

    /* Convenience methods in jQuery namespace.           */
    /* Use as  $.belowthefold(element, {threshold : 100, container : window}) */

    $.belowthefold = function(element, settings) {
        if (settings.container === undefined || settings.container === window) {
            var fold = $(window).height() + $(window).scrollTop();
        } else {
            var fold = $(settings.container).offset().top + $(settings.container).height();
        }
        return fold <= $(element).offset().top - settings.threshold;
    };
    
    $.rightoffold = function(element, settings) {
        if (settings.container === undefined || settings.container === window) {
            var fold = $(window).width() + $(window).scrollLeft();
        } else {
            var fold = $(settings.container).offset().left + $(settings.container).width();
        }
        return fold <= $(element).offset().left - settings.threshold;
    };
        
    $.abovethetop = function(element, settings) {
        if (settings.container === undefined || settings.container === window) {
            var fold = $(window).scrollTop();
        } else {
            var fold = $(settings.container).offset().top;
        }
        return fold >= $(element).offset().top + settings.threshold  + $(element).height();
    };
    
    $.leftofbegin = function(element, settings) {
        if (settings.container === undefined || settings.container === window) {
            var fold = $(window).scrollLeft();
        } else {
            var fold = $(settings.container).offset().left;
        }
        return fold >= $(element).offset().left + settings.threshold + $(element).width();
    };
    /* Custom selectors for your convenience.   */
    /* Use as $("img:below-the-fold").something() */

    $.extend($.expr[':'], {
        "below-the-fold" : "$.belowthefold(a, {threshold : 0, container: window})",
        "above-the-fold" : "!$.belowthefold(a, {threshold : 0, container: window})",
        "right-of-fold"  : "$.rightoffold(a, {threshold : 0, container: window})",
        "left-of-fold"   : "!$.rightoffold(a, {threshold : 0, container: window})"
    });
})(jQuery);