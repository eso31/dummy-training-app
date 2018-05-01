require 'rails_helper'


describe SeriesController do

  before(:each) do
    sign_in_oauth
  end

  let(:valid_attributes) {
    build(:series).attributes
  }

  let(:invalid_attributes) {
    build(:series, :invalid).attributes
  }

  let(:valid_session) { {} }

  describe 'GET #index' do
    context 'with valid privileges' do
      it 'returns a success response' do
        sign_in_oauth :admin
        series = Series.create! valid_attributes
        get :index, params: {}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'GET #show' do
    context 'with valid privileges' do
      it 'returns a success response' do
        sign_in_oauth :admin
        series = Series.create! valid_attributes
        get :show, params: {id: series.to_param}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'GET #new' do
    context 'with valid privileges' do
      it 'returns a success response' do
        sign_in_oauth :admin
        get :new, params: {}, session: valid_session
        expect(response).to be_success
      end
    end

    context 'with invalid privileges' do
      it 'returns a not authorized error if user has not correct privileges' do
        expect { get :new, params: {}, session: valid_session
        }.to raise_error CanCan::AccessDenied
      end
    end
  end

  describe 'GET #edit' do
    context 'with valid privileges' do
      it 'returns a success response' do
        sign_in_oauth :admin
        series = Series.create! valid_attributes
        get :edit, params: {id: series.to_param}, session: valid_session
        expect(response).to be_success
      end
    end

    context 'with invalid privileges' do
      it 'returns a not authorized error if user has not correct privileges' do
        series = Series.create! valid_attributes
        expect { get :edit, params: {id: series.to_param}, session: valid_session
        }.to raise_error CanCan::AccessDenied
      end
    end
  end

  describe 'POST #create' do
    context 'with valid privileges' do

      before(:each) do
        sign_in_oauth :admin
      end

      context 'with valid params' do
        it 'creates a new Series' do
          expect {
            post :create, params: {series: valid_attributes}, session: valid_session
          }.to change(Series, :count).by(1)
        end

        it 'redirects to the created series' do
          post :create, params: {series: valid_attributes}, session: valid_session
          expect(response).to redirect_to(Series.last)
        end
      end

      context 'with invalid params' do
        it "returns a success response (i.e. to display the 'new' template)" do
          post :create, params: {series: invalid_attributes}, session: valid_session
          expect(response).to be_success
        end
      end
    end

    context 'with invalid privileges' do
      it 'returns a not authorized error if user has not correct privileges' do
        expect {
          post :create, params: {series: valid_attributes}, session: valid_session
        }.to raise_error CanCan::AccessDenied
      end
    end

  end

  describe 'PUT #update' do
    context 'with valid privileges' do

      before(:each) do
        sign_in_oauth :admin
      end

      context 'with valid params' do
        let(:new_attributes) {
          build(:series, name: 'Extreme Ownership' ).attributes
        }

        it 'updates the requested series' do
          series = Series.create! valid_attributes
          put :update, params: {id: series.to_param, series: new_attributes}, session: valid_session
          series.reload
          expect(series.name).to eq 'Extreme Ownership'
        end

        it 'redirects to the series' do
          series = Series.create! valid_attributes
          put :update, params: {id: series.to_param, series: valid_attributes}, session: valid_session
          expect(response).to redirect_to(series)
        end
      end

      context 'with invalid params' do
        it "returns a success response (i.e. to display the 'edit' template)" do
          series = Series.create! valid_attributes
          put :update, params: {id: series.to_param, series: invalid_attributes}, session: valid_session
          expect(response).to be_success
        end
      end
    end

    context 'with invalid privileges' do
      it 'returns a not authorized error if user has not correct privileges' do
        series = Series.create! valid_attributes
        expect { put :update, params: {id: series.to_param, series: valid_attributes}, session: valid_session
        }.to raise_error CanCan::AccessDenied
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'with valid pribileges' do

      before(:each) do
        sign_in_oauth :admin
      end

      it 'destroys the requested series' do
        series = Series.create! valid_attributes
        expect {
          delete :destroy, params: {id: series.to_param}, session: valid_session
        }.to change(Series, :count).by(-1)
      end

      it 'redirects to the series list' do
        series = Series.create! valid_attributes
        delete :destroy, params: {id: series.to_param}, session: valid_session
        expect(response).to redirect_to(series_index_url)
      end
    end

    context 'with invalid privileges' do
      it 'returns a not authorized error if user has not correct privileges' do
        series = Series.create! valid_attributes
        expect {
          delete :destroy, params: {id: series.to_param}, session: valid_session
        }.to raise_error CanCan::AccessDenied
      end
    end
  end

end
