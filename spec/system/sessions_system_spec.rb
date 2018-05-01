require 'rails_helper'
require_relative 'page_objects/workflows'

RSpec.describe 'Sessions', type: :system do
  include PageObjects

  describe 'Log in view' do

    it 'enables me log in as an admin' do
      form_page = visit_login_view

      # Login as a training admin
      admin = create(:admin)

      form_page.fill_fields(
          'Email': admin.email,
          'Password': admin.password
      )

      dashboard_page = form_page.click_login
      expect(dashboard_page.alerts).to have_content(/Signed in successfully/i)

    end

    it 'Should fail to login with bad password' do
      form_page = visit_login_view

      # Login as user
      user = create(:user)

      form_page.fill_fields(
        'Email': user.email,
        'Password': Faker::Internet.password(8, 16)
      )

      dashboard_page = form_page.click_login
      expect(dashboard_page.alerts).to have_content(/Invalid Email or password/i)
    end
  end

end