Rails.delegate(document, 'click', '#add_installment_payment .update_amount', function(e) {
  const form = byid('add_installment_payment');
  let val = parseFloat(form.qs('.payment_amount').dataset.amount);
  const toUpdate = form.qsa('.update_amount:checked');
  toUpdate.forEach( input => {
    val = val - parseFloat(input.dataset.recharge);
  })
  form.qs('.payment_amount').value = val.toFixed(2);
});
