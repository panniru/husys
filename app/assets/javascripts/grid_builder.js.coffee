class GridBuilder
  @instance = null
  @getInstance:  ->
    if !@instance
        @instance = new CourseDrillHandler()
    @instance

  @buildGrid: ->
    exam_center = $("#exam_center_id").val()
    course_id = $("#reg_exam_id").val()
    exam_date = $("#exam_date").val() #"02/03/2014"
    url = "/registrations/avalable_slots?exam_center_id="+exam_center+"&course_id="+course_id+"&exam_date="+exam_date
    $.getJSON(url, (data)->
        str_html = "<tr>" #"<div>"
        for number in [9..18]
           str_html += "<td >" #"<div class='col-sm-1'>"
           if (data.indexOf(number) == -1)
                str_html += "<span class = 'label label-danger pointer' rel = 'grid-element' data-start_time = '"+number+"'><i class = 'glyphicon glyphicon-thumbs-down' style='width:47px;'></i></span>"
           else
                str_html += "<span class = 'label label-success pointer' rel = 'grid-element' data-start_time = '"+number+"'><i class = 'glyphicon glyphicon-thumbs-up' style='width:47px;'></i></span>"
           str_html += "</td>" #"</div>&nbsp&nbsp"

        str_html += "<td/>" #"<div class = 'col-sm-1'/>"
        str_html += "</tr>"
        $("#grid_data tbody").html(str_html)
        $("#grid_view").show()
        $("#grid_sumit").show()
    )


$ ->
   $('body').on('click', 'span[rel = "grid-element"]', (event)->
        $("#exam_start_time").val($(event.target).data('start_time'))
        if ($(this).hasClass('label-success'))
             $( this ).prop( "disabled", true )
             $( this ).removeClass( "label-success")
             $(".label-default").prop("disabled", false )
             $(".label-default").removeClass("label-default").addClass("label-success")
             $( this ).addClass( "label-default")
        else
             alert('Cannot Assign..!! \n Slot Not Available')

        )

   $('body').on('click', 'span[rel = "grid-availability"]', (event)->
        GridBuilder.buildGrid()
        )
