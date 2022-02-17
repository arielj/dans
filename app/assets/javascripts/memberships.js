function refreshAmount(form) {
  let schedulesIds = [...form.qsa("input.schedule:checked")].map(
    (i) => i.value
  );
  schedulesIds = schedulesIds
    .map((x) => serializePair("schedules_ids[]", x))
    .join("&");

  let nonRegularFeeInput = byid("membership_use_non_regular_fee");
  if (nonRegularFeeInput)
    if (nonRegularFeeInput.checked)
      schedulesIds = schedulesIds + "&use_non_regular_fee=1";

  let manualDiscountCheck = byid("membership_use_manual_discount");
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
      if (resp.fixedTotal !== "0,00")
        s += `Precio clases fijas: $${resp.fixedTotal} (o $${resp.fixedTotalWithDiscount})<br />`;

      if (resp.durationTotal !== "0,00")
        s += `Precio por ${resp.duration}hs: $${resp.durationTotal} (o $${resp.durationTotalWithDiscount})<br />`;

      s += `Subtotal: $${resp.subtotal} (o $${resp.subtotalWithDiscount})<br />`;
      if (resp.familyDiscount !== 0)
        s += `Descuento por grupo familiar (${resp.discount}): $${resp.discountTotal} (o $${resp.discountTotalWithDiscount})<br />`;

      div.innerHTML = s;

      const totalDiv = form.qs(".auto_calculation_total");
      totalDiv.innerHTML = `Total: $${resp.total} (o $${resp.totalWithDiscount})`;

      if (resp.discountTooHigh) {
        totalDiv.classList.add("discount-too-high");
      } else {
        totalDiv.classList.remove("discount-too-high");
      }

      byid("membership_amount").value = resp.total;
      byid("membership_amount_with_discount").value = resp.totalWithDiscount;
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

  const useCalculatedAmountWrapper = byid("use_calculated_amount");
  const useCustomAmountCheck = byid("membership_use_custom_amount");
  const useCustomAmountWrapper = byid("use_manual_amount");
  useCustomAmountCheck.addEventListener("change", (e) => {
    if (e.target.checked) {
      useCustomAmountWrapper.classList.remove("hidden");
      parentWithDiscount.classList.remove("hidden");
      useCalculatedAmountWrapper.classList.add("hidden");
    } else {
      useCustomAmountWrapper.classList.add("hidden");
      parentWithDiscount.classList.add("hidden");
      useCalculatedAmountWrapper.classList.remove("hidden");
    }
  });

  const nonRegularFeeInput = byid("membership_use_non_regular_fee");
  nonRegularFeeInput.addEventListener("change", (e) => {
    refreshAmount(form);
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
