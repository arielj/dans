onLoad(function () {
  let form = byid("installment_payment");
  if (form) bindInstallmentPaymentForm(form);

  let params = new URLSearchParams(window.location.search);
  let receipt = parseInt(params.get("show_receipt"));
  if (receipt) showReceiptModal(receipt);
});

function bindInstallmentPaymentForm(form) {
  // data from backend
  const baseAmount = parseFloat(form.dataset.baseAmount);
  const firstSurchargeAmount = parseFloat(form.dataset.firstSurchargeAmount);
  const secondSurchargeAmount = parseFloat(form.dataset.secondSurchargeAmount);
  const debitExtra = parseFloat(form.dataset.debitExtra);

  // current totals based on checkboxes and data from backend
  let finalAmount = baseAmount;
  if (secondSurchargeAmount !== 0) finalAmount += secondSurchargeAmount;
  else finalAmount += firstSurchargeAmount;

  // elements
  let toPayHint = byid("to_pay");
  let amountField = byid("money_transaction_amount");
  let ignoreFirstSurchargeCheck = form.qs("#ignore_first_surcharge");
  let ignoreSecondSurchargeCheck = form.qs("#ignore_second_surcharge");
  let ignoreDebitExtraCheck = form.qs("#ignore_debit_extra");
  let paymentMethod = form.qs("#payment_method");
  const buttons = form.qsa('button[type="submit"]');
  const restHint = form.qs(".rest");
  const restTemplate = restHint ? restHint.dataset.template : "";
  const tooHighError = form.qs(".tooHigh");

  // calculate if current amount is greated than total
  const refreshRest = () => {
    const amount = parseFloat(amountField.value);
    if (amount > finalAmount) {
      if (restHint) {
        restHint.innerText = restTemplate.replace(
          "{rest}",
          amount - finalAmount,
        );
        restHint.classList.remove("hidden");
      } else {
        buttons.forEach((b) => (b.disabled = true));
        tooHighError.classList.remove("hidden");
      }
    } else {
      if (restHint) {
        restHint.innerText = "";
        restHint.classList.add("hidden");
      } else {
        buttons.forEach((b) => (b.disabled = false));
        tooHighError.classList.add("hidden");
      }
    }
  };

  // calculate new totals based on checkboxes
  const refreshAmount = () => {
    let newAmount = baseAmount;

    let surcharge = 0;
    if (ignoreSecondSurchargeCheck) {
      if (secondSurchargeAmount && !ignoreSecondSurchargeCheck.checked) {
        surcharge = secondSurchargeAmount;
      } else if (firstSurchargeAmount && !ignoreFirstSurchargeCheck.checked) {
        surcharge = firstSurchargeAmount;
      }
    } else if (ignoreSecondSurchargeCheck) {
      if (firstSurchargeAmount && !ignoreFirstSurchargeCheck.checked) {
        surcharge = firstSurchargeAmount;
      }
    }
    newAmount += surcharge;

    toPayHint.innerText = `$${newAmount
      .toFixed(2)
      .toString()
      .replace(".", ",")} (efectivo) o $${(newAmount + debitExtra)
      .toFixed(2)
      .toString()
      .replace(".", ",")} (débito)`;

    // 0 = efectivo, 1 y 2 = débito
    if (paymentMethod.value != "cash" && !ignoreDebitExtraCheck.checked) {
      newAmount += debitExtra;
    }

    finalAmount = newAmount;
    amountField.value = newAmount.toFixed(2).toString().replace(".", ",");

    refreshRest();
  };

  amountField.addEventListener("input", refreshRest);
  [
    ignoreFirstSurchargeCheck,
    ignoreSecondSurchargeCheck,
    ignoreDebitExtraCheck,
    paymentMethod,
  ].forEach((input) => {
    if (input) input.addEventListener("change", refreshAmount);
  });
}

function bindAddPaymentsForm(form) {
  this.form = form;
  this.checkboxes = form.qsa("input[type=checkbox][data-to-pay]");
  this.amountInput = form.qs("input[name=amount]");
  this.selects = form.qsa("select.recharge");
  const rows = form.qsa("tr[data-to-pay]");
  const withDiscount = form.qs("#use_amount_with_discount");

  withDiscount.addEventListener("click", (e) => {
    rows.forEach((tr) => {
      updateRow(tr);
    });
    this.recalculateAmount();
  });

  const updateRow = (row) => {
    const select = row.qs("select.recharge");
    const checkbox = row.qs("input[type=checkbox]");

    if (select) {
      const op = select.selectedOptions[0].dataset;
      checkbox.dataset.toPayWithDiscount = op.toPayWithDiscount;
      checkbox.dataset.toPayWithDiscountS = op.toPayWithDiscountS;
      checkbox.dataset.toPay = op.toPay;
      checkbox.dataset.toPayS = op.toPayS;
    }

    const amount = row.qs("td.amount");
    if (withDiscount.checked) {
      amount.innerText = amount.dataset.amountWithDiscountS;
      row.qs("td.to_pay").innerText = checkbox.dataset.toPayWithDiscountS;
    } else {
      amount.innerText = amount.dataset.amountS;
      row.qs("td.to_pay").innerText = checkbox.dataset.toPayS;
    }
  };

  this.recalculateAmount = (_) => {
    let total = 0;
    this.checkboxes.forEach((check) => {
      if (check.checked) {
        const amount = withDiscount.checked
          ? check.dataset.toPayWithDiscount
          : check.dataset.toPay;
        total += parseFloat(amount.replace(",", "."));
      }
    });

    this.amountInput.value = total.toFixed(2).replace(".", ",");
  };

  this.checkboxes.forEach((check) => {
    check.addEventListener("change", (e) => {
      this.recalculateAmount();
    });
  });

  this.selects.forEach((select) => {
    select.addEventListener("change", (e) => {
      updateRow(select.closest("tr"));

      this.recalculateAmount();
    });
  });
}
