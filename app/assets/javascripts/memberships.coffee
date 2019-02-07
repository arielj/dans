window.refresh_amount = (form) ->
  schedulesIds = (i.value for i in qsa('input.schedule:checked', form))
  schedulesIds = schedulesIds.map((x) ->
    serializePair('schedules_ids[]', x)).join('&')
  getJSON({url: form.dataset.autoPriceUrl, data: schedulesIds, success: (resp) ->
    div = qs('.auto_calculation', form)
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

window.bindSchedulesCalendar = (element) ->
  filter = qs('#filter_schedules', element)
  filter.focus()
  filter.addEventListener 'input', (e) ->
    val = this.value
    regexp = new RegExp(".*"+val+".*")
    schs = qsa('.day label', element)
    for sch in schs
      cls = sch.classList
      if (val != '')
        if (regexp.test(sch.innerText))
          cls.remove('hidden')
        else
          cls.add('hidden')
      else
        cls.remove('hidden')

window.bindNewMembership = ->
  form = byid('new_membership')
  cal = qs('.schedules_calendar', form)
  schs = qsa('input.schedule', cal)
  for sch in schs
    sch.addEventListener 'change', (e) ->
      refresh_amount(sch.form)

  bindSchedulesCalendar(cal)
