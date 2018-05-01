(function ($, App) {
    "use strict";

  $(document).on("turbolinks:load", function () {
    var userDataToOptions = function (user, i) {
        return {id: user.id, text: user.to_s}
    };

    if ($('.training_requests.new,.training_requests.edit').length) {
      Autocomplete.setup('assigned_to_user', Routes.training_admins_users_path(), userDataToOptions);
      Autocomplete.setup('requested_by_user', Routes.users_path(), userDataToOptions);
    }

    if ($('.training_requests.show').length) {
      Autocomplete.setup('user', Routes.users_path(), userDataToOptions);
    }

    // We search for the advanced search widget
    if ($('#training-request-search').length) {
      Autocomplete.setup('q_requested_by_user_id', Routes.users_path(), userDataToOptions);
      Autocomplete.setup('q_assigned_to_user_id', Routes.training_admins_users_path(), userDataToOptions);
    }

    // Update vote actions
    $('.vote-select').on('ajax:success', function (e) {
      // Update the status count based on the response
      var result = '';

      for(var status in e.detail[0]){
          result += "<li><p>" + status+ ": <span class=\"badge badge-secondary\">" + e.detail[0][status] + "</span></p></li>"
      }

      $('#votes-count').html(result)
    });
  });
})(jQuery, Autocomplete);
