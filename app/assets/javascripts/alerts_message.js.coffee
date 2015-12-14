close_alert = ->
    $("div.alert").fadeTo(500, 0).slideUp 500, ->
        $(this).remove();

window.setTimeout close_alert, 5000
