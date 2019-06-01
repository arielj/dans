function bindAddPriceModal(form) {
  const hoursField = form.qs('input.hours');
  const valueField = form.qs('input.value');
  const add = form.qs('button');
  add.addEventListener('click', function(e) {
    e.preventDefault();
    const hours = parseFloat(hoursField.value);
    const fee = parseFloat(valueField.value);
    if (hours < 1 || isNaN(hours)) {
      return alert('La cantidad de horas es inválida');
    } else if (fee < 1 || isNaN(fee)) {
      return alert('El precio es inválido');
    } else if (byid('fee_' + hours)) {
      return alert('Ya hay un precio para esa cantidad de horas');
    } else {
      const row = document.createElement('TR');
      const col1 = document.createElement('TD');
      const col2 = document.createElement('TD');
      const input = document.createElement('INPUT');
      input.type = 'number';
      input.name = 'key[hour_fees][' + hours + ']';
      input.id = 'fee_' + hours;
      input.value = fee;
      col1.innerHTML = hours;
      col2.appendChild(input);
      row.appendChild(col1);
      row.appendChild(col2);
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
