document.addEventListener 'turbolinks:load', (ev) ->
  age = $('input[name*=age]')
  if age.length
    age.parents('form').find('input[name*=birthday]').on('change', (ev) ->
      birthday = +new Date($(this).val())
      y = ~~((Date.now() - birthday) / (31557600000))
      age.val(y)
    ).trigger('change')

  $('.memberships select#membership').on 'change', (e) ->
    m_id = $(this).val()
    $.getScript '/memberships/'+m_id


window.init_family_autocomplete = ->
  $request = false
  $('#add_family_member #q').on('keyup', (e) ->
    if $request
      $request.abort()
      $request = false

    $t = $(this)
    path = $t.data('autocompletepath')
    val = $t.val()
    $p = $t.parent()
    $div = $p.find('#autocomplete_selector')
    if $div.length == 0
      $div = $('<div />').attr('id','autocomplete_selector')
      $p.append($div)

    onSelectClick = (e) ->
      e.preventDefault()
      $('#new_family_member_id').val($(this).data('value'))
      $t.val($(this).text())
      $div.remove()

    if val.length >= 3
      $request = $.getJSON path, {q: val}, (response) ->
        options = []
        for person in response
          options.push($('<div />').addClass('option').html(person.label).data('value', person.value).on('click', onSelectClick))
          $div.html(options)

        if response.length == 0
          $div.html($('<div class="option">No hay resultados</div>'))
    else
      $div.html('')

  ).on('focus', (e) ->
    $(this).siblings('#autocomplete_selector').show()
  ).on('blur', (e) ->
    $(this).siblings('#autocomplete_selector').hide('fast')
  )
