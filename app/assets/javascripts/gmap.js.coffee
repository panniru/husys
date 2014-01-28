class window.RichMarkerBuilder extends Gmaps.Google.Builders.Marker #inherit from builtin builder
        # override method
        create_infowindow: ->
            return null unless _.isString @args.infowindow
            boxText = document.createElement("div")
            boxText.setAttribute("class", 'yellow') #to customize
            boxText.innerHTML = @args.infowindow
            @infowindow = new InfoBox(@infobox(boxText))

            # add @bind_infowindow() for < 2.1
        infobox: (boxText)->
            content: boxText
            pixelOffset: new google.maps.Size(-140, 0)
            boxStyle:
              width: "10px"

@buildMap = ()->
        alert('')
        $.getJSON('home/exam_centers_geo', (centers) ->
                alert(centers)
                handler = Gmaps.build('Google', { builders: { Marker: RichMarkerBuilder} }) #dependency injection
                #then standard use
                handler.buildMap { provider: {}, internal: {id: 'map'} }, ->
                markers = handler.addMarkers([{'lat':17.4459898,'lng':78.3514559},{'lat':17.4444468,'lng':78.3860752}])
                handler.bounds.extendWith(markers)
                handler.fitMapToBounds()
        )
