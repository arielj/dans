document.addEventListener 'turbolinks:load', ->
  scrollables = document.querySelectorAll('.scrollable')
  for scrollable in scrollables
    if scrollable.children.length == 1 and scrollable.children[0].tagName == 'TABLE'
      table = scrollable.children[0]
      table.classList.add('fixed_header')
      scrollable.addEventListener 'scroll', (e) ->
        t = this.querySelector('.fixed_header')
        t.querySelector('thead').style.setProperty('--scroll', this.scrollTop+"px")
