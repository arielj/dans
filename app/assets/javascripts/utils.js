function triggerEvent(element, event) {
  if ("createEvent" in document) {
      var evt = document.createEvent("HTMLEvents");
      evt.initEvent(event, false, true);
      element.dispatchEvent(evt);
  }
  else
      element.fireEvent("on"+event);
}

function serializePair(name, value) {
  encoded = [name, value].map(encodeURIComponent);
  return encoded.join('=');
}

function serializeForm(form) {
  enabled = form.elements.filter(function(node) { return !node.disabled });
  pairs = enabled.map(function(node) { return serializePair(node.name, node.value) });
  return pairs.join('&');
}

function getScript(options) {
  options.type = 'GET'
  options.dataType = 'script'
  Rails.ajax(options)
}

function getJSON(options) {
  options.type = 'GET'
  options.dataType = 'json'
  Rails.ajax(options)
}

function postScript(options) {
  options.type = 'POST'
  options.dataType = 'script'
  Rails.ajax(options)
}

function postJSON(options) {
  options.type = 'POST'
  options.dataType = 'json'
  Rails.ajax(options)
}
