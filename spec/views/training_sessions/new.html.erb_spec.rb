require 'rails_helper'

RSpec.describe "training_sessions/new", type: :view do
  before(:each) do
    assign(:training_session, build(:training_session))
  end

  it "renders new training_session form" do
    render

    assert_select 'form[action=?][method=?]', training_sessions_path, "post" do

      assert_select 'input[name=?]', 'training_session[title]'

      assert_select "textarea[name=?]", 'training_session[description]'

      assert_select "input[name=?]", "training_session[min_group_size]"

      assert_select "input[name=?]", "training_session[max_group_size]"

      assert_select "input[name=?]", "training_session[url]"

      assert_select "input[name=?]", "training_session[duration_in_minutes]"

      assert_select "input[name=?]", "training_session[compensation]"

      assert_select "input[name=?]", "training_session[compensation_delivered]"

      assert_select "select[name=?]", "training_session[session_type]"

      assert_select "input[name=?]", "training_session[course_id]"

      assert_select "input[name=?]", "training_session[class_location_id]"
    end
  end
end
