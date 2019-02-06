document.addEventListener 'turbolinks:load', ->
  tabbeds = document.querySelectorAll('.tabbed')
  for tabbed in tabbeds
    bindTabs(tabbed)

window.bindTabs = (tabbed) ->
  tabsWrapper = tabbed.querySelector('.tabs')
  tabsContents = tabbed.querySelector('.tabs_contents')

  for tab in tabsWrapper.querySelectorAll('.tab')
    tab.addEventListener 'click', (e) ->
      e.preventDefault()
      if !this.classList.contains('current')
        tabRef = this.href.split('tab=')[1]

        window.history.replaceState({tab: tabRef}, tabRef, this.href)

        tabsWrapper.querySelector('.current').classList.remove('current')
        tabsContents.querySelector('.current').classList.remove('current')
        this.classList.add('current')

        tabsContents.querySelector('[data-tab-content="'+tabRef+'"]').classList.add('current')
