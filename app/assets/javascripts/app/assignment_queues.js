(function ($, App) {
  "use strict";

  $(document).on("turbolinks:load", function () {
    var userDataToOptions = function (value, i) {
      return {id: value.id, text: value.to_s}
    };

    var trainingRequestDataToOptions = function (value, i) {
      return {id: value.id, text: value.name}
    };

    if ($('.assignment_queues.new,.assignment_queues.edit').length) {
      Autocomplete.setup('user', Routes.users_path(), userDataToOptions);
      Autocomplete.setup('training_request', Routes.training_requests_path(), trainingRequestDataToOptions);
    }
  });
})(jQuery, Autocomplete);
