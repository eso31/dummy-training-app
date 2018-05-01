require 'rails_helper'

describe 'TrainingRequests' do

  before(:each) { user_sign_in }

  describe 'GET /training_requests' do
    it 'works! (now write some real specs)' do
      get training_requests_path
      expect(response).to have_http_status(200)
    end
  end

end
