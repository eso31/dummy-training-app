(function ($) {
    "use strict";


    $(document).on("turbolinks:load", function () {

        // Here we start the script for the search box animation
        $("#advanced").click(showSearch);

        /**
         * Show the advanced search form
         * */
        function showSearch(event) {
            event.preventDefault();

            var $event_target = $(event.target);

            // Update the button who activated the Search box
            $event_target.toggleClass('search-active');
        }
    });
})(jQuery);