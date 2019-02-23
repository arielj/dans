window.refresh_amount = (form) ->
  schedulesIds = (i.value for i in qsa('input.schedule:checked', form))
  schedulesIds = schedulesIds.map((x) ->
    serializePair('schedules_ids[]', x)).join('&')
  getJSON(form.dataset.autoPriceUrl, {data: schedulesIds, success: (resp) ->
    div = form.qs('.auto_calculation')
    s = ''
    if resp.fixedTotal != "0,00"
      s = s+'Precio clases fijas: $'+resp.fixedTotal+"<br />"
    if resp.durationTotal != "0,00"
      s = s+'Precio por '+resp.duration+'hs: $'+resp.durationTotal+"<br />"
    s = s+'Subtotal: $'+resp.subtotal+"<br />"
    if resp.discountTotal != '0,00'
      s = s+'Descuento por grupo familiar ('+resp.discount+'): $'+resp.discountTotal+"<br />"
    s = s+'Total: $'+resp.total

    div.innerHTML = s
  })

window.bindNewMembership = ->
  form = byid('new_membership')
  cal = form.qs('.schedules_calendar')
  Rails.delegate cal, 'input.schedule', 'change', (e) ->
    refresh_amount(this.form)

  bindSchedulesCalendar()
