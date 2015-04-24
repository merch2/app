# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.edit-answer-link').click (e) ->
    e.preventDefault();
    $(this).hide();
    answer_id = $(this).data('answerId')
    $("form#edit-answer-#{answer_id}").show()

  $('form.edit_answer').bind 'ajax:success', (e, data, status, xhr) ->
    vote_count = $.parseJSON(xhr.responseText)
    $('form#edit-answer-' + answer.id).hide()
    $('#answer' + answer.id).html('<p>' + answer.body + '</p>')
    $('#answer' + answer.id).show()
  .bind 'ajax:error', (e, xhr, status, error) ->
    errors = $.parseJSON(xhr.responseText)
    $.each errors, (index, value) ->
      $('.answer-errors').append(value)



  PrivatePub.subscribe "/questions", (data, channel) ->
    console.log(data)
    question = $.parseJSON(data['question'])
    $('.questions').append('<p><a href=\'questions/' + question.id + '\'>' + question.title + '</a></p>')