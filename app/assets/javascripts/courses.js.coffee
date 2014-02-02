class window.CourseDrillHandler
  @instance = null
  @getInstance:  ->
    if !@instance
        @instance = new CourseDrillHandler()
    @instance
  performDrill: (event)->
    filters = $(event.target).attr("data-filters")
    view_by = $(event.target).attr("data-view")
    parent = $(event.target).parent("span").parent('li')
    children = parent.find(" > ul > li")
    if children.is(":visible")
       children.hide "fast"
       parent.find('> span > i').addClass('glyphicon-plus-sign').removeClass('glyphicon-minus-sign');
    else
       if parent.hasClass('parent_li')
        children.show "fast"
        parent.find('> span  > i').addClass('glyphicon-minus-sign').removeClass('glyphicon-plus-sign')
       else
        url = "/courses/hierarchy?filters="+filters
        if typeof view_by != 'undefined'
          url = "/courses/hierarchy?view_by="+view_by+"&filters="+filters
        $.getJSON(url, (data)->
                parent.addClass('parent_li')
                ul = $('<ul/>').appendTo(parent)
                $.each(data, (i) ->
                        child_filter = filters+","+data[i].value
                        li = $('<li/>').css({ display: "none" }).appendTo(ul)
                        span = $('<span/>').appendTo(li)
                        icon = $('<i/>').addClass('glyphicon glyphicon-plus-sign pointer').click( (e) -> CourseDrillHandler.getInstance().performDrill(e)).attr('data-view', data[i].next_column).attr('data-filters', child_filter).appendTo(span)
                        content = $('<a/>').text(data[i].value).appendTo(span)
                )
                children = parent.find(" > ul > li")
                children.show "fast"
                parent.find('> span  > i').addClass('glyphicon-minus-sign').removeClass('glyphicon-plus-sign')
        )
