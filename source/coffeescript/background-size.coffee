(($) ->
	
	$.fn.extend
		background: (options) ->
			
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

				if settings.size is 'cover' && newHeight < height
					calc = imageHeight / height
					newWidth = Math.ceil imageWidth / calc
					left = Math.ceil (newWidth - width) / 2
					top = 0

				if settings.size is 'contain' && newHeight > height
					calc = imageHeight / height
					newWidth = Math.ceil imageWidth / calc
					left = Math.ceil (newWidth - width) / 2
					top = 0

				style.append '<style>.bgs' + k + ' { position: absolute; display: block; left: ' + -left + 'px; top: ' + -top + 'px; width: ' + newWidth + 'px; clip: rect(' + top + 'px, ' + (width + left) + 'px, ' + (height + top) + 'px, ' + left + 'px); }</style>'

			isIE = ->
				nav = navigator.userAgent.toLowerCase()
				if nav.indexOf('msie') isnt -1 then parseInt nav.split('msie')[1] else false

			# Settings object
			settings = 
				size: 'cover'
				force: false

			# Extend settings
			settings = $.extend settings, options

			if (!isIE() or isIE() > 8) and settings.force is false
				return @

			# Check if style element is present
			style = $ '#bgs-styles'
			if !style.length
				style = $ '<div id="bgs-styles"><style>.bgs-image { display: none; } .bgs-parent { background-image: none !important; }</style></div>'
				$('body').append style

			# Loop through elements
			@each () ->
				k = Math.ceil Math.random() * 100000001
				ref = $ @

				res = /url\((.*?)\)/i.exec ref.css 'backgroundImage'
				if !res then return console?.warn? 'No background image provided for:', @
				
				###
				if @currentStyle?
					console.log @currentStyle.backgroundSize
				else
					console.log ref.css 'backgroundPositionY'
				###

				styles = $.map @currentStyle, (k,v)-> v
				console.log styles
				#console.log(arg) for arg in styles

				path = res[1]
				image = $ '<img src=' + path + ' class="bgs-image bgs' + k + '" />'

				ref.addClass 'bgs-parent'

				calculate ref, image, k
				ref.append image
				ref.size = { x: ref.width(), y: ref.height() }

				$(window).on 'resize', ->
					if ref.size.x isnt ref.width() or ref.size.y isnt ref.height()
						ref.size = { x: ref.width(), y: ref.height() }
						calculate ref, image, k

				return

			# Return element(s) for chaining
			return @
	return
) jQuery