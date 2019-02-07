Rails.delegate document, 'click', '#add_installment_payment .update_amount', (e) ->
  form = byid('add_installment_payment')
  val = parseFloat(form.querySelector('.payment_amount').dataset.amount)
  toUpdate = qsa('.update_amount:checked', form)
  for input in toUpdate
    r = parseFloat(input.dataset.recharge)
    val = val-r
  qs('.payment_amount', form).value = val.toFixed(2)
