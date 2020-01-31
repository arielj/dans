onLoad(function() {
  Rails.delegate(document, '.toast .btn-clear', 'click', function(e) {
    e.preventDefault();
    this.parentNode.remove();
  })
})

function showToast(html) {
  qs('footer').insertAdjacentHTML('beforeend', html);
}

function showToastText(text) {
  let html = `<div class="toast toast-success">
    <button class="btn btn-clear float-right"></button>
    ${text}
  </div>`;
  showToast(html);
}