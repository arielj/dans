refresh_amount = ->
  durations = 0
  $('input.schedule:checked').each (idx, el) ->
    durations += parseFloat($(el).data('duration'))

  $('.hint_hours').text("Precio para: "+durations+"hs")
  $('#membership_amount').val(Settings.hours_fees[durations+''])

$ ->
  $('input.schedule').on 'click', (e) ->
    refresh_amount()
