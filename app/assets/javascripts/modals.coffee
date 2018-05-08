window.current_modal = false

window.close_modal = ->
  if window.current_modal
    window.current_modal.modal('hide')
    window.current_modal = false

window.show_modal = (title, body_html, actions) ->
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

  footer = $('<div class="modal-footer" />')
  footer.append(actions)

  header.append(h5)
  header.append(close)
  content.append(header)
  content.append(body)
  content.append(footer)
  dialog.append(content)
  modal.append(dialog)

  window.current_modal = modal
  window.current_modal.modal('show')
