var currentModal = false;

function closeModal() {
  if (window.currentModal) {
    window.currentModal.remove();
    window.currentModal = false;
  }
}

function createModal(title, bodyHtml, actions) {
  closeModal();

  const modal = qs('.modal-template .modal').cloneNode(true);
  modal.qs('.modal-title').innerText = title;
  modal.qs('.modal-body .content').innerHTML = bodyHtml;
  if (actions) modal.qs('.modal-footer').appendChild(actions);

  document.body.appendChild(modal);
  currentModal = modal;

  return modal;
};

function showLargeModal(title, bodyHtml, actions) {
  const modal = showModal(title, bodyHtml, actions);
  modal.classList.add('modal-xlg');
  return modal;
};

function showModal(title, bodyHtml, actions) {
  const modal = createModal(title, bodyHtml, actions);
  modal.classList.add('active');

  modal.qsa('.amount-input').forEach( el => bindAmountField(el) );

  return modal;
};

onLoad(function(e) {
  Rails.delegate(document, '.modal [aria-label="Close"]', 'click', function(e) {
    e.preventDefault();
    closeModal();
  });
});

function showReceiptModal(receiptNumber) {
  const viewer = document.createElement('object');
  viewer.type = 'application/pdf';
  viewer.data = `/receipts/${receiptNumber}.pdf`;
  viewer.width = '800px';
  viewer.style = 'margin: 0 auto; display: block';
  viewer.height = '500px';
  showLargeModal(`Recibo ${receiptNumber}`, viewer.outerHTML);
}