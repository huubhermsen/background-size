(function($) {
  $.fn.extend({
    backgroundSize: function(options) {
      var calculate, settings;
      settings = {
        type: 'cover',
        force: false
      };
      settings = $.extend(settings, options);
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
        if (settings.type === 'cover' && newHeight < height) {
          calc = imageHeight / height;
          newWidth = Math.ceil(imageWidth / calc);
          left = Math.ceil((newWidth - width) / 2);
          top = 0;
        }
        if (settings.type === 'contain' && newHeight > height) {
          calc = imageHeight / height;
          newWidth = Math.ceil(imageWidth / calc);
          left = Math.ceil((newWidth - width) / 2);
          top = 0;
        }
        return $('body').append('<style>.bgs' + k + ' { position: absolute; display: block; left: ' + -left + 'px; top: ' + -top + 'px; width: ' + newWidth + 'px; clip: rect(' + top + 'px, ' + (width + left) + 'px, ' + (height + top) + 'px, ' + left + 'px); }</style>');
      };
      this.each(function(k, e) {
        var image, path, ref, res;
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
        $('body').append('<style>.bgs-image { display: none; }</style>');
        calculate(ref, image, k);
        ref.append(image);
      });
      return this;
    }
  });
})(jQuery);
