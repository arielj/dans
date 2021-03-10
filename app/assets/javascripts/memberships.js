function refreshAmount(form) {
  let schedulesIds = [...form.qsa('input.schedule:checked')].map( i => i.value);
  schedulesIds = schedulesIds.map( x => serializePair('schedules_ids[]', x)).join('&');

  let nonRegularFeeInput = byid('membership_use_non_regular_fee');
  if (nonRegularFeeInput)
    if (nonRegularFeeInput.checked)
      schedulesIds = schedulesIds + "&use_non_regular_fee=1"

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
      if (resp.discountTotal !== '0,00')
        s += `Descuento por grupo familiar (${resp.discount}): $${resp.discountTotal} (o $${resp.discountTotalWithDiscount})<br />`;

      s += `Total: $${resp.total} (o $${resp.totalWithDiscount})`;
      div.innerHTML = s;
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

  this.useCustomAmountCheck = byid('membership_use_custom_amount');
  this.useCustomAmountInput = byid('membership_amount');
  this.useCustomAmountCheck.addEventListener('change', e => {
    let parent = this.useCustomAmountInput.closest('.input-group');
    if (e.target.checked)
      parent.classList.remove('hidden');
    else
      parent.classList.add('hidden');
  })

  this.nonRegularFeeInput = byid('membership_use_non_regular_fee');
  this.nonRegularFeeInput.addEventListener('change', e => {
    refreshAmount(this.form);
  })
}
