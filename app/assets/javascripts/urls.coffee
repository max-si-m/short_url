# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $('#new_url').submit ->
    address = $(this).find('#url_address').val()
    if /https?/gi.test(address) == false
      alert 'Only urls! :)'
      false
  false