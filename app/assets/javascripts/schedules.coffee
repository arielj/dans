window.bindSchedulesCalendar = ->
  filter = byid('filter_schedules')
  if filter
    filter.addEventListener 'input', (e) ->
      val = this.value
      regexp = new RegExp(".*"+val+".*")
      schs = this.parentNode.qsa('.day label')
      for sch in schs
        cls = sch.classList
        if (val != '')
          if (regexp.test(sch.innerText))
            cls.remove('hidden')
          else
            cls.add('hidden')
        else
          cls.remove('hidden')

document.addEventListener 'turbolinks:load', ->
  bindSchedulesCalendar()
