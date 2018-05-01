# frozen_string_literal: true

require 'rails_helper'
require_relative 'page_objects/workflows'

RSpec.describe 'Enrollments', type: :system do
  include PageObjects

  let(:training_session) do
    create(:training_session)
  end

  describe 'As a normal user' do
    it 'Enables me to enroll me in a session' do
      form_page = visit_training_session_show(training_session)

      user = create(:user)

      # Login as user
      form_page.login(user.email, user.password)

      # Click the roll button
      form_page.click_link 'Enroll'

      # Check for the user on the table
      expect(form_page.find('#enrollments')).to(
        have_content(Regexp.new(user.full_name))
      )
    end

    it 'Enables me to un-enroll me in a session' do

      user = create(:user)

      # Create the training session
      training_session = create(:training_session)

      # Create the enrollment
      enrollment = create(:enrollment) do |e|
        e.user_id = user.id
        e.training_session_id = training_session.id
      end

      # Enroll the user
      training_session.enrollments << enrollment

      form_page = visit_training_session_show(training_session)

      # Login as user
      form_page.login(user.email, user.password)

      form_page.accept_alert 'Are you sure?' do
        form_page.click_link 'Un-enroll'
      end

      # Check for the user on the table
      expect(form_page.find('#enrollments')).to_not(
        have_content(Regexp.new(user.full_name))
      )
    end
  end

  describe 'As instructor' do
    it "Rejects me to enroll myself in a session where I'm the instructor" do

      instructor = create(:user)

      # Create the training session and associate it to the instructor
      training_session = create(:training_session) do |ts|
        ts.instructor_ids = [instructor.id]
      end

      form_page = visit_training_session_show(training_session)

      # Login as the instructor
      form_page.login(instructor.email, instructor.password)

      # Expect the button of Enroll to not be present
      expect do
        form_page.click_link(/\AEnroll\z/)
      end.to raise_exception(Capybara::ElementNotFound)
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
        'training_session[start_date]': '02-02-2018 8:41'
      )

      form_page.select('workshop', :from => 'training_session[session_type]')

      # Set the values of the select2 combos via JS
      form_page.select_class_location class_location
      form_page.select_course course
      form_page.select_instructors instructor

      show_page = form_page.click_create
      expect(show_page.alerts).to have_content(/Training Session was successfully created/i)
    end
  end

end