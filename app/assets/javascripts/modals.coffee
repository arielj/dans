window.current_modal = false

window.close_modal = ->
  if window.current_modal
    window.current_modal.modal('hide')
    window.current_modal = false

window.create_modal = (title, body_html, actions) ->
  close_modal()
  modal = $('<div class="modal" tabindex="-1" role="dialog" />')
  dialog = $('<div class="modal-dialog" role="document" />')
  content = $('<div class="modal-content" />')
  header = $('<div class="modal-header" />')
  h5 = $('<h5 class="modal-title">'+title+'</h5>')
  close = $('<button type="button" class="close" data-dismiss="modal" aria-label="Close">
               <span aria-hidden="true">&times;</span>
             </button>')

  body = $('<div class="modal-body" />')
  body.append(body_html)


  header.append(h5)
  header.append(close)
  content.append(header)
  content.append(body)

  if actions
    footer = $('<div class="modal-footer" />')
    footer.append(actions)
    body.append(footer)

  dialog.append(content)
  modal.append(dialog)
  window.current_modal = modal

window.show_large_modal = (title, body_html, actions) ->
  create_modal(title, body_html, actions)
  window.current_modal.find('.modal-dialog').addClass('modal-xlg')
  window.current_modal.modal('show')

window.show_modal = (title, body_html, actions) ->
  create_modal(title, body_html, actions)
  window.current_modal.modal('show')
