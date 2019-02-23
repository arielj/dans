document.addEventListener 'turbolinks:load', ->
  tabbeds = qsa('.tabbed')
  for tabbed in tabbeds
    bindTabs(tabbed)

window.bindTabs = (tabbed) ->
  tabsWrapper = tabbed.qs('.tabs')
  tabsContents = tabbed.qs('.tabs_contents')

  for tab in tabsWrapper.qsa('.tab')
    tab.addEventListener 'click', (e) ->
      e.preventDefault()
      if !this.classList.contains('current')
        tabRef = this.href.split('tab=')[1]

        window.history.replaceState({tab: tabRef}, tabRef, this.href)

        tabsWrapper.qs('.current').classList.remove('current')
        tabsContents.qs('.current').classList.remove('current')
        this.classList.add('current')

        tabsContents.qs('[data-tab-content="'+tabRef+'"]').classList.add('current')
