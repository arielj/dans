Rails.delegate document, 'click', '#add_installment_payment .update_amount', (e) ->
  form = document.getElementById('add_installment_payment')
  val = parseFloat(form.querySelector('.payment_amount').dataset.amount)
  toUpdate = form.querySelectorAll('.update_amount:checked')
  for input in toUpdate
    r = parseFloat(input.dataset.recharge)
    val = val-r
  form.querySelector('.payment_amount').value = val.toFixed(2)
