require 'rails_helper'

RSpec.describe 'training_sessions/index', type: :view do



  before(:each) do
    training_sessions = Kaminari.paginate_array([
                                                    create(:training_session, title: 'course 1'),
                                                    create(:training_session, title: 'course 2')]).page

    assign(:training_sessions, training_sessions)

    sign_in_oauth :workshops_admin
  end

  it 'renders a list of training_sessions' do
    render
    assert_select 'tr>td div:nth-child(1)', text: 'course 1', count: 1
    assert_select 'tr>td div:nth-child(1)', text: 'course 2', count: 1
  end
end
