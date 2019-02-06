window.refresh_amount = (form) ->
  schedulesIds = (i.value for i in form.querySelectorAll('input.schedule:checked'))
  schedulesIds = schedulesIds.map((x) ->
    serializePair('schedules_ids[]', x)).join('&')
  getJSON({url: form.dataset.autoPriceUrl, data: schedulesIds, success: (resp) ->
    div = form.querySelector('.auto_calculation')
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
  filter = element.querySelector('#filter_schedules')
  filter.focus()
  filter.addEventListener 'input', (e) ->
    val = this.value
    regexp = new RegExp(".*"+val+".*")
    schs = element.querySelectorAll('.day label')
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
  form = document.getElementById('new_membership')
  cal = form.querySelector('.schedules_calendar')
  schs = cal.querySelectorAll('input.schedule')
  for sch in schs
    sch.addEventListener 'change', (e) ->
      refresh_amount(sch.form)

  bindSchedulesCalendar(cal)
