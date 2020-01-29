onLoad(function(){
  let showReceipt = byid('show_receipt');
  if (showReceipt)
    showReceipt.addEventListener('click', e => {
      e.preventDefault();
      showReceiptModal(e.target.dataset.receiptNumber);
    })
  
  let printPaymentsForm = byid('print_payments');
  if (printPaymentsForm)
    printPaymentsForm.addEventListener('ajax:before', function(e) {
      let selectedItems = qsa('[name="print[]"]:checked');
      let receipts = [];
      selectedItems.forEach( el => {
        if (el.dataset.receipt && receipts.indexOf(el.dataset.receipt) == -1)
          receipts.push(el.dataset.receipt);
      })

      if (receipts.length == 0) {
        e.preventDefault();
        alert('No se seleccionaron pagos para imprimir');
      } else if (receipts.length > 1) {
        r = confirm('Se seleccionaron pagos con distinto número de recibo. Se va a reemplazar por un número nuevo.')
        if (!r) e.preventDefault();
      }
    })
})