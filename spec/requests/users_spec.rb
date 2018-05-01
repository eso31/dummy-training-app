require 'rails_helper'

describe 'Users' do

  before(:each) { user_sign_in }

  describe 'GET /users' do
    it 'works! (now write some real specs)' do
      sign_in_oauth :admin
      get users_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'as admin' do
    before(:each) do
      sign_in_oauth :admin
    end

    describe 'GET /users/available_admins' do
      it 'raise routing error with html format' do
        expect do
          get '/admin/users/available_admins'
        end.to raise_error ActionController::UnknownFormat
      end
    end

    describe 'GET /users/available_admins.json' do
      it 'respond ok to json format' do
        headers = {
          'ACCEPT': 'application/json'
        }
        get '/admin/users/available_admins', headers: headers
        expect(response).to have_http_status(200)
      end
    end
  end
end