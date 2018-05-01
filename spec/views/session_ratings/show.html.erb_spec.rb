require 'rails_helper'

RSpec.describe "session_ratings/show", type: :view do
  before(:each) do
    @session_rating = assign(:session_rating, create(:session_rating))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(@session_rating.user.full_name.to_s)
  end
end
