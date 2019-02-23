Rails.delegate document, 'click', '#add_installment_payment .update_amount', (e) ->
  form = byid('add_installment_payment')
  val = parseFloat(form.qs('.payment_amount').dataset.amount)
  toUpdate = form.qsa('.update_amount:checked')
  for input in toUpdate
    r = parseFloat(input.dataset.recharge)
    val = val-r
  form.qs('.payment_amount').value = val.toFixed(2)
