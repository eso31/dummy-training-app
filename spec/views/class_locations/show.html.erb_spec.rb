require 'rails_helper'

RSpec.describe 'class_locations/show', type: :view do
  before(:each) do
    @class_location = assign(:class_location, ClassLocation.create!(
      :name => 'Name',
      :email => 'Email',
      :timezone => 'Timezone'
    ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Timezone/)
  end
end
