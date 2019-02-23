function serializePair(name, value) {
  encoded = [name, value].map(encodeURIComponent);
  return encoded.join('=');
}

function serializeForm(form) {
  enabled = form.elements.filter(function(node) { return !node.disabled });
  pairs = enabled.map(function(node) { return serializePair(node.name, node.value) });
  return pairs.join('&');
}

function ajax(method, type, url, options) {
  if (!options) options = {}
  options.url = url
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

function getScript(url, options) {
  return ajax('GET', 'script', url, options);
}

function getJSON(url, options) {
  return ajax('GET', 'json', url, options);
}

function postScript(url, options) {
  return ajax('POST', 'script', url, options);
}

function postJSON(url, options) {
  return ajax('POST', 'json', url, options);
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

HTMLElement.prototype.qs = HTMLDocument.prototype.qs = function(selector){
  return this.querySelector(selector);
}

HTMLElement.prototype.qsa = HTMLDocument.prototype.qsa = function(selector){
  return this.querySelectorAll(selector);
}
