module PageObjects
  module UserPageObject
    class UserEditPasswordForm < BasePageObject
      def click_change
        click_button 'Update User'
        UserShow.new
      end
    end
  end
end
