window.get_sub = (event) ->
        url = "/courses/hierarchy?view_by=sub_category&filters="+$(event.target).val()

        $.getJSON(url, (data)->
                parent = $("#reg_sub_cat")
                parent.empty().append("<option value = ' '> </option>")
                $.each(data, (i) ->
                        $("<option>").val(data[i].value).text(data[i].value).appendTo(parent)
                        )
                )

window.get_course = (event) ->
        filter = window.$("#reg_cat").val()+","+$(event.target).val()
        url = "/courses/hierarchy?view_by=course_name&filters="+filter
        $.getJSON(url, (data)->
                parent = $("#reg_course")
                parent.empty().append("<option value = ' '> </option>")
                $.each(data, (i) ->
                        $("<option>").val(data[i].value).text(data[i].value).appendTo(parent)
                        )
                )

window.get_exam = (event) ->
        filter = $("#reg_cat").val()+","+$("#reg_sub_cat").val()+","+$(event.target).val()
        url = "/courses/hierarchy?filters="+filter
        $.getJSON(url, (data)->
                parent = $("#reg_exam_id")
                parent.empty().append("<option value = ' '> </option>")
                $.each(data, (i) ->
                        $("<option>").val(data[i].id).text(data[i].value).appendTo(parent)
                        )
                )


$ ->
   $('.datepicker').datepicker()

   $('body').on('click', 'a[rel = "question-nav-next"]', (event)->
        $("#action_for").val("next")
        $("form#ol_exam").submit()
        )

   $('body').on('click', 'a[rel = "question-nav-prev"]', (event)->
        $("#action_for").val("prev")
        $("form#ol_exam").submit()
        )
