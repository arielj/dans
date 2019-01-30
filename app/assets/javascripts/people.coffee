document.addEventListener 'turbolinks:load', (ev) ->
  form = document.querySelector('edit_person')
  if form
    age = form.querySelector('input[name*=age]')
    if age
      $(age).parents('form').find('input[name*=birthday]').on('change', (ev) ->
        birthday = +new Date($(this).val())
        y = ~~((Date.now() - birthday) / (31557600000))
        age.val(y)
      ).trigger('change')

    form.querySelector('.memberships select#membership').addEventListener 'change', (e) ->
      $.getScript '/memberships/'+this.value

window.initFamilyAutocomplete = ->
  $request = false
  familyForm = document.getElementById('add_family_member')
  autocompleteOptions = familyForm.querySelector('#family_autocomplete')
  q = familyForm.querySelector('#q')
  if q
    q.addEventListener 'keyup', (e) ->
      if $request
        $request.abort()
        $request = false

      $t = this
      path = this.dataset.autocompletepath
      val = this.value
      $p = this.parentNode
      $div = $p.querySelector('#autocomplete_selector')
      if !$div
        $div = document.createElement('DIV')
        $div.id = 'autocomplete_selector'
        $p.appendChild($div)

      onSelectClick = (e) ->
        e.preventDefault()
        document.getElementById('new_family_member_id').value = this.data.value
        $t.value = this.innerText
        $div.remove()

      if val.length >= 3
        $request = $.getJSON path, {q: val}, (response) ->
          autocompleteOptions.innerHTML = ''
          for person in response
            option = document.createElement 'option'
            option.value = person.label
            option.innerText = person.value
            autocompleteOptions.appendChild(option)

          if response.length == 0
            $div.innerHTML = '<div class="option">No hay resultados</div>'
      else
        $div.innerHTML = ''

    q.addEventListener 'focus', (e) ->
      $(this).siblings('#autocomplete_selector').show()

    q.addEventListener 'blur', (e) ->
      $(this).siblings('#autocomplete_selector').hide('fast')
