onLoad(function() {
  qsa('.tabbed').forEach( tabbed => bindTabs(tabbed) );
});

function bindTabs(tabbed) {
  const tabsWrapper = tabbed.qs('.tabs');
  const tabsContents = tabbed.qs('.tabs_contents');
  tabsWrapper.qsa('.tab').forEach( tab => {
    tab.addEventListener('click', function(e) {
      e.preventDefault();
      if (!this.classList.contains('current')) {
        const tabRef = this.href.split('tab=')[1];
        window.history.replaceState({tab: tabRef}, tabRef, this.href);

        tabsWrapper.qs('.current').classList.remove('current');
        tabsContents.qs('.current').classList.remove('current');
        this.classList.add('current');
        tabsContents.qs('[data-tab-content="' + tabRef + '"]').classList.add('current');
      }
    })
  })
}
