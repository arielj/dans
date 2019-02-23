document.addEventListener 'turbolinks:load', (ev) ->
  form = qs('.edit_person')
  if form
    age = form.qs('input[name*=age]')
    if age
      form.qs('input[name*=birthday]').addEventListener 'change', (ev) ->
        birthday = +new Date(this.value)
        y = ~~((Date.now() - birthday) / (31557600000))
        age.value = y
      Rails.fire(age, 'change')

    qs('.memberships select#membership').addEventListener 'change', (e) ->
      getScript('/memberships/'+this.value)

window.initFamilyAutocomplete = ->
  request = false
  familyForm = byid('add_family_member')
  autocompleteOptions = familyForm.qs('#family_autocomplete')
  q = familyForm.qs('#q')
  if q
    q.addEventListener 'input', (e) ->
      if request
        request.abort()
        request = false

      t = this
      path = this.dataset.autocompletepath
      val = this.value
      p = this.parentNode
      div = qs('#autocomplete_selector', p)
      if !div
        div = document.createElement('DIV')
        div.id = 'autocomplete_selector'
        p.appendChild(div)

      onSelectClick = (e) ->
        e.preventDefault()
        byid('new_family_member_id').value = this.data.value
        t.value = this.innerText
        div.remove()

      if val.length >= 3
        request = getJSON(path, {data: {q: val}, success: (response) ->
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
