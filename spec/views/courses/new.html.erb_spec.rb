require 'rails_helper'

RSpec.describe "courses/new", type: :view do

  before(:each) do
    assign(:course, build(:course))
  end

  it "renders new course form" do
    render

    assert_select "form[action=?][method=?]", courses_path, "post" do

      assert_select "input[name=?]", "course[title]"

      assert_select "textarea[name=?]", "course[description]"

      assert_select "input[name=?]", "course[duration_in_minutes]"

      assert_select "input[name=?]", "course[min_group_size]"

      assert_select "input[name=?]", "course[max_group_size]"
    end
  end
end
