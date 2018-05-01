# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'courses/show', type: :view do
  before(:each) do
    @course = assign(:course, create(:course))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/Duration/)
    expect(rendered).to match(/Min\. group/)
    expect(rendered).to match(/Max\. group/)
    expect(rendered).to match(/By/)
    expect(rendered).to match(/Series/)
  end
end
