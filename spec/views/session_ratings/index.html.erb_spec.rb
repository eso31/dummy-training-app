RSpec.describe 'session_ratings/index', type: :view do

  before(:each) do
    assign(:session_ratings, Kaminari.paginate_array([create(:session_rating)]).page)
    sign_in_oauth
  end

  it 'renders a list of session_ratings' do
    render
    assert_select 'tr>th', text: 'Rating'.to_s, count: 1
  end
end
