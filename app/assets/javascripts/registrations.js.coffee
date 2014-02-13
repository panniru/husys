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
   $('body').on('click', 'a[rel = "question-nav-submit"]', (event)->
        $("#action_for").val("submit")
        $("form#ol_exam").submit()
        )
   $("[data-countdown]").each ->
        $this = $(this)
        finalDate = $(this).data("countdown")
        $this.countdown finalDate, (event) ->
                $this.html event.strftime("%D days %H:%M:%S")
                if event.strftime("%D-%H-%M-%S") == '00-00-00-00'
                        $("#take_exam").show()

   $('a[ rel = "course_name"]').tooltip({animation: true, placement: 'bottom', html: true, delay: { show: 200, hide: 100 }})
   $('a[ rel = "center_address"]').tooltip({animation: true, placement: 'bottom', html: true})
