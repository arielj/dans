function refresh_amount(form) {
  let schedulesIds = [...form.qsa('input.schedule:checked')].map( i => i.value);
  schedulesIds = schedulesIds.map( x => serializePair('schedules_ids[]', x)).join('&');

  getJSON(form.dataset.autoPriceUrl, {
    data: schedulesIds,
    success: function(resp) {
      const div = form.qs('.auto_calculation');
      let s = '';
      if (resp.fixedTotal !== "0,00")
        s += 'Precio clases fijas: $' + resp.fixedTotal + "<br />";

      if (resp.durationTotal !== "0,00")
        s += 'Precio por ' + resp.duration + 'hs: $' + resp.durationTotal + "<br />";

      s += 'Subtotal: $' + resp.subtotal + "<br />";
      if (resp.discountTotal !== '0,00')
        s += 'Descuento por grupo familiar (' + resp.discount + '): $' + resp.discountTotal + "<br />";

      s += 'Total: $' + resp.total;
      div.innerHTML = s;
    }
  });
};

function bindNewMembership() {
  const form = byid('new_membership');
  const cal = form.qs('.schedules_calendar');
  Rails.delegate(cal, 'input.schedule', 'change', function(e) {
    refresh_amount(this.form);
  });
  bindSchedulesCalendar();
}
