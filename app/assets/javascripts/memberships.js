function refreshAmount(form) {
  let schedulesIds = [...form.qsa('input.schedule:checked')].map( i => i.value);
  schedulesIds = schedulesIds.map( x => serializePair('schedules_ids[]', x)).join('&');

  let nonRegularFeeInput = byid('membership_use_non_regular_fee');
  if (nonRegularFeeInput)
    if (nonRegularFeeInput.checked)
      schedulesIds = schedulesIds + "&use_non_regular_fee=1"

  let manualDiscountCheck = byid('membership_use_manual_discount');
    if (manualDiscountCheck)
      if (manualDiscountCheck.checked) {
        const manualDiscountInput = byid('membership_manual_discount');
        const val = manualDiscountInput.value.replace('%', '')
        schedulesIds = schedulesIds + `&use_manual_discount=1&manual_discount=${val}`
      }
    

  getJSON(form.dataset.autoPriceUrl, {
    data: schedulesIds,
    success: function(resp) {
      const div = form.qs('.auto_calculation');
      let s = '';
      if (resp.fixedTotal !== "0,00")
        s += `Precio clases fijas: $${resp.fixedTotal} (o $${resp.fixedTotalWithDiscount})<br />`;

      if (resp.durationTotal !== "0,00")
        s += `Precio por ${resp.duration}hs: $${resp.durationTotal} (o $${resp.durationTotalWithDiscount})<br />`;

      s += `Subtotal: $${resp.subtotal} (o $${resp.subtotalWithDiscount})<br />`;
      if (resp.familyDiscount !== 0)
        s += `Descuento por grupo familiar (${resp.discount}): $${resp.discountTotal} (o $${resp.discountTotalWithDiscount})<br />`;

      div.innerHTML = s;
      
      const totalDiv = form.qs('.auto_calculation_total');
      totalDiv.innerHTML = `Total: $${resp.total} (o $${resp.totalWithDiscount})`;
    }
  });
};

function bindMembershipForm() {
  this.form = qs('#new_membership, .edit_membership');
  this.cal = this.form.qs('.schedules_calendar');
  Rails.delegate(this.cal, 'input.schedule', 'change', e => {
    refreshAmount(this.form);
  });
  bindSchedulesCalendar();

  this.useCalculatedAmountWrapper = byid('use_calculated_amount');

  this.useCustomAmountCheck = byid('membership_use_custom_amount');
  this.useCustomAmountInput = byid('membership_amount');
  this.useCustomAmountCheck.addEventListener('change', e => {
    let parent = this.useCustomAmountInput.closest('.input-group');
    if (e.target.checked) {
      parent.classList.remove('hidden');
      this.useCalculatedAmountWrapper.classList.add('hidden');
    } else {
      parent.classList.add('hidden');
      this.useCalculatedAmountWrapper.classList.remove('hidden');
    }
  })

  this.nonRegularFeeInput = byid('membership_use_non_regular_fee');
  this.nonRegularFeeInput.addEventListener('change', e => {
    refreshAmount(this.form);
  })

  this.useManualDiscountCheck = byid('membership_use_manual_discount');
  this.useManualDiscountInput = byid('membership_manual_discount');
  this.useManualDiscountCheck.addEventListener('change', e => {
    let parent = this.useManualDiscountInput.closest('.input-group');
    if (e.target.checked) {
      parent.classList.remove('hidden');
      this.useManualDiscountInput.focus();
    } else {
      parent.classList.add('hidden');
    }
    refreshAmount(this.form);
  })
  this.useManualDiscountInput.addEventListener('keydown', e => {
    if (e.key.length == 1 && e.key.match(/\D/)) e.preventDefault()

    if (e.key === '0' && this.useManualDiscountInput.value === "%") e.preventDefault()
  })

  this.useManualDiscountInput.addEventListener('input', e => {
    let val = e.target.value
    val = val.replace(/%.*/, '')
    if (val !== '') {
      val = parseInt(val)
      if (val > 100) val = 100
      if (val < 0) val = 0
      val = `${val}%`
      e.target.value = val
    }

    refreshAmount(this.form);
  })
}
