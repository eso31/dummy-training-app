(function ($, App) {
  "use strict";

  $(document).on("turbolinks:load", function () {
    var userDataToOptions = function (value, i) {
      return {id: value.id, text: value.to_s}
    };

    var enrollmentDataToOptions = function (value, i) {
      return {id: value.id, text: value.to_s}
    };

    if ($('.session_ratings.new,.session_ratings.edit').length) {
      Autocomplete.setup('user', Routes.users_path(), userDataToOptions);
      Autocomplete.setup('enrollment', Routes.enrollments_path, enrollmentDataToOptions);
    }
  });
})(jQuery, Autocomplete);
