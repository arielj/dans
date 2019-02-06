document.addEventListener 'turbolinks:load', (ev) ->
  form = document.querySelector('.edit_person')
  if form
    age = form.querySelector('input[name*=age]')
    if age
      age.form.querySelector('input[name*=birthday]').addEventListener 'change', (ev) ->
        birthday = +new Date(this.value)
        y = ~~((Date.now() - birthday) / (31557600000))
        age.value = y
      triggerEvent(age, 'change')

    document.querySelector('.memberships select#membership').addEventListener 'change', (e) ->
      getScript({url: '/memberships/'+this.value})

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

      t = this
      path = this.dataset.autocompletepath
      val = this.value
      p = this.parentNode
      div = p.querySelector('#autocomplete_selector')
      if !div
        div = document.createElement('DIV')
        div.id = 'autocomplete_selector'
        p.appendChild(div)

      onSelectClick = (e) ->
        e.preventDefault()
        document.getElementById('new_family_member_id').value = this.data.value
        t.value = this.innerText
        div.remove()

      if val.length >= 3
        $request = getJSON({url: path, data: {q: val}, success: (response) ->
          autocompleteOptions.innerHTML = ''
          for person in response
            option = document.createElement 'option'
            option.value = person.label
            option.innerText = person.value
            autocompleteOptions.appendChild(option)

          if response.length == 0
            div.innerHTML = '<div class="option">No hay resultados</div>'
        })
      else
        div.innerHTML = ''
