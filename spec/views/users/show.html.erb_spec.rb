require 'rails_helper'

RSpec.describe "users/show", type: :view do
  let(:first_user) { create(:user) }
  before(:each) do
    @user = assign(:training_request, first_user)

    sign_in_oauth :admin
  end

  it 'renders attributes in <p>' do
    render
    assert_select 'dt', :text => 'Name:', :count => 1
    assert_select 'dd', :text => @user.full_name, :count => 1

    assert_select 'dt', :text => 'Email:', :count => 1
    assert_select 'dd', :text => @user.email, :count => 1
  end
end