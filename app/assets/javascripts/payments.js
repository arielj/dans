onLoad(function(){  
  let form = byid('installment_payment');
  if (form) bindInstallmentPaymentForm(form);

  let params = new URLSearchParams(window.location.search);
  let receipt = parseInt(params.get("show_receipt"));
  if (receipt) showReceiptModal(receipt);
});

function bindInstallmentPaymentForm(form) {
  let toPayHint = byid('to_pay');
  let amountField = byid('money_transaction_amount');
  let dateRechargeCheck = form.qs('#ignore_recharge');
  let secondDateRechargeCheck = form.qs('#ignore_second_recharge');
  let monthRechargeCheck = form.qs('#ignore_month_recharge');

  if (dateRechargeCheck)
    dateRechargeCheck.addEventListener('change', e => {
      // update rest to pay
      setNewToPay(toPayHint, amountField, dateRechargeCheck, secondDateRechargeCheck, monthRechargeCheck);
    })

  if (secondDateRechargeCheck) {
    dateRechargeCheck.disabled = true;
    secondDateRechargeCheck.addEventListener('change', e => {
      dateRechargeCheck.disabled = !secondDateRechargeCheck.checked;
      // update rest to pay
      setNewToPay(toPayHint, amountField, dateRechargeCheck, secondDateRechargeCheck, monthRechargeCheck);
    })
  }

  if (monthRechargeCheck) {
    if (dateRechargeCheck) dateRechargeCheck.disabled = true;
    if (secondDateRechargeCheck) secondDateRechargeCheck.disabled = true;
    monthRechargeCheck.addEventListener('change', _e => {
      // disable the other checkbox
      if (secondDateRechargeCheck)
        secondDateRechargeCheck.disabled = !monthRechargeCheck.checked;
      else if (dateRechargeCheck)
        dateRechargeCheck.disabled = !monthRechargeCheck.checked;
      // update rest to pay
      setNewToPay(toPayHint, amountField, dateRechargeCheck, secondDateRechargeCheck, monthRechargeCheck);
    })
  }
}

function setNewToPay(toPayHint, amountField, dateRechargeCheck, secondDateRechargeCheck, monthRechargeCheck) {
  // updates the rest to pay hint
  let newValue = parseFloat(toPayHint.dataset.amount);

  if (monthRechargeCheck && monthRechargeCheck.checked)
    newValue = parseFloat(monthRechargeCheck.dataset.totalIgnoring)

  if (secondDateRechargeCheck && secondDateRechargeCheck.checked)
    newValue = parseFloat(secondDateRechargeCheck.dataset.totalIgnoring)

  if (dateRechargeCheck && dateRechargeCheck.checked)
    newValue = parseFloat(dateRechargeCheck.dataset.totalIgnoring)

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