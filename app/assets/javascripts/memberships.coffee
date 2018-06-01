refresh_amount = ->
  durations = 0
  $('input.schedule:checked').each (idx, el) ->
    durations += parseFloat($(el).data('duration'))

  $('.hint_hours .hours').text(durations)
  $('#membership_amount').val(Settings.hours_fees[durations+''])

document.addEventListener 'turbolinks:load', (ev) ->
  $('input.schedule').on 'click', (e) ->
    refresh_amount()
