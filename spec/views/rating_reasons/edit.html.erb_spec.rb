require 'rails_helper'

RSpec.describe "rating_reasons/edit", type: :view do
  before(:each) do
    @rating_reason = assign(:rating_reason, create(:rating_reason))
  end

  it "renders the edit rating_reason form" do
    render

    assert_select "form[action=?][method=?]", rating_reason_path(@rating_reason), "post" do

      assert_select "input[name=?]", "rating_reason[description]"

      assert_select "input[name=?]", "rating_reason[rating_type]"
    end
  end
end
