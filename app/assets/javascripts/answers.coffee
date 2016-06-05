# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

document.addEventListener 'turbolinks:load', ->

  $('form.new_answer').bind 'ajax:success', (e, data, status, xhr) ->
    answer = $.parseJSON(xhr.responseText)
    $('.answer__box').append(JST["templates/answer"]({answer: answer}))
    $('.answer__errors').html('')
    $('.new_answer #answer_body').val('')
  .bind 'ajax:error', (e, xhr, status, error) ->
    errors = $.parseJSON(xhr.responseText)
    $('.answer__errors').html('')
    $.each errors, (index, value) ->
      $('.answer__errors').append('<p>' + value + '</p>')

  $('.answer__edit_link').click ->
    console.log $('.answer__edit_form' + $(this).data('answerId'))
    $('.answer__edit_form').hide()
    $('.answer__edit_link').show()
    $(this).hide()
    $('.answer__edit_form' + $(this).data('answerId')).show(300)

  $('.answer__edit_form form').bind 'ajax:success', (e, data, status, xhr) ->
    answer = $.parseJSON(xhr.responseText)
    $('#answer_' + answer.id).html(answer.body)

  $('.answer__delete_link').click ->
    $(this).parent('.answer__item').hide(200)
