# frozen_string_literal: true

require 'rails_helper'
require_relative 'page_objects/workflows'

RSpec.describe 'Training Sessions', type: :system do
  include PageObjects

  describe 'As a normal user' do

    it 'shows me correctly a training session' do

      training_session = create(:training_session)

      show_page = visit_training_session_show(training_session)

      user = create(:user)
      show_page.login(user.email, user.password)

      expect(show_page).to have_content(training_session.title)
    end

    it 'allows me to enroll to a training session' do

      training_session = create(:training_session)

      show_page = visit_training_session_show(training_session)

      user = create(:user)
      show_page.login(user.email, user.password)

      show_page = show_page.click_enroll

      expect(show_page).to have_content(user.full_name)
    end


    it 'allows me to rate a training session' do

      training_session = create(:training_session)
      user = create(:user)
      enrollment = create(:enrollment, user: user, training_session: training_session, attended: true)

      show_page = visit_training_session_show(training_session)

      show_page.login(user.email, user.password)

      modal_rate = show_page.rate(3)

      modal_rate.fill_in('session_rating[rating]', with: 2)
      modal_rate.fill_in('session_rating[comment]', with: 'New Comment')

      show_page = modal_rate.create

      rate = within("#rate_2") { find(:css, 'i') }

      expect(rate[:class].include?("fa fa-star")).to be_truthy
    end
  end

  describe 'As a workshop admin' do

    let(:instructor) { create(:user) }
    let(:course) { create(:course) }
    let(:class_location) { create(:class_location) }

    it 'enables me to create a training session' do

      form_page = as_user_visit_training_session_new

      # Login as a training admin
      workshops_admin = create(:workshops_admin)
      form_page.login(workshops_admin.email, workshops_admin.password)

      form_page.fill_fields(
        'Title': Faker::Lorem.word,
        'Description': Faker::Lorem,
        'Min group size': 5,
        'Max group size': 10,
        'Duration in minutes': '30',
        'Compensation': 500,
        'training_session[start_date]': '02-02-2018 8:41rails '
      )

      form_page.select('workshop', :from => 'training_session[session_type]')

      # Set the values of the select2 combos via JS
      form_page.select_class_location class_location
      form_page.select_course course
      form_page.select_instructors instructor

      show_page = form_page.click_create
      expect(show_page.alerts).to have_content(/Training Session was successfully created/i)
    end

    it 'enables me to edit a training session' do

      training_session = create(:training_session)

      form_page = as_an_admin_visit_edit_training_session(training_session)

      # Login as a training admin
      workshops_admin = create(:workshops_admin)
      form_page.login(workshops_admin.email, workshops_admin.password)

      expect(form_page).to have_content(training_session.title)

      form_page.fill_fields(
          'Title': "New title",
          'Description': "Description",
          'Min group size': 5
      )

      # Set the values of the select2 combos via JS
      form_page.select_class_location class_location
      form_page.select_course course
      form_page.select_instructors instructor

      show_page = form_page.click_update
      expect(show_page.alerts).to have_content(/Training Session was successfully updated/i)
    end
  end
end
