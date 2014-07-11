$ = jQuery

$.fn.extend
	backgroundSize: () ->
		
		# Loop elements
		@each () ->
			console.log @
			return
		
		# Return element(s) for chaining
		return @;	