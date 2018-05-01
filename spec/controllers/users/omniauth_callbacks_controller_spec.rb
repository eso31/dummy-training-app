# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController, type: :controller do

  before do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = build(:auth_hash)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    @request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
  end

  describe 'GET #google_oauth2' do
    it 'returns a success response' do
      get :google_oauth2, params: {}
      expect(response).to be_redirect
    end
  end

end
