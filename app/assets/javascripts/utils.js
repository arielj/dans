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

function ajax(method, type, options) {
  options.type = method;
  options.dataType = type;

  xhrObject = false;
  options.beforeSend = function(xhr, options) {
    xhrObject = xhr;
    return true
  }

  Rails.ajax(options);

  return xhrObject;
}

function getScript(options) {
  return ajax('GET', 'script', options);
}

function getJSON(options) {
  return ajax('GET', 'json', options);
}

function postScript(options) {
  return ajax('POST', 'script', options);
}

function postJSON(options) {
  return ajax('POST', 'json', options);
}

function qs(selector, element) {
  if (!element) element = document;
  return element.querySelector(selector);
}

function qsa(selector, element) {
  if (!element) element = document;
  return element.querySelectorAll(selector);
}

function byid(id) {
  return document.getElementById(id);
}
