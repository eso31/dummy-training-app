require 'rails_helper'

describe 'ClassLocations' do
  describe 'GET /class_locations' do
    context 'when authenticated' do
      before(:each) { sign_in_oauth :admin }

      it 'fetches a successful response' do
        get class_locations_path
        expect(response).to have_http_status(200)
      end
    end

    context 'when unauthenticated' do
      it 'fetches a successful response' do
        get class_locations_path
        expect(response).to have_http_status(302)
      end
    end
  end
end
