require 'rails_helper'

RSpec.describe 'audits/show.html.erb', type: :view do
  before(:each) do
    @audit = assign(:audit, create(:audit))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(@audit.auditable_type)
    expect(rendered).to match(@audit.action)
    expect(rendered).to match(@audit.audited_changes.to_s)
    expect(rendered).to match(@audit.created_at.to_s)
  end
end
