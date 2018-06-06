$(document).on 'click', '#add_installment_payment .update_amount', (e) ->
  form = $('#add_installment_payment')
  val = parseFloat(form.find('.payment_amount').data('amount'))
  form.find('.update_amount:checked').each (idx, el) ->
    r = parseFloat($(el).data('recharge'))
    val = val-r
  form.find('.payment_amount').val(val.toFixed(2))
