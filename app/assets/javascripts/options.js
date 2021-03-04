function bindAddPriceModal(form) {
  const hoursField = form.qs('input.hours');
  const valueWithoutDiscountField = form.qs('input.value_without_discount');
  const valueWithDiscountField = form.qs('input.value_with_discount');
  const add = form.qs('button');
  add.addEventListener('click', function(e) {
    e.preventDefault();
    const hours = parseFloat(hoursField.value);
    const feeWithout = parseFloat(valueWithoutDiscountField.value);
    const feeWith = parseFloat(valueWithDiscountField.value);
    if (hours < 1 || isNaN(hours)) {
      return alert('La cantidad de horas es inválida');
    } else if (feeWithout < 1 || isNaN(feeWithout)) {
      return alert('El precio sin descuento es inválido');
    } else if (feeWith < 1 || isNaN(feeWith)) {
      return alert('El precio con descuento es inválido');
    } else if (byid('fee_' + hours)) {
      return alert('Ya hay un precio para esa cantidad de horas');
    } else {
      const row = document.createElement('TR');
      row.dataset.hours = hours;
      const col1 = document.createElement('TD');
      const col2 = document.createElement('TD');
      const col3 = document.createElement('TD');
      const input1 = document.createElement('INPUT');
      const input2 = document.createElement('INPUT');
      input1.type = 'number';
      input1.name = 'key[hour_fees][' + hours + '][]';
      input1.id = 'fee_' + hours;
      input1.value = feeWithout;
      input2.type = 'number';
      input2.name = 'key[hour_fees][' + hours + '][]';
      input2.id = 'fee_' + hours;
      input2.value = feeWith;
      col1.innerHTML = hours;
      col2.appendChild(input1);
      col3.appendChild(input2);
      row.appendChild(col1);
      row.appendChild(col2);
      row.appendChild(col3);
      const tbody = qs('.hourly_fees tbody');
      const trs = tbody.qsa('tr');

      let inserted = false;
      trs.forEach( tr => {
        if (!inserted) {
          h = parseFloat(tr.qs('input').id.replace('fee_', ''));
          if (h > hours) {
            tr.insertAdjacentElement('beforebegin', row);
            inserted = true;
          }
        }
      })

      if (!inserted) tbody.appendChild(row);

      closeModal();
    }
  });
};
