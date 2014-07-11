(($) ->
	
	$.fn.extend
		backgroundSize: (options) ->
			
			# Settings object
			settings = 
				type: 'cover'
				force: false

			# Extend settings
			settings = $.extend settings, options

			# Private methods
			calculate = (el, image, k) ->
				imageWidth = image.width()
				imageHeight = image.height()
				
				if imageWidth is 0 or imageHeight is 0
					setTimeout ->
						calculate el, image, k
					, 5
					return
				
				width = newWidth = el.width()
				height = el.height()
				
				calc = imageWidth / width
				newHeight = imageHeight / calc
				left = 0
				top = Math.ceil (newHeight - height) / 2

				if settings.type is 'cover' && newHeight < height
					calc = imageHeight / height
					newWidth = Math.ceil imageWidth / calc
					left = Math.ceil (newWidth - width) / 2
					top = 0

				if settings.type is 'contain' && newHeight > height
					calc = imageHeight / height
					newWidth = Math.ceil imageWidth / calc
					left = Math.ceil (newWidth - width) / 2
					top = 0

				$('body').append '<style>.bgs' + k + ' { position: absolute; display: block; left: ' + -left + 'px; top: ' + -top + 'px; width: ' + newWidth + 'px; clip: rect(' + top + 'px, ' + (width + left) + 'px, ' + (height + top) + 'px, ' + left + 'px); }</style>'

				
				#clip: 

			# Loop through elements
			@each (k, e) ->
				ref = $ @

				if @style.backgroundSize isnt undefined and settings.force is false
					return

				res = /url\((.*?)\)/i.exec $(@).css 'backgroundImage'
				if !res then return console?.warn? 'No background image provided for:', @
				
				path = res[1]
				image = $ '<img src=' + path + ' class="bgs-image bgs' + k + '" />'


				$('body').append '<style>.bgs-image { display: none; }</style>'
				#console.log $(@).css 'backgroundPositionY'

				calculate ref, image, k
				ref.append image

				return

			# Return element(s) for chaining
			return @;
	return
) jQuery