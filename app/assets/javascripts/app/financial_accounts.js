(function ($, App) {
  "use strict";

  $(document).on("turbolinks:load", function () {
    var fincncialAcccountDataToOptions = function (value, i) {
      return {id: value.id, text: value.name}
    };

    if ($('.financial_accounts.new,.financial_accounts.edit').length) {
      Autocomplete.setup('parent_account', Routes.financial_accounts_path(), fincncialAcccountDataToOptions);
    }
  });
})(jQuery, Autocomplete);
