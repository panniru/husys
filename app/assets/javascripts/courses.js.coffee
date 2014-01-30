class window.CourseDrillHandler
  @instance = null
  @getInstance:  ->
    if !@instance
        @instance = new CourseDrillHandler()
    @instance
  performDrill: (event)->
    url = 'courses/index.json(:)'
    drillItem = $(event.target).attr("data-category")
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
        $.getJSON('/home/exam_centers_geo', (data)->
                data1 = ['subCourse1', 'subCourse2', 'subCourse3']
                parent.addClass('parent_li')
                ul = $('<ul/>').appendTo(parent)
                $.each(data1, (i) ->
                        li = $('<li/>').css({ display: "none" }).appendTo(ul)
                        span = $('<span/>').appendTo(li)
                        icon = $('<i/>').addClass('glyphicon glyphicon-plus-sign pointer').click( (e) -> CourseDrillHandler.getInstance().performDrill(e)).appendTo(span)
                        content = $('<a/>').text(data1[i]).appendTo(span)
                )
                children = parent.find(" > ul > li")
                children.show "fast"
                parent.find('> span  > i').addClass('glyphicon-minus-sign').removeClass('glyphicon-plus-sign')
        )
