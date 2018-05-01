require 'rails_helper'

RSpec.describe 'class_locations/edit', type: :view do
  before(:each) do
    @class_location = assign(:class_location, ClassLocation.create!(
      :name => 'MyString',
      :email => 'MyString',
      :timezone => 'MyString'
    ))
  end

  it 'renders the edit class_location form' do
    render

    assert_select 'form[action=?][method=?]', class_location_path(@class_location), 'post' do

      assert_select 'input[name=?]', 'class_location[name]'

      assert_select 'input[name=?]', 'class_location[email]'

      assert_select 'input[name=?]', 'class_location[timezone]'
    end
  end
end
