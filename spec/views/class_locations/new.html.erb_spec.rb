require 'rails_helper'

RSpec.describe 'class_locations/new', type: :view do
  before(:each) do
    assign(:class_location, ClassLocation.new(
      :name => 'MyString',
      :email => 'MyString',
      :timezone => 'MyString'
    ))
  end

  it 'renders new class_location form' do
    render

    assert_select 'form[action=?][method=?]', class_locations_path, 'post' do

      assert_select 'input[name=?]', 'class_location[name]'

      assert_select 'input[name=?]', 'class_location[email]'

      assert_select 'input[name=?]', 'class_location[timezone]'
    end
  end
end
