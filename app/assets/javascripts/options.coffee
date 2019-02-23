window.bindAddPriceModal = (form) ->
  hoursField = form.qs('input.hours')
  valueField = form.qs('input.value')
  add = form.qs('button')
  add.addEventListener 'click', (e) ->
    e.preventDefault()
    hours = parseFloat(hoursField.value)
    fee = parseFloat(valueField.value)

    if hours < 1
      alert('La cantidad de horas es inválida')
    else if fee < 1
      alert('El precio es inválido')
    else if byid('fee_'+hours)
      alert('Ya hay un precio para esa cantidad de horas')
    else
      row = document.createElement 'TR'
      col1 = document.createElement 'TD'
      col2 = document.createElement 'TD'
      input = document.createElement 'INPUT'
      input.type = 'number'
      input.name = 'key[hour_fees]['+hours+']'
      input.id = 'fee_'+hours
      input.value = fee

      col1.innerHTML = hours
      col2.appendChild(input)
      row.appendChild(col1)
      row.appendChild(col2)

      tbody = qs('.hourly_fees tbody')
      trs = tbody.qsa('tr')
      inserted = false
      for tr in trs
        h = parseFloat(tr.qs('input').id.replace('fee_',''))
        if h > hours
          tbody.insertBefore(row, tr)
          inserted = true
          break

      tbody.appendChild(row) if !inserted

      closeModal()
