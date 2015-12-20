ready = ->
  $('tbody.rowlink').rowlink()

$(document).ready(ready)
$(document).on('page:load', ready)
