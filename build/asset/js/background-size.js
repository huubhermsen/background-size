(function() {
  var $;

  $ = jQuery;

  $.fn.extend({
    backgroundSize: function() {
      this.each(function() {
        console.log(this);
      });
      return this;
    }
  });

}).call(this);
