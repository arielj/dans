function serializePair(name, value) {
  return [name, value].map(encodeURIComponent).join('=');
}

function serializeForm(form) {
  const enabled = form.elements.filter( node => !node.disabled );
  const pairs = enabled.map( node => serializePair(node.name, node.value) );
  return pairs.join('&');
}

function ajax(method, type, url, options) {
  if (!options) options = {}
  options.url = url
  options.type = method;
  options.dataType = type;

  let xhrObject = false;
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
