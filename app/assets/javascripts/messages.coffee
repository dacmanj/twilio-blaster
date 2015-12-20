# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->

  #put url from image library in form field
  select_image_from_library = ->
    url = $("#message_img_for_media_url").val()
    $("#message_media_url").val(url)
  $("#message_img_for_media_url").change select_image_from_library

  #unselect image library selection when url is changed
  blank_message_img_for_media_url_on_url_input_keypress = ->
    $("#message_img_for_media_url").val("")
  $("#message_media_url").keypress blank_message_img_for_media_url_on_url_input_keypress

  fill_out_to_field = ->
    to = ""
    grp = $("#message_group_ids :selected").map (i,v) ->
      "["+$(v).html()+"]"
    ppl = $("#message_contact_ids :selected").map (i,v) ->
      "[#{$(v).attr('data-name')} <#{$(v).attr('data-phone-number')}>]"
    to = jQuery.merge(grp.toArray(),ppl.toArray()).join(", ")
    $("#message_to").val(to)
  $("#message_group_ids, #message_contact_ids").change fill_out_to_field

$(document).ready(ready)
$(document).on('page:load', ready)
