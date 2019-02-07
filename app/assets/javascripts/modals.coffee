window.currentModal = false

window.closeModal = ->
  if window.currentModal
    window.currentModal.remove()
    window.currentModal = false
  backdrop = qs('.modal-backdrop')
  backdrop.remove() if backdrop

window.createModal = (title, bodyHtml, actions) ->
  closeModal()
  modal = $('<div class="modal" tabindex="-1" role="dialog" />')
  dialog = $('<div class="modal-dialog" role="document" />')
  content = $('<div class="modal-content" />')
  header = $('<div class="modal-header" />')
  h5 = $('<h5 class="modal-title">'+title+'</h5>')
  close = $('<button type="button" class="close" data-dismiss="modal" aria-label="Close">
               <span aria-hidden="true">&times;</span>
             </button>')
  close.on 'click', ->
    closeModal()

  body = document.createElement 'DIV'
  body.classList.add "modal-body"
  body.innerHTML = bodyHtml

  header.append(h5)
  header.append(close)
  content.append(header)
  content.append(body)

  if actions
    footer = $('<div class="modal-footer" />')
    footer.append(actions)
    body.appendChild(footer[0])

  dialog.append(content)
  modal.append(dialog)
  window.currentModal = modal

window.showLargeModal = (title, bodyHtml, actions) ->
  createModal(title, bodyHtml, actions)
  window.currentModal[0].querySelector('.modal-dialog').classList.add('modal-xlg')
  window.currentModal.modal('show')

window.showModal = (title, bodyHtml, actions) ->
  createModal(title, bodyHtml, actions)
  window.currentModal.modal('show')

document.addEventListener 'turbolinks:load', (e) ->
  document.addEventListener 'click', (e) ->
    if e.target.classList.contains('modal')
      closeModal()
