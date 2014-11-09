# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Close the flash message
$(document).on 'click', '.js-close', (event) ->
  $('#flash-message').fadeOut('fast')


$(document).on 'page:update', (event) ->

  # Automatically dismiss flash messages after 5 seconds
  setTimeout ->
    $('#flash-message .js-close').click()
  , 5000

  # DateTime Picker
  $('#datetimepicker').datetimepicker
    language: 'en',
    pick12HourFormat: true
