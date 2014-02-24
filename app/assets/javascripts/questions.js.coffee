toggleOptions = (id) ->
        action = $("form#new_question").attr('action')
        if $(id).is(':checked')
                $('#question-options').hide()
                if typeof action != 'undefined'
                        $("form#new_question").attr('action', action.replace("/questions", "/descriptive_questions"))
        else
                $('#question-options').show()
                if typeof action != 'undefined'
                        $("form#new_question").attr('action', action.replace("/descriptive_questions", "/questions"))
$ ->
   $('#question_is_descriptive').on('change', (event) ->
        toggleOptions(this)
        )

   toggleOptions('#question_is_descriptive')
