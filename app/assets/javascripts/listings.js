var ready;
ready = function() {
    var engine = new Bloodhound({
        datumTokenizer: function(d) {
            console.log(d);
            return Bloodhound.tokenizers.whitespace(d.title);
        },
        queryTokenizer: Bloodhound.tokenizers.whitespace,
        remote: {
            url: '/autocomplete?query=%QUERY',
            wildcard: '%QUERY'
        }
    });

    var promise = engine.initialize();

    promise
        .done(function() { console.log('success!'); })
        .fail(function() { console.log('err!'); });

    $('.typeahead').typeahead(null, {
        name: 'engine',
        displayKey: 'description',
        source: engine.ttAdapter()
    });
}

document.addEventListener("turbolinks:load", function() {
    ready();
})