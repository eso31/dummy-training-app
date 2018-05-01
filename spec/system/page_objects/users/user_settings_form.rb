# frozen_string_literal: true
module PageObjects
  module UserPageObject
    class UserSettingsForm < BasePageObject
      def click_update
        click_button 'Update User'

        UserShow.new
      end

      def update_settings
        click_button 'Update User'

        UserShow.new
      end
    end
  end
end