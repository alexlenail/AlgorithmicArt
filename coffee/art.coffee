raphael = undefined 

cAttr = undefined
lAttr = 
	'stroke':'white'
	'stroke-width': 0.5
	'fill':'blue'



root3 = Math.sqrt(3)


$(document).ready ->

	setAndBindDimensions()
	circles()
	$('svg').height $(window).height()
	lines()


circles = () ->

	Y = () -> Math.random() * $(window).height()
	X = () -> Math.random() * $(window).width()
	R = () -> 160 + Math.random() * 60 - 30

	cAttr = () -> 

		r = Math.random() * 150 + 50
		g = Math.random() * 150 + 50
		b = Math.random() * 150 + 50
		a = Math.random() / 3 + 0.35

		componentToHex = (c) -> if c.toString(16).length is 2 then c.toString(16) else "0" + c.toString(16)

		hex = componentToHex(Math.floor(r)) + componentToHex(Math.floor(g)) + componentToHex(Math.floor(b));
		#color = "0-#ffffff-##{hex}"
		#color = '0-#ffffff-#000000'
		color = "rgb(#{r}, #{g}, #{b})"

		{
			'stroke': 'white'
			'stroke-width': 0.4
			'fill': color
			'opacity': a
			#'fill-opacity': a
		}

	for i in [0..100]

		raphael.circle(X(), Y(), R()).attr(cAttr())



lines = () -> 

	Verticals = () -> 

		verticals = []

		for i in [0..$(window).width() / 50 + 1]
			x1 = x2 = i * 50
			y1 = 0
			y2 = $(window).height()
			raphael.path("M#{x1},#{y1},L#{x2},#{y2}").attr(lAttr)
			verticals.push(x1)

		return verticals

	Horizontals = () -> 

		horizontals = []

		for i in [0..$(window).height() / (50 * root3) + 1]
			y1 = y2 = i * 50 * root3
			x1 = 0
			x2 = $(window).width()
			raphael.path("M#{x1},#{y1},L#{x2},#{y2}").attr(lAttr)
			horizontals.push(y1)

		return horizontals

	Boxes = (verticals, horizontals) -> 

		boxes = []
		oneThird = 50 * root3 / 3

		for v, i in verticals when i % 2 isnt 0 and i isnt 0

			for h, j in horizontals when j isnt 0

				boxes.push({
						'N':  {'x': verticals[i-1],'y': horizontals[j-1]},
						'NE': {'x': verticals[i],  'y': horizontals[j-1]},
						'EN': {'x': verticals[i],  'y': horizontals[j-1] + oneThird},
						'ES': {'x': verticals[i],  'y': horizontals[j] - oneThird},
						'SE': {'x': verticals[i],  'y': horizontals[j]},
						'S':  {'x': verticals[i-1],'y': horizontals[j]},
						'SW': {'x': verticals[i-2],'y': horizontals[j]},
						'WS': {'x': verticals[i-2],'y': horizontals[j] - oneThird},
						'WN': {'x': verticals[i-2],'y': horizontals[j-1] + oneThird},
						'NW': {'x': verticals[i-2],'y': horizontals[j-1]},
						'CN': {'x': verticals[i-1],'y': horizontals[j-1] + oneThird},
						'CS': {'x': verticals[i-1],'y': horizontals[j] - oneThird}
					})

		return boxes

	Fill = (boxes) ->
		
		for b in boxes

			raphael.path("M#{b['N']['x']},#{b['N']['y']},L#{b['SE']['x']},#{b['SE']['y']},#{b['SW']['x']},#{b['SW']['y']},#{b['N']['x']},#{b['N']['y']}").attr(lAttr).attr('fill-opacity':Math.random()/10)
			raphael.path("M#{b['S']['x']},#{b['S']['y']},L#{b['NW']['x']},#{b['NW']['y']},#{b['NE']['x']},#{b['NE']['y']},#{b['S']['x']},#{b['S']['y']}").attr(lAttr).attr('fill-opacity':Math.random()/10)

			raphael.path("M#{b['N']['x']},#{b['N']['y']},L#{b['WN']['x']},#{b['WN']['y']}").attr(lAttr)
			raphael.path("M#{b['N']['x']},#{b['N']['y']},L#{b['EN']['x']},#{b['EN']['y']}").attr(lAttr)
			raphael.path("M#{b['S']['x']},#{b['S']['y']},L#{b['WS']['x']},#{b['WS']['y']}").attr(lAttr)
			raphael.path("M#{b['S']['x']},#{b['S']['y']},L#{b['ES']['x']},#{b['ES']['y']}").attr(lAttr)

			raphael.path("M#{b['WN']['x']},#{b['WN']['y']},L#{b['CS']['x']},#{b['CS']['y']}").attr(lAttr)
			raphael.path("M#{b['EN']['x']},#{b['EN']['y']},L#{b['CS']['x']},#{b['CS']['y']}").attr(lAttr)
			raphael.path("M#{b['WS']['x']},#{b['WS']['y']},L#{b['CN']['x']},#{b['CN']['y']}").attr(lAttr)
			raphael.path("M#{b['ES']['x']},#{b['ES']['y']},L#{b['CN']['x']},#{b['CN']['y']}").attr(lAttr)
		
			raphael.triangle







	return Fill(Boxes(Verticals(), Horizontals()))


setAndBindDimensions = () -> 

		art = $("#art")
		raphael = Raphael(art.get(0))

	setDimensions = () ->
		art = $("#art")
		art.height $(window).height() 
		art.width $(window).width() 
		raphael.setSize(art.width(), art.height())
		$('svg').height $(window).height()

	setDimensions()

	$(window).bind 'resize', ->
		setDimensions()
















