require 'rails_helper'

RSpec.describe 'training_requests/show', type: :view do
  let(:first_training_request) { create(:training_request, name:'Bordado 101', requesters: [
      create(:requester, status: 'approved'),
      create(:requester, status: 'not_approved')
  ]) }
  before(:each) do
    @training_request = assign(:training_request, first_training_request)
    @requester = assign(:requester, build(:requester))
    @training_request_poll = assign(:training_request_poll, build(:training_request_poll))
    @general_ledger = assign(:general_ledger, build(:general_ledger))
  end

  it 'renders attributes in <p>' do
    allow(view).to receive(:current_user).and_return(create(:user))
    render
    assert_select '.card-header h4', :text => first_training_request.name , :count => 1
    assert_select 'tr.requester:nth-child(1)>td:nth-child(3)', :text => 'approved', :count => 1
    assert_select 'tr.requester:nth-child(2)>td:nth-child(3)', :text => 'not_approved', :count => 1
  end
end

