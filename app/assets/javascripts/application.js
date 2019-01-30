// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require jquery
//= require cocoon
//= require bootstrap/dist/js/bootstrap.min
//= require trumbowyg/dist/trumbowyg.min
//= require tail.datetime/js/tail.datetime-full.min
//= require_tree .

document.addEventListener('turbolinks:load', function (ev) {
  initDatepicker('.datepicker');
})

function initDatepicker(selector) {
  tail.DateTime(selector, {
    locale: 'es',
    position: 'right',
    timeFormat: false,
  });
}
