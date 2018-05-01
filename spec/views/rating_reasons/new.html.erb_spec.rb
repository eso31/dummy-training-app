require 'rails_helper'

RSpec.describe "rating_reasons/new", type: :view do
  before(:each) do
    assign(:rating_reason, build(:rating_reason))
  end

  it "renders new rating_reason form" do
    render

    assert_select "form[action=?][method=?]", rating_reasons_path, "post" do

      assert_select "input[name=?]", "rating_reason[description]"

      assert_select "input[name=?]", "rating_reason[rating_type]"
    end
  end
end
