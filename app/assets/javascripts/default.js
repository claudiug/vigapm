$(function() {
    var posts = new Bloodhound({
        datumTokenizer: Bloodhound.tokenizers.obj.whitespace('name'),
        queryTokenizer: Bloodhound.tokenizers.whitespace,
        limit: 10,
        remote: '/autocomplete?query=%QUERY'
    });

    // initialize the bloodhound suggestion engine
    posts.initialize();

    $('input.typeahead').typeahead(
        {
            hint: true,
            highlight: true,
            limit: 10
        },
        {
            name: 'posts',
            displayKey: 'name',
            source: posts.ttAdapter()
        }
    );

    $('.editable').each(function(i, elem) {
        $(elem).wysihtml5();
    });

});

