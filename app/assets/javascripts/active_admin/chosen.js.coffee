@chosenify = (entry) ->
  $(entry).chosen
    allow_single_deselect: true

$ ->
  chosenSelector = '.chosen'

  chosenify(chosenSelector)

  $('.has_many_add').on('click', -> setTimeout(chosenify.bind(null, chosenSelector), 100))
