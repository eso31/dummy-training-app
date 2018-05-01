# frozen_string_literal: true

module PageObjects
  include Capybara::DSL

  # Root
  def as_training_admin_visit_home
    visit home_index_path
    TrainingRequestIndex.new
  end

  def visit_login_view
    visit new_user_session_path
    SessionForm.new
  end

  def visit_settings_view
    visit users_settings_path
    UserPageObject::UserSettingsForm.new
  end

  def visit_password_view
    visit users_edit_password_path
    UserPageObject::UserEditPasswordForm.new
  end

  # Requests

  def visit_training_requests_index
    visit training_requests_path
    TrainingRequestIndex.new
  end

  def as_user_visit_training_request_new
    visit new_training_request_path
    TrainingRequestsForm.new
  end

  def as_an_admin_visit_training_request_show(training_request)
    visit training_request_path(training_request)
    TrainingRequestShow.new
  end

  # Sessions

  def as_admin_visit_class_locations_new
    visit new_class_location_path
    ClassLocationsForm.new
  end

  def as_user_visit_training_session_new
    visit new_training_session_path
    TrainingSessionForm.new
  end

  def as_admin_visit_course_new
    visit new_course_path
    CoursesForm.new
  end

  def visit_courses_index
    visit courses_path
    CoursesIndex.new
  end

  def as_an_admin_visit_edit_training_session(training_session)
    visit edit_training_session_path(training_session)
    TrainingSessionForm.new
  end

  def visit_training_session_show(training_session)
    visit training_session_path(training_session)
    TrainingSessionShow.new
  end

  def visit_class_location_index
    visit class_locations_path
    ClassLocationIndex.new
  end

  # Users

  def as_admin_visit_new_user
    visit new_user_path
    UserPageObject::UserForm.new
  end

  def visit_edit_user_page(user)
    visit edit_user_path(user)
    UserPageObject::UserSettingsForm.new
  end

  def as_admin_visit_users
    visit users_path
    UserPageObject::UserIndex.new
  end

end