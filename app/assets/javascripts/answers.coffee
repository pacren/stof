# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

document.addEventListener 'turbolinks:load', ->
  $('form.new_answer').bind 'ajax:success', (e, data, status, xhr) ->
    answer = $.parseJSON(xhr.responseText)
    $('.answer_box').append('<p>' + answer.body + '</p>')
    $('.answer_errors').html('')
    $('.new_answer #answer_body').val('')
  .bind 'ajax:error', (e, xhr, status, error) ->
    errors = $.parseJSON(xhr.responseText)
    $('.answer_errors').html('')
    $.each errors, (index, value) ->
      $('.answer_errors').append('<p>' + value + '</p>')
