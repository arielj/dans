onLoad(function () {
  let form = byid("installment_payment");
  if (form) bindInstallmentPaymentForm(form);

  let params = new URLSearchParams(window.location.search);
  let receipt = parseInt(params.get("show_receipt"));
  if (receipt) showReceiptModal(receipt);
});

function bindInstallmentPaymentForm(form) {
  let toPayHint = byid("to_pay");
  let amountField = byid("money_transaction_amount");
  let dateRechargeCheck = form.qs("#ignore_recharge");
  let secondDateRechargeCheck = form.qs("#ignore_second_recharge");
  let useAmountWithDiscount = form.qs("#use_amount_with_discount");
  let paymentMethod = form.qs("#apply_extra_debit_charge");
  const buttons = form.qsa('button[type="submit"]');
  const restHint = form.qs(".rest");
  const restTemplate = restHint ? restHint.dataset.template : "";
  const tooHighError = form.qs(".tooHigh");

  amountField.addEventListener("input", (e) => {
    const toPay = parseFloat(
      paymentMethod.value === "1"
        ? toPayHint.dataset.amount
        : toPayHint.dataset.amountWithDiscount,
    );
    const amount = parseFloat(amountField.value);
    if (amount > toPay) {
      if (restHint) {
        restHint.innerText = restTemplate.replace("{rest}", amount - toPay);
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
  });

  if (restHint) {
  }

  if (dateRechargeCheck)
    dateRechargeCheck.addEventListener("change", (e) => {
      // update rest to pay
      setNewToPay(
        toPayHint,
        amountField,
        dateRechargeCheck,
        secondDateRechargeCheck,
      );
    });

  if (secondDateRechargeCheck) {
    dateRechargeCheck.disabled = true;
    secondDateRechargeCheck.addEventListener("change", (e) => {
      dateRechargeCheck.disabled = !secondDateRechargeCheck.checked;
      // update rest to pay
      setNewToPay(
        toPayHint,
        amountField,
        dateRechargeCheck,
        secondDateRechargeCheck,
      );
    });
  }

  if (useAmountWithDiscount) {
    useAmountWithDiscount.addEventListener("change", (_e) => {
      // update rest to pay
      setNewToPay(
        toPayHint,
        amountField,
        dateRechargeCheck,
        secondDateRechargeCheck,
      );
    });
  }

  if (paymentMethod) {
    paymentMethod.addEventListener("change", (_e) => {
      // update rest to pay
      setNewToPay(
        toPayHint,
        amountField,
        dateRechargeCheck,
        secondDateRechargeCheck,
      );
    });
  }
}

function setNewToPay(
  toPayHint,
  amountField,
  dateRechargeCheck,
  secondDateRechargeCheck,
) {
  const useAmountWithDiscount = byid("use_amount_with_discount");
  const paymentMethod = byid("apply_extra_debit_charge");
  const useDiscounted =
    (useAmountWithDiscount && useAmountWithDiscount.checked) ||
    !paymentMethod ||
    (paymentMethod && paymentMethod.value === "0");

  // updates the rest to pay hint
  let newValue = parseFloat(toPayHint.dataset.amount);
  let newValueWithDiscount = parseFloat(toPayHint.dataset.amountWithDiscount);

  if (secondDateRechargeCheck && secondDateRechargeCheck.checked) {
    newValue = parseFloat(secondDateRechargeCheck.dataset.totalIgnoring);
    newValueWithDiscount = parseFloat(
      secondDateRechargeCheck.dataset.totalIgnoringWithDiscount,
    );
  }

  if (dateRechargeCheck && dateRechargeCheck.checked) {
    newValue = parseFloat(dateRechargeCheck.dataset.totalIgnoring);
    newValueWithDiscount = parseFloat(
      dateRechargeCheck.dataset.totalIgnoringWithDiscount,
    );
  }

  toPayHint.innerText = `$${newValueWithDiscount
    .toFixed(2)
    .toString()
    .replace(".", ",")} (efectivo) o $${newValue
    .toFixed(2)
    .toString()
    .replace(".", ",")} (débito)`;

  // cap the field value
  const valueToSet = useDiscounted ? newValueWithDiscount : newValue;
  amountField.value = valueToSet.toFixed(2).toString().replace(".", ",");
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
