(function($) {
  $.fn.extend({
    background: function(options) {
      var calculate, isIE, settings, style;
      calculate = function(el, image, k) {
        var calc, height, imageHeight, imageWidth, left, newHeight, newWidth, top, width;
        imageWidth = image.width();
        imageHeight = image.height();
        if (imageWidth === 0 || imageHeight === 0) {
          setTimeout(function() {
            return calculate(el, image, k);
          }, 5);
          return;
        }
        width = newWidth = el.width();
        height = el.height();
        calc = imageWidth / width;
        newHeight = imageHeight / calc;
        left = 0;
        top = Math.ceil((newHeight - height) / 2);
        if (settings.size === 'cover' && newHeight < height) {
          calc = imageHeight / height;
          newWidth = Math.ceil(imageWidth / calc);
          left = Math.ceil((newWidth - width) / 2);
          top = 0;
        }
        if (settings.size === 'contain' && newHeight > height) {
          calc = imageHeight / height;
          newWidth = Math.ceil(imageWidth / calc);
          left = Math.ceil((newWidth - width) / 2);
          top = 0;
        }
        return style.append('<style>.bgs' + k + ' { position: absolute; display: block; left: ' + -left + 'px; top: ' + -top + 'px; width: ' + newWidth + 'px; clip: rect(' + top + 'px, ' + (width + left) + 'px, ' + (height + top) + 'px, ' + left + 'px); }</style>');
      };
      isIE = function() {
        var nav;
        nav = navigator.userAgent.toLowerCase();
        if (nav.indexOf('msie') !== -1) {
          return parseInt(nav.split('msie')[1]);
        } else {
          return false;
        }
      };
      settings = {
        size: 'cover',
        force: false
      };
      settings = $.extend(settings, options);
      if ((!isIE() || isIE() > 8) && settings.force === false) {
        return this;
      }
      style = $('#bgs-styles');
      if (!style.length) {
        style = $('<div id="bgs-styles"><style>.bgs-image { display: none; } .bgs-parent { background-image: none !important; }</style></div>');
        $('body').append(style);
      }
      this.each(function() {
        var image, k, path, ref, res, styles;
        k = Math.ceil(Math.random() * 100000001);
        ref = $(this);
        res = /url\((.*?)\)/i.exec(ref.css('backgroundImage'));
        if (!res) {
          return typeof console !== "undefined" && console !== null ? typeof console.warn === "function" ? console.warn('No background image provided for:', this) : void 0 : void 0;
        }

        /*
        				if @currentStyle?
        					console.log @currentStyle.backgroundSize
        				else
        					console.log ref.css 'backgroundPositionY'
         */
        styles = $.map(this.currentStyle, function(k, v) {
          return v;
        });
        console.log(styles);
        path = res[1];
        image = $('<img src=' + path + ' class="bgs-image bgs' + k + '" />');
        ref.addClass('bgs-parent');
        calculate(ref, image, k);
        ref.append(image);
        ref.size = {
          x: ref.width(),
          y: ref.height()
        };
        $(window).on('resize', function() {
          if (ref.size.x !== ref.width() || ref.size.y !== ref.height()) {
            ref.size = {
              x: ref.width(),
              y: ref.height()
            };
            return calculate(ref, image, k);
          }
        });
      });
      return this;
    }
  });
})(jQuery);
