(function(){
  let form = byid('add_installment_payment');
  if (form) bindInstallmentPaymentForm(form);
})();

function bindInstallmentPaymentForm(form) {
  let toPayHint = byid('to_pay');
  let amountField = byid('payment_amount');
  let dateRechargeCheck = form.qs('#ignore_recharge');
  let monthRechargeCheck = form.qs('#ignore_month_recharge');

  if (dateRechargeCheck)
    dateRechargeCheck.addEventListener('change', e => {
      // update rest to pay
      setNewToPay(toPayHint, amountField, dateRechargeCheck, monthRechargeCheck);
    })

  if (monthRechargeCheck)
    dateRechargeCheck.disabled = true;
    monthRechargeCheck.addEventListener('change', e => {
      // disable the other checkbox
      dateRechargeCheck.disabled = !monthRechargeCheck.checked;
      // update rest to pay
      setNewToPay(toPayHint, amountField, dateRechargeCheck, monthRechargeCheck);
    })
}

function calculateRecharge(dateRechargeCheck, monthRechargeCheck) {
  if (!dateRechargeCheck && !monthRechargeCheck)
    return 0;

  if (!monthRechargeCheck || monthRechargeCheck.checked)
    if (!dateRechargeCheck || dateRechargeCheck.checked)
      return 0;
    else
      return parseFloat(dateRechargeCheck.dataset.recharge);

  if (monthRechargeCheck && !monthRechargeCheck.checked)
    return parseFloat(monthRechargeCheck.dataset.recharge);

  return 0;
}

function setNewToPay(toPayHint, amountField, dateRechargeCheck, monthRechargeCheck) {
  // updates the rest to pay hint
  let newValue = parseFloat(toPayHint.dataset.amountIgnoringRecharge);
  newValue += calculateRecharge(dateRechargeCheck, monthRechargeCheck);
  toPayHint.innerText = `$${newValue.toFixed(2).toString().replace('.', ',')}`;

  // cap the field value
  let currentAmount = parseFloat(amountField.value.replace(',', '.'));
  if (currentAmount > newValue)
    amountField.value = newValue.toFixed(2).toString().replace('.', ',');
}

function bindAddPaymentsForm(form) {
  this.form = form;
  this.checkboxes = form.qsa('input[type=checkbox]');
  this.amountInput = form.qs('input[name=amount]');

  this.recalculateAmount = _ => {
    let total = 0;
    this.checkboxes.forEach( check => {
      debugger;
      if (check.checked)
        total += parseFloat(check.dataset.toPay.replace(',', '.'));
    })

    this.amountInput.value = total.toFixed(2).replace('.', ',');
  }
  
  this.checkboxes.forEach( check => {
    check.addEventListener('change', e => {
      this.recalculateAmount();
    })
  })
}