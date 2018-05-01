require 'rails_helper'

RSpec.describe "session_ratings/new", type: :view do
  before(:each) do
    assign(:session_rating, build(:session_rating))
  end

  it "renders new session_rating form" do
    render

    assert_select "form[action=?][method=?]", session_ratings_path, "post" do

      assert_select "input[name=?]", "session_rating[rating]"

      assert_select "select[name=?]", "session_rating[user_type]"

      assert_select "textarea[name=?]", "session_rating[comment]"
    end
  end
end
