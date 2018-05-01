(function ($, App) {
  "use strict";

  $(document).on("turbolinks:load", function () {
    var mapDataToOptions = function (value, i) {
      return {id: value.id, text: value.to_s}
    };

    var userDataToOptions = function (value, i) {
      return {id: value.id, text: value.to_s}
    };

    if ($('.audits.index').length) {
      Autocomplete.setup('auditable_type', Routes.audit_options_path('auditable_type'), mapDataToOptions);
      Autocomplete.setup('user', Routes.audit_users_list_path(), userDataToOptions);
      Autocomplete.setup('action', Routes.audit_options_path('action'), mapDataToOptions);
    }
  });
})(jQuery, Autocomplete);
