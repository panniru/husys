window.addHoverHandlers = (markers)->
  for m in markers
    marker = m.serviceObject
    google.maps.event.addListener marker, "mouseover", ->
      for m2 in markers
        if m2.serviceObject == this
          m2.infowindow.open m2.serviceObject.map, m2.serviceObject
    google.maps.event.addListener marker, "mouseout", ->
      for m2 in markers
        if m2.serviceObject == this
           m2.infowindow.close()
    google.maps.event.addListener marker, "click", ->
      for m2 in markers
        if m2.serviceObject == this
           id_content = m2.infowindow.content.split(':')[0]
           if $.isNumeric(id_content)
              base_url = "/exam_centers/"+id_content
              window.location = base_url
