(function ($, App) {
  "use strict";

  $(document).on("turbolinks:load", function () {
    var userDataToOptions = function (value, i) {
      return {id: value.id, text: value.to_s}
    };

    var seriesDataToOptions = function (value, i) {
      return {id: value.id, text: value.to_s}
    };

    if ($('.courses.new,.courses.edit').length) {
      Autocomplete.setup('taught_by_user', Routes.users_path(), userDataToOptions);
      Autocomplete.setup('series', Routes.series_index_path(), seriesDataToOptions);
    }
  });
})(jQuery, Autocomplete);
