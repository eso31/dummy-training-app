require 'rails_helper'

RSpec.describe 'users/new', type: :view do
  before(:each) do
    @user = assign(:user, create(:user))
  end

  it 'renders new user form' do
    render

    assert_select 'form[action=?][method=?]', user_path(@user), 'post' do

      assert_select 'input[name=?]', 'user[first_name]'

      assert_select 'input[name=?]', 'user[last_name]'

      assert_select 'input[name=?]', 'user[email]'

    end
  end
end
