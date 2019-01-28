window.bindAddPriceModal = (form) ->
  hoursField = form.querySelector('input.hours')
  valueField = form.querySelector('input.value')
  add = form.querySelector('button')
  add.addEventListener 'click', (e) ->
    e.preventDefault()
    hours = hoursField.value
    fee = valueField.value

    if $('#fee_'+hours).length
      alert('Ya hay un precio para esa cantidad de horas')
    else
      row = $('<div class="row" />')
      col1 = $('<div class="col-3" />')
      col2 = $('<div class="col-3" />')
      input = $('<input type="text" name="key[hour_fees]['+hours+']" id="fee_'+hours+'" />')
      input.val(fee)

      col1.html(hours)
      col2.html(input)
      row.append(col1)
      row.append(col2)

      $('#hour_fees').append(row)
      closeModal()
