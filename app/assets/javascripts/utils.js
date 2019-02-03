function triggerEvent(element, event) {
  if ("createEvent" in document) {
      var evt = document.createEvent("HTMLEvents");
      evt.initEvent(event, false, true);
      element.dispatchEvent(evt);
  }
  else
      element.fireEvent("on"+event);
}
