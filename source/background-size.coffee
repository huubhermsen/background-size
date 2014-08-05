((window, $) ->
	
	$.fn.extend
		background: (options) ->
			
			# Contants
			BGX = 'backgroundPositionX'
			BGY = 'backgroundPositionY'
			PNM = { top: '0%', right: '100%', bottom: '100%', left: '0%', center: '50%' }

			# Private methods
			position = (el, type, diff, overflow) ->
				# Calculate position
				value = if el[0].currentStyle? then el[0].currentStyle[type] else el.css type
				if /px/.test value
					return -parseInt value.replace 'px', ''
				else 
					if !/%/.test value then value = PNM[value]
					if (type is BGX and overflow is true) or (type is BGY and overflow is false) then return 0
					calcValue = (parseInt value.replace '%', '') / 100
					-(calcValue * diff)

			calculate = (el, image, k) ->
				imageWidth = image.width()
				imageHeight = image.height()

				if imageWidth is 0 or imageHeight is 0
					setTimeout ->
						calculate el, image, k
					, 5
					return

				elementWidth = el.width()
				elementHeight = el.height()

				overflow = if elementWidth / imageWidth < elementHeight / imageHeight then (settings.size is 'contain') else (settings.size is 'cover')
				width = newWidth = elementWidth
				height = elementHeight

				newHeight = imageHeight / (imageWidth / width)
				left = position el, BGX, 0, overflow
				top = position el, BGY, elementHeight - newHeight, overflow

				if (settings.size is 'cover' and newHeight < height) or (settings.size is 'contain' and newHeight > height)
					newWidth = Math.ceil imageWidth / (imageHeight / height)
					left = position el, BGX, elementWidth - newWidth, overflow

				extraClass = if el.css('position') is 'static' then ".bgs-parent#{k}{position:relative}" else ""
				style.append '<style>.bgs' + k + '{position:absolute;display:block;left:' + -left + 'px;top:' + -top + 'px;width: ' + newWidth + 'px;clip:rect(' + top + 'px,' + (width + left) + 'px,' + (height + top) + 'px,' + left + 'px);}' + extraClass + '</style>'

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
				style = $ '<div id="bgs-styles"><style>.bgs-image{display:none;}.bgs-parent{background-image:none!important;}</style></div>'
				$('body').append style

			# Loop through elements
			@each ->
				randomKey = Math.ceil Math.random() * 100000001
				reference = $ @

				res = /url\((.*?)\)/i.exec reference.css 'backgroundImage'
				if !res then return console.log "Missing background picture for: <div class=\"#{@.className}\" />"

				path = res[1]
				image = $ '<img src=' + path + ' class="bgs-image bgs' + randomKey + '" />'
				reference.addClass "bgs-parent bgs-parent#{randomKey}"

				calculate reference, image, randomKey
				reference.append image
				reference.size = { x: reference.width(), y: reference.height() }

				$(window).on 'resize', ->
					if reference.size.x isnt reference.width() or reference.size.y isnt reference.height()
						reference.size = { x: reference.width(), y: reference.height() }
						calculate reference, image, randomKey

				return

			# Return element(s) for chaining
			return @

	# Shorthand functions for background plugin
	$.fn.extend
		cover: ->
			@each ->
				$(@).background { size: 'cover' }
				return
			# Return element(s) for chaining
			return @

	$.fn.extend
		contain: ->
			@each ->
				$(@).background { size: 'contain' }
				return
			# Return element(s) for chaining
			return @

	return
)(window, jQuery)