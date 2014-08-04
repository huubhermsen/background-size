(function($) {
  $.fn.extend({
    background: function(options) {
      var calculate, settings, style;
      settings = {
        size: 'cover',
        force: false
      };
      settings = $.extend(settings, options);
      style = $('style#bgs-styles');
      if (!style.length) {
        style = $('<style id="bgs-styles">.bgs-image { display: none; }</style>');
        $('body').append(style);
      }
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
        return style.append('.bgs' + k + ' { position: absolute; display: block; left: ' + -left + 'px; top: ' + -top + 'px; width: ' + newWidth + 'px; clip: rect(' + top + 'px, ' + (width + left) + 'px, ' + (height + top) + 'px, ' + left + 'px); }');
      };
      this.each(function() {
        var image, k, path, ref, res;
        k = Math.ceil(Math.random() * 100000001);
        ref = $(this);
        if (this.style.backgroundSize !== void 0 && settings.force === false) {
          return;
        }
        res = /url\((.*?)\)/i.exec($(this).css('backgroundImage'));
        if (!res) {
          return typeof console !== "undefined" && console !== null ? typeof console.warn === "function" ? console.warn('No background image provided for:', this) : void 0 : void 0;
        }
        path = res[1];
        image = $('<img src=' + path + ' class="bgs-image bgs' + k + '" />');
        calculate(ref, image, k);
        ref.append(image);
        ref.on('resize', function() {
          console.log('resize');
          return calculate(ref, image, k);
        });
      });
      return this;
    }
  });
})(jQuery);
