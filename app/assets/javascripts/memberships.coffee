window.refresh_amount = ->
  durations = 0
  inputs = document.querySelectorAll('input.schedule:checked')
  for input in inputs
    durations += parseFloat(input.dataset.duration)

  document.querySelector('.hint_hours .hours').innerText = durations
  document.getElementById('membership_amount').value = Settings.hours_fees[durations+'']
