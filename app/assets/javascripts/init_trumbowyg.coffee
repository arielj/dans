document.addEventListener 'turbolinks:load', (ev) ->
  $('.trumbowyg').trumbowyg({
    btns: [
        ['undo', 'redo'],
        ['strong', 'em', 'del'],
        ['superscript', 'subscript'],
        ['link'],
        ['insertImage'],
        ['justifyLeft', 'justifyCenter', 'justifyRight', 'justifyFull'],
        ['unorderedList', 'orderedList'],
        ['horizontalRule'],
        ['removeformat'],
    ]
  })
