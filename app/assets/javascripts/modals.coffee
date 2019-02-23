window.currentModal = false

window.closeModal = ->
  if window.currentModal
    window.currentModal.remove()
    window.currentModal = false

window.createModal = (title, bodyHtml, actions) ->
  closeModal()

  modal = qs('.modal-template .modal').cloneNode(true)
  modal.qs('.modal-title').innerText = title
  modal.qs('.modal-body .content').innerHTML = bodyHtml

  if actions
    modal.qs('.modal-footer').appendChild(footer[0])

  document.body.appendChild(modal)
  window.currentModal = modal

window.showLargeModal = (title, bodyHtml, actions) ->
  showModal(title, bodyHtml, actions)
  window.currentModal.classList.add('modal-xlg')

window.showModal = (title, bodyHtml, actions) ->
  createModal(title, bodyHtml, actions)
  window.currentModal.classList.add('active')

document.addEventListener 'turbolinks:load', (e) ->
  Rails.delegate document, '.modal [aria-label="Close"]', 'click', (e) ->
    e.preventDefault()
    closeModal()
