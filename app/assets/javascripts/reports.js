onLoad(function(){
  let showReceipt = byid('show_receipt');
  if (showReceipt)
    showReceipt.addEventListener('click', e => {
      e.preventDefault();
      showReceiptModal(e.target.dataset.receiptNumber);
    })
})