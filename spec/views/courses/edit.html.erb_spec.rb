require 'rails_helper'

RSpec.describe "courses/edit", type: :view do

  before(:each) do
    @course = assign(:course, create(:course))
  end

  it "renders the edit course form" do
    render

    assert_select "form[action=?][method=?]", course_path(@course), "post" do

      assert_select "input[name=?]", "course[title]"

      assert_select "textarea[name=?]", "course[description]"

      assert_select "input[name=?]", "course[duration_in_minutes]"

      assert_select "input[name=?]", "course[min_group_size]"

      assert_select "input[name=?]", "course[max_group_size]"
    end
  end
end
