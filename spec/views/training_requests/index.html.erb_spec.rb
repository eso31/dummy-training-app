require 'rails_helper'

RSpec.describe 'training_requests/index', type: :view do
  let(:first_training_request) { create(:training_request) }
  let(:second_training_request) { create(:training_request) }
  before(:each) do
    assign(:training_requests, Kaminari.paginate_array([first_training_request, second_training_request]).page)
    sign_in_oauth
  end

  it 'renders a list of training_requests' do
    render
    assert_select 'tr.training_request', :count => 2
    assert_select "#training_request_#{first_training_request.id} td:nth-child(1) div:nth-child(1)", text: first_training_request.name, count: 1
    assert_select "#training_request_#{second_training_request.id} td:nth-child(1) div:nth-child(1)", text: second_training_request.name, count: 1

  end
end
