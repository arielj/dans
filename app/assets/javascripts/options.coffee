document.addEventListener 'turbolinks:load', (ev) ->
  $('#add_hour_fee').on 'click', (e) ->
    e.preventDefault()
    hours_field = $('<input type="text" placeholder="Horas" />')
    fee_field = $('<input type="text" placeholder="Valor" />')
    add = $('<button class="btn btn-primary">Agregar</button>')

    add.on 'click', (e) ->
      hours = hours_field.val()
      fee = fee_field.val()

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
        close_modal()

    show_modal("Agregar precio", [hours_field, fee_field], add)
