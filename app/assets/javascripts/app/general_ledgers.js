(function ($, App) {
  "use strict";

  $(document).on("turbolinks:load", function () {
    var fincncialAcccountDataToOptions = function (value, i) {
      return {id: value.id, text: value.name}
    };

    var ledgerCategoryDataToOptions = function (value, i) {
      return {id: value.id, text: value.name}
    };

    var trainingRequestDataToOptions = function (value, i) {
      return {id: value.id, text: value.name}
    };

    var trainingSessionDataToOptions = function (value, i) {
      return {id: value.id, text: value.title}
    };

    if ($('.general_ledgers.new,.general_ledgers.edit').length) {
      Autocomplete.setup('financial_account', Routes.financial_accounts_path(), fincncialAcccountDataToOptions);
      Autocomplete.setup('ledger_category', Routes.ledger_categories_path(), ledgerCategoryDataToOptions);
      Autocomplete.setup('training_request', Routes.training_requests_path(), trainingRequestDataToOptions);
      Autocomplete.setup('training_session', Routes.training_sessions_path(), trainingSessionDataToOptions);
    }

    if ($('.training_sessions.show,.training_requests.show').length) {
      Autocomplete.setup('financial_account', Routes.financial_accounts_path(), fincncialAcccountDataToOptions);
      Autocomplete.setup('ledger_category', Routes.ledger_categories_path(), ledgerCategoryDataToOptions);
      Autocomplete.setup('training_request', Routes.training_requests_path(), trainingRequestDataToOptions);
      Autocomplete.setup('training_session', Routes.training_sessions_path(), trainingSessionDataToOptions);
    }
  });
})(jQuery, Autocomplete);
