document.addEventListener 'turbolinks:load', ->
  tabbeds = qsa('.tabbed')
  for tabbed in tabbeds
    bindTabs(tabbed)

window.bindTabs = (tabbed) ->
  tabsWrapper = qs('.tabs', tabbed)
  tabsContents = qs('.tabs_contents', tabbed)

  for tab in qsa('.tab', tabsWrapper)
    tab.addEventListener 'click', (e) ->
      e.preventDefault()
      if !this.classList.contains('current')
        tabRef = this.href.split('tab=')[1]

        window.history.replaceState({tab: tabRef}, tabRef, this.href)

        qs('.current', tabsWrapper).classList.remove('current')
        qs('.current', tabsContents).classList.remove('current')
        this.classList.add('current')

        qs('[data-tab-content="'+tabRef+'"]', tabsContents).classList.add('current')
