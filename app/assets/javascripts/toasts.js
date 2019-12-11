onLoad(function() {
  Rails.delegate(document, '.toast .btn-clear', 'click', function(e) {
    e.preventDefault();
    this.parentNode.remove();
  })
})

function showToast(html) {
  qs('footer').insertAdjacentHTML('beforeend', html);
}
