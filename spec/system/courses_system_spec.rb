require 'rails_helper'
require_relative 'page_objects/workflows'

RSpec.describe 'Courses', type: :system do
  include PageObjects

  let(:series) { create(:series) }
  let(:taught_by_user) { create(:user) }

  it "as an admin, enables me to create a course" do
    admin = create(:admin)

    form_page = as_admin_visit_course_new

    form_page.login(admin.email, admin.password)

    form_page.fill_fields(
        'Title': 'Title',
        'Description': 'Description',
        'Min group size': 5,
        'Duration in minutes': 30,
        'Max group size': 10
    )

    form_page.select_taught_by_user taught_by_user
    form_page.select_series series

    show_page = form_page.click_create
    expect(show_page).to have_content(series.to_s)

    index_page = visit_courses_index

    expect(index_page).to have_content('Title')
  end
end
