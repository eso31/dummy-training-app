require 'rails_helper'
require_relative 'page_objects/workflows'

RSpec.describe 'Class Locations', type: :system do
  include PageObjects

  describe 'class location index' do
    it 'show me every class location as an admin' do

      #Create class locations
      create(:class_location, email: "firstclass@test.com")
      create(:class_location, email: "secondclass@test.com")

      form_page = visit_class_location_index

      admin = create(:admin)
      form_page.login(admin.email, admin.password)

      expect(form_page).to have_text('firstclass@test.com')
      expect(form_page).to have_text('secondclass@test.com')
    end
  end

  describe 'class location new' do
    
    it 'enables me to create class locations as an admin' do

      admin = create(:admin)

      form_page = as_admin_visit_class_locations_new

      form_page.login(admin.email, admin.password)

      form_page.fill_fields(
          'Name': 'Home',
          'Email': 'foo@bar.com',
          'Timezone': 'America/Mexico City'
      )
      show_page = form_page.click_create
      expect(show_page.alerts).to have_text('Class location was successfully created.')
    end
  end
end