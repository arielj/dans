document.addEventListener 'turbolinks:load', (ev) ->
  age = $('input[name*=age]')
  if age.length
    age.parents('form').find('input[name*=birthday]').on('change', (ev) ->
      birthday = +new Date($(this).val());
      y = ~~((Date.now() - birthday) / (31557600000));
      age.val(y)
    ).trigger('change')
