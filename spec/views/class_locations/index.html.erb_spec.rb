require 'rails_helper'

RSpec.describe 'class_locations/index', type: :view do
  before(:each) do
    assign(:class_locations, Kaminari.paginate_array([
      ClassLocation.create!(
        :name => 'Name',
        :email => 'Email',
        :timezone => 'Timezone'
      ),
      ClassLocation.create!(
        :name => 'Name',
        :email => 'Email2',
        :timezone => 'Timezone'
      )
    ]).page)

    sign_in_oauth :admin
  end

  it 'renders a list of class_locations' do
    render
    assert_select 'tr>td', :text => 'Name'.to_s, :count => 2
    assert_select 'tr>td', :text => 'Email'.to_s, :count => 1
    assert_select 'tr>td', :text => 'Email2'.to_s, :count => 1
    assert_select 'tr>td', :text => 'Timezone'.to_s, :count => 2
  end
end
