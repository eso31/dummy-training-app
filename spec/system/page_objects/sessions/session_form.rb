module PageObjects
  class SessionForm < BasePageObject

    def click_login
      click_button 'Log in'
      Dashboard.new
    end
  end
end