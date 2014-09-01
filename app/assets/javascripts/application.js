
//= require jquery
//= require jquery_ujs
//= require twitter/typeahead.min
//= require bootstrap-sprockets
//=require jquery.pjax
//= require bootstrap-wysihtml5
//= require medium-editor

//= require_tree .

$(function() {
    $(document).pjax('a:not([data-remote]):not([data-behavior]):not([data-skip-pjax])', '[data-pjax-container]')
});
