# frozen_string_literal: true
module PageObjects
  module UserPageObject

    # Class who represents the Page Object of the training session form
    class UserForm < BasePageObject
      def click_create
        click_button 'Create User'
        UserShow.new
      end
    end
  end
end
