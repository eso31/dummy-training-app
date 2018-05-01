(function ($, App) {
    "use strict";

    $(document).on("turbolinks:load", function () {
        $('#showVoteModal').on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget); // Button that triggered the modal
            var vote = button.data('training-request-poll-vote');// Extract info from data-* attributes
            var comment = button.data('training-request-poll-comment');
            // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
            // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
            var modal = $(this);
            $('#training_request_poll_vote_value').text(vote);
            $('#training_request_poll_comment_value').text(comment);
        });

        $('#editVoteModal').on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget); // Button that triggered the modal
            var poll = button.data('poll');// Extract info from data-* attributes
            var path = button.data('path');

            var modal = $(this);
            var form = modal.find('form');

            // Set the values of the form to make an edit form
            form.append('<input type="hidden" name="_method" value="patch">');

            // Then add the values to the form
            form.find('#training_request_poll_vote option[value='+ poll.vote +']')
                .attr('selected', 'selected');

            form.find('#training_request_poll_comment').val(poll.comment);

            // Update the UI values
            form.find('training_request_poll_vote').change();

            // And change the path route
            form.attr('action', path);
        });
    });
})(jQuery, Autocomplete);