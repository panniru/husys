class window.CourseDrillHandler
  @instance = null
  level_spans = ["label-danger ", "label-success", "label-info", "label-default"]
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
                        level = filters.split(',').length
                        li = $('<li/>').css({ display: "none" }).appendTo(ul)
                        span = $('<span/>').appendTo(li) #.addClass(level_spans[level])
                        icon = $('<i/>').appendTo(span)
                        if (level == 3)
                                content= $('<a/>').attr("href", "/courses/"+data[i].id).text(data[i].value).appendTo(span)
                                icon.addClass('glyphicon glyphicon-minus-sign pointer')
                        else
                                content = $('<font/>').text(data[i].value).appendTo(span)
                                icon.addClass('glyphicon glyphicon-plus-sign pointer').click( (e) -> CourseDrillHandler.getInstance().performDrill(e)).attr('data-view', data[i].next_column).attr('data-filters', child_filter)
                )
                children = parent.find(" > ul > li")
                children.show "fast"
                parent.find('> span  > i').addClass('glyphicon-minus-sign').removeClass('glyphicon-plus-sign')
        )
