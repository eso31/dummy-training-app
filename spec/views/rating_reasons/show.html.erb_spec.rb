require 'rails_helper'

RSpec.describe "rating_reasons/show", type: :view do
  before(:each) do
    @rating_reason = assign(:rating_reason, create(:rating_reason, description:'Material', rating_type:'instructor'))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Material/)
    expect(rendered).to match(/instructor/)
  end
end
