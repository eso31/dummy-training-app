require 'rails_helper'

RSpec.describe 'session_ratings/edit', type: :view do
  before(:each) do
    @session_rating = assign(:session_rating, create(:session_rating))
  end

  it 'renders the edit session_rating form' do
    render

    assert_select 'form[action=?][method=?]', session_rating_path(@session_rating), 'post' do

      assert_select 'input[name=?]', 'session_rating[rating]'

      assert_select 'select[name=?]', 'session_rating[user_type]'

      assert_select 'textarea[name=?]', 'session_rating[comment]'
    end
  end
end
