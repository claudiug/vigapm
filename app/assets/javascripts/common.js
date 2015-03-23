$(document).ready(function() {
    $('.grouped-list li').wookmark({
        align: 'center',
        autoResize: true,
        container: $('.group-container'),
        offset: 27,
        verticalOffset: 27
    });

  if ($(document).height() <= $(window).height())
    $("footer").addClass("navbar-fixed-bottom");
});
