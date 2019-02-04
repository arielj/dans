document.addEventListener 'turbolinks:load', ->
  scrollables = document.querySelectorAll('.scrollable_table')
  for scrollable in scrollables
    table = scrollable.children[0]
    firstTrTds = table.querySelectorAll('tbody tr:first-child td')
    if firstTrTds.length
      scrollableTable = document.createElement 'DIV'
      scrollableTable.classList.add('table_wrapper')
      scrollableTable.appendChild(table)
      scrollable.appendChild(scrollableTable)
      scrollableTable.style.height = scrollable.clientHeight+'px'

      auxTABLE = document.createElement 'TABLE'
      auxTABLE.classList.add('fixed_header')
      scrollable.appendChild(auxTABLE)

      auxTHEAD = document.createElement 'THEAD'
      auxTABLE.appendChild(auxTHEAD)

      auxTR = document.createElement 'TR'
      auxTHEAD.appendChild(auxTR)

      ths = table.querySelectorAll('th')
      for th, i in ths#(i = 0; i < ths.length; i++)
        auxTH = th.cloneNode(true)
        auxTH.style.setProperty('width', th.clientWidth+"px")
        auxTR.appendChild(auxTH)
