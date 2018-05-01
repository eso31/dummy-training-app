require 'rails_helper'

describe AuditsController do

  login_user

  let(:valid_attributes) {
    build(:audit).attributes
  }

  let(:valid_session) { {} }

  describe 'GET #index' do

    render_views
    it 'returns a success response' do
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end

    it 'returns audits between certain dates' do
      series = create(:series)
      get :index, params: {audit: {created_at: Date.yesterday, end_date: Date.tomorrow}}, session: valid_session
      expect(response.body).to include(series.class.to_s)
    end

    it 'returns audits between certain dates' do
      create(:series)
      get :index, params: {audit: {end_date: Date.tomorrow}}, session: valid_session
      expect(response.body).to include('You need to add both, a start date and end date')
    end

  end

  describe 'GET #show' do
    it 'returns a success response' do
      audit = Audited::Audit.create! valid_attributes
      get :show, params: { id: audit.to_param }, session: valid_session
      expect(response).to be_success
    end
  end

end
