
//= require jquery
//= require jquery_ujs
//= require twitter/typeahead.min
//= require bootstrap-sprockets
//=require jquery.pjax
//= require bootstrap-wysihtml5
//= require medium-editor
//= require jquery.scrollTo-1.4.3.1-min
//= require modernizr.custom
//= require page-transitions
//= require easing.min
//= require jquery.svg.js
//= require jquery.svganim
//= require jquery.parallax.min
//= require startup-kit
//= require holder

//= require_tree .

$(function() {
    $(document).pjax('a:not([data-remote]):not([data-behavior]):not([data-skip-pjax])', '[data-pjax-container]')
});
