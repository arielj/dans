document.addEventListener 'turbolinks:load', ->
  Rails.delegate document, '.toast .btn-clear', 'click', (e) ->
    e.preventDefault()
    this.parentNode.remove()
