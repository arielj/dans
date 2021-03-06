onLoad(function(){  
  let form = byid('installment_payment')
  if (form) bindInstallmentPaymentForm(form)

  let params = new URLSearchParams(window.location.search)
  let receipt = parseInt(params.get("show_receipt"))
  if (receipt) showReceiptModal(receipt)
})

function bindInstallmentPaymentForm(form) {
  let toPayHint = byid('to_pay')
  let amountField = byid('money_transaction_amount')
  let dateRechargeCheck = form.qs('#ignore_recharge')
  let secondDateRechargeCheck = form.qs('#ignore_second_recharge')
  let monthRechargeCheck = form.qs('#ignore_month_recharge')
  let useAmountWithDiscount = form.qs('#use_amount_with_discount')

  if (dateRechargeCheck)
    dateRechargeCheck.addEventListener('change', e => {
      // update rest to pay
      setNewToPay(toPayHint, amountField, dateRechargeCheck, secondDateRechargeCheck, monthRechargeCheck, useAmountWithDiscount)
    })

  if (secondDateRechargeCheck) {
    dateRechargeCheck.disabled = true
    secondDateRechargeCheck.addEventListener('change', e => {
      dateRechargeCheck.disabled = !secondDateRechargeCheck.checked
      // update rest to pay
      setNewToPay(toPayHint, amountField, dateRechargeCheck, secondDateRechargeCheck, monthRechargeCheck, useAmountWithDiscount)
    })
  }

  if (monthRechargeCheck) {
    if (dateRechargeCheck) dateRechargeCheck.disabled = true
    if (secondDateRechargeCheck) secondDateRechargeCheck.disabled = true
    monthRechargeCheck.addEventListener('change', _e => {
      // disable the other checkbox
      if (secondDateRechargeCheck)
        secondDateRechargeCheck.disabled = !monthRechargeCheck.checked
      else if (dateRechargeCheck)
        dateRechargeCheck.disabled = !monthRechargeCheck.checked
      // update rest to pay
      setNewToPay(toPayHint, amountField, dateRechargeCheck, secondDateRechargeCheck, monthRechargeCheck, useAmountWithDiscount)
    })
  }

  if (useAmountWithDiscount) {
    useAmountWithDiscount.addEventListener('change', _e => {
      // update rest to pay
      setNewToPay(toPayHint, amountField, dateRechargeCheck, secondDateRechargeCheck, monthRechargeCheck, useAmountWithDiscount)
    })
  }
}

function setNewToPay(toPayHint, amountField, dateRechargeCheck, secondDateRechargeCheck, monthRechargeCheck, useAmountWithDiscount) {
  // updates the rest to pay hint
  let newValue = parseFloat(toPayHint.dataset.amount)
  let newValueWithDiscount = parseFloat(toPayHint.dataset.amountWithDiscount)

  if (monthRechargeCheck && monthRechargeCheck.checked) {
    newValue = parseFloat(monthRechargeCheck.dataset.totalIgnoring)
    newValueWithDiscount = parseFloat(monthRechargeCheck.dataset.totalIgnoringWithDiscount)
  }

  if (secondDateRechargeCheck && secondDateRechargeCheck.checked) {
    newValue = parseFloat(secondDateRechargeCheck.dataset.totalIgnoring)
    newValueWithDiscount = parseFloat(secondDateRechargeCheck.dataset.totalIgnoringWithDiscount)
  }

  if (dateRechargeCheck && dateRechargeCheck.checked) {
    newValue = parseFloat(dateRechargeCheck.dataset.totalIgnoring)
    newValueWithDiscount = parseFloat(dateRechargeCheck.dataset.totalIgnoringWithDiscount)
  }

  toPayHint.innerText = `$${newValue.toFixed(2).toString().replace('.', ',')} (o $${newValueWithDiscount.toFixed(2).toString().replace('.', ',')})`

  // cap the field value
  const valueToSet = useAmountWithDiscount.checked ? newValueWithDiscount : newValue
  amountField.value = valueToSet.toFixed(2).toString().replace('.', ',')
}

function bindAddPaymentsForm(form) {
  this.form = form
  this.checkboxes = form.qsa('input[type=checkbox]')
  this.amountInput = form.qs('input[name=amount]')
  this.selects = form.qsa('select.recharge')

  this.recalculateAmount = _ => {
    let total = 0
    this.checkboxes.forEach( check => {
      if (check.checked)
        total += parseFloat(check.dataset.toPay.replace(',', '.'))
    })

    this.amountInput.value = total.toFixed(2).replace('.', ',')
  }
  
  this.checkboxes.forEach( check => {
    check.addEventListener('change', e => {
      this.recalculateAmount()
    })
  })

  this.selects.forEach( select => {
    select.addEventListener('change', e => {
      const tr = e.target.closest('tr')
      const op = select.selectedOptions[0].dataset
      tr.qs('input[type=checkbox]').dataset.toPay = op.toPay
      tr.qs('td.amount').innerText = op.toPayS
      tr.qs('td.to_pay').innerText = op.toPay

      this.recalculateAmount()
    })
  })
}