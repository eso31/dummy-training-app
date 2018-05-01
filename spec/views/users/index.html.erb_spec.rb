# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/index', type: :view do

  let(:first_user){ create(:user) }
  let(:second_user){ create(:user) }

  before(:each) do
    assign(:users, Kaminari.paginate_array([first_user, second_user]).page)
  end

  it 'renders a list of users' do
    render
    # Includes the header
    assert_select 'tr', :count => 3
    assert_select 'tr:nth-child(1) td:nth-child(1)', :text => first_user.full_name
    assert_select 'tr:nth-child(2) td:nth-child(1)', :text => second_user.full_name
  end
end
