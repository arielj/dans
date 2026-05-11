function refreshAmount(form) {
  const useCustomAmountCheck = byid("membership_use_custom_amount");
  const totalDiv = form.qs(".auto_calculation_total");
  const totalSpan = totalDiv.qs("span");
  const totalDetails = totalDiv.qs(".details");
  const customAmountInput = byid("membership_amount");
  const customAmountInputWithDiscount = byid("membership_amount_with_discount");

  if (useCustomAmountCheck.checked) {
    let amount = customAmountInput.value;
    const amountWithDiscount = customAmountInputWithDiscount.value;
    const amountF = parseFloat(amount.replace(",", "."));
    const amountWithDiscountF = parseFloat(
      amountWithDiscount.replace(",", "."),
    );

    // if (amountF - amountWithDiscountF > 350) {
    //   amount = amountWithDiscountF + 350 + "";
    //   totalDiv.classList.add("limited-total");
    // } else {
    //   totalDiv.classList.remove("limited-total");
    // }

    totalSpan.innerHTML = `Total: $${amountWithDiscount} (efectivo) o $${amount} (débito))`;
    return;
  }

  let schedulesIds = [...form.qsa("input.schedule:checked")].map(
    (i) => i.value,
  );
  schedulesIds = schedulesIds
    .map((x) => serializePair("schedules_ids[]", x))
    .join("&");

  const manualDiscountCheck = byid("membership_use_manual_discount");
  if (manualDiscountCheck)
    if (manualDiscountCheck.checked) {
      const manualDiscountInput = byid("membership_manual_discount");
      const val = manualDiscountInput.value.replace("%", "");
      schedulesIds =
        schedulesIds + `&use_manual_discount=1&manual_discount=${val}`;
    }

  getJSON(form.dataset.autoPriceUrl, {
    data: schedulesIds,
    success: function (resp) {
      const div = form.qs(".auto_calculation");
      let s = "";

      s += `Subtotal: $${resp.subtotal}<br />`;

      if (resp.totalDiscountPer !== 0) {
        if (resp.useManualDiscount) {
          if (resp.manualDiscountPer !== 0)
            s += `Descuento manual: ${resp.manualDiscountPer}%<br />`;
        } else {
          if (resp.klassesDiscountPer !== 0)
            s += `Descuento de materias (${resp.klassesCount}): ${resp.klassesDiscountPer}%<br />`;
          if (resp.familyDiscountPer !== 0)
            s += `Descuento por grupo familiar: ${resp.familyDiscountPer}%<br />`;
          if (resp.teacherDiscountPer !== 0)
            s += `Descuento por profe: ${resp.teacherDiscountPer}%<br />`;
        }
        s += `Descuento total (${resp.totalDiscountPer}%): $${resp.totalDiscount}<br />`;
      }

      div.innerHTML = s;

      totalSpan.innerHTML = `Total: $${resp.totalCash} (efectivo) o $${resp.totalDebit} (débito)`;

      totalDetails.innerHTML = resp.details.join("<br>");

      if (resp.limitedTotal) {
        totalDiv.classList.add("limited-total");
      } else {
        totalDiv.classList.remove("limited-total");
      }

      customAmountInput.value = resp.totalDebit;
      customAmountInputWithDiscount.value = resp.totalCash;
    },
  });
}

function bindMembershipForm() {
  const form = qs("#new_membership, .edit_membership");
  const cal = form.qs(".schedules_calendar");
  Rails.delegate(cal, "input.schedule", "change", (e) => {
    refreshAmount(form);
  });
  bindSchedulesCalendar();

  // const useCalculatedAmountWrapper = byid("use_calculated_amount");
  const useCustomAmountCheck = byid("membership_use_custom_amount");
  const useCustomAmountWrapper = byid("use_manual_amount");
  useCustomAmountCheck.addEventListener("change", (e) => {
    if (e.target.checked) {
      useCustomAmountWrapper.classList.remove("hidden");
      // useCalculatedAmountWrapper.classList.add("hidden");
    } else {
      useCustomAmountWrapper.classList.add("hidden");
      // useCalculatedAmountWrapper.classList.remove("hidden");
    }
    refreshAmount(form);
  });
  const customAmountInputs = qsa(
    "#membership_amount, #membership_amount_with_discount",
  );
  customAmountInputs.forEach((i) => {
    i.addEventListener("input", () => refreshAmount(form));
  });

  const useManualDiscountCheck = byid("membership_use_manual_discount");
  const useManualDiscountInput = byid("membership_manual_discount");
  useManualDiscountCheck.addEventListener("change", (e) => {
    const parent = useManualDiscountInput.closest(".input-group");
    if (e.target.checked) {
      parent.classList.remove("hidden");
      useManualDiscountInput.focus();
    } else {
      parent.classList.add("hidden");
    }
    refreshAmount(form);
  });

  useManualDiscountInput.addEventListener("keydown", (e) => {
    if (e.key.length == 1 && e.key.match(/\D/)) e.preventDefault();

    if (e.key === "0" && useManualDiscountInput.value === "%")
      e.preventDefault();
  });

  const discountTimer = false;
  useManualDiscountInput.addEventListener("input", (e) => {
    const el = e.target;

    if (discountTimer) clearTimeout(discountTimer);

    discountTimer = setTimeout(() => {
      let val = el.value;
      val = val.replace(/%.*/, "");
      if (val !== "") {
        val = parseInt(val);
        if (val > 100) val = 100;
        if (val < 0) val = 0;
        val = `${val}%`;
        el.value = val;
      }
      refreshAmount(form);
    }, 50);
  });
}
