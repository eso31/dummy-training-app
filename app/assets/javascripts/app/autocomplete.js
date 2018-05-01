(function (exports) {
    "use strict";

    var Autocomplete = {}


    Autocomplete.setup = function (id, dataSourcePath, mapDataToOptions) {
        var selectId = "#" + id;
        $(selectId).select2({
            ajax: {
                url: dataSourcePath,
                dataType: "json",
                data: function (params) {
                    var url = window.location.pathname.split('/');
                    var query = {
                        q: params.term,
                        id: url[url.length-1]
                    }
                    return query;
                },
                processResults: function (data, page) {
                    return {
                        results: $.map(data, mapDataToOptions)
                    }
                }
            }
        });

        $(selectId).on('change', function () {
            var id = $(selectId).val();
            var siblings = $(selectId).siblings('input[type="hidden"].selected_id');
            if (siblings.length){
                if (!(id instanceof Array)) {
                    siblings.val(id);
                }
            }else{
                console.error('There is no hidden slibling text field to store the selected value of '+id + ' autocomplte')
            }

        })
    }


    exports.Autocomplete = Autocomplete
})(window);




