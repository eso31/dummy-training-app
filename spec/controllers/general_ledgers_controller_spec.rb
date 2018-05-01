require 'rails_helper'

RSpec.describe GeneralLedgersController, type: :controller do
  before(:each) do
    sign_in_oauth
  end

  let(:valid_attributes) do
    build(:general_ledger).attributes
  end

  let(:invalid_attributes) do
    build(:general_ledger, description: nil).attributes
  end

  let(:valid_session) { {} }

  describe 'GET #index' do
    context 'with valid privileges' do
      it 'returns a success response' do
        sign_in_oauth :financial_admin
        get :index, params: {}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'GET #show' do
    context 'with valid privileges' do
      it 'returns a success response' do
        sign_in_oauth :financial_admin
        general_ledger = GeneralLedger.create! valid_attributes
        get :show, params: { id: general_ledger.to_param }, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'GET #new' do
    context 'with valid privileges' do
      it 'returns a success response' do
        sign_in_oauth :financial_admin
        get :new, params: {}, session: valid_session
        expect(response).to be_success
      end
    end

    context 'with invalid privileges' do
      it 'returns a not authorized error if user has not correct privileges' do
        expect do
          get :new, params: {}, session: valid_session
        end.to raise_error CanCan::AccessDenied
      end
    end
  end

  describe 'GET #edit' do
    context 'with valid privileges' do
      it 'returns a success response' do
        sign_in_oauth :financial_admin
        general_ledger = GeneralLedger.create! valid_attributes
        get :edit, params: { id: general_ledger.to_param }, session: valid_session
        expect(response).to be_success
      end
    end

    context 'with invalid privileges' do
      it 'returns a not authorized error if user has not correct privileges' do
        general_ledger = GeneralLedger.create! valid_attributes
        expect do
          get :edit, params: { id: general_ledger.to_param }, session: valid_session
        end.to raise_error CanCan::AccessDenied
      end
    end
  end

  describe 'POST #create' do
    context 'with valid privileges' do
      before(:each) do
        sign_in_oauth :financial_admin
      end

      context 'with valid params' do
        it 'creates a new GeneralLedger' do
          expect do
            post :create, params: { general_ledger: valid_attributes }, session: valid_session
          end.to change(GeneralLedger, :count).by(1)
        end

        it 'redirects to the created general_ledger' do
          post :create, params: { general_ledger: valid_attributes }, session: valid_session
          expect(response).to redirect_to(GeneralLedger.last)
        end
      end

      context 'with invalid params' do
        it "returns a success response (i.e. to display the 'new' template)" do
          post :create, params: { general_ledger: invalid_attributes }, session: valid_session
          expect(response).to be_success
        end
      end
    end

    context 'with invalid privileges' do
      it 'returns a not authorized error if user has not correct privileges' do
        expect do
          post :create, params: { general_ledger: valid_attributes }, session: valid_session
        end.to raise_error CanCan::AccessDenied
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid privileges' do
      before(:each) do
        sign_in_oauth :financial_admin
      end

      context 'with valid params' do
        let(:new_attributes) do
          build(:general_ledger, transaction_type: 'CREDIT').attributes
        end

        it 'updates the requested general_ledger' do
          general_ledger = GeneralLedger.create! valid_attributes
          put :update, params: { id: general_ledger.to_param, general_ledger: new_attributes }, session: valid_session
          general_ledger.reload
          expect(general_ledger.transaction_type).to eq('CREDIT')
        end

        it 'redirects to the general_ledger' do
          general_ledger = GeneralLedger.create! valid_attributes
          put :update, params: { id: general_ledger.to_param, general_ledger: valid_attributes }, session: valid_session
          expect(response).to redirect_to(general_ledger)
        end
      end

      context 'with invalid params' do
        it "returns a success response (i.e. to display the 'edit' template)" do
          general_ledger = GeneralLedger.create! valid_attributes
          put :update, params: { id: general_ledger.to_param, general_ledger: invalid_attributes }, session: valid_session
          expect(response).to be_success
        end
      end
    end

    context 'with invalid privileges' do
      it 'returns a not authorized error if user has not correct privileges' do
        general_ledger = GeneralLedger.create! valid_attributes
        expect do
          put :update, params: { id: general_ledger.to_param, general_ledger: valid_attributes }, session: valid_session
        end.to raise_error CanCan::AccessDenied
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'with valid privileges' do
      before(:each) do
        sign_in_oauth :financial_admin
      end

      it 'destroys the requested general_ledger' do
        general_ledger = GeneralLedger.create! valid_attributes
        expect do
          delete :destroy, params: { id: general_ledger.to_param }, session: valid_session
        end.to change(GeneralLedger, :count).by(-1)
      end

      it 'redirects to the general_ledgers list' do
        general_ledger = GeneralLedger.create! valid_attributes
        delete :destroy, params: { id: general_ledger.to_param }, session: valid_session
        expect(response).to redirect_to(general_ledgers_url)
      end
    end

    context 'with valid privileges' do
      it 'returns a not authorized error if user has not correct privileges' do
        general_ledger = GeneralLedger.create! valid_attributes
        expect do
          delete :destroy, params: { id: general_ledger.to_param }, session: valid_session
        end.to raise_error CanCan::AccessDenied
      end
    end
  end

  describe 'GET #link' do
    context 'with valid privileges' do
      before(:each) do
        sign_in_oauth :financial_admin
      end

      it 'returns a success response with a training session' do
        training_session = create(:training_session)
        get :show_link, params: { training_session_id: training_session.id },
                        session: valid_session
        expect(response).to be_success
      end

      it 'returns a success response with a training request' do
        training_request = create(:training_request)
        get :show_link, params: { training_request_id: training_request.id },
                        session: valid_session
        expect(response).to be_success
      end

      it 'returns a not found error without a training request or a training session' do
        user = create(:user)
        expect do
          get :show_link, params: { user_id: user.id },
                          session: valid_session
        end.to raise_error ActionController::UrlGenerationError
      end
    end

    context 'with invalid privileges' do
      it 'returns a not authorized error if user has not correct privileges' do
        training_session = create(:training_session)
        expect do
          get :show_link, params: { training_session_id: training_session.id },
                          session: valid_session
        end.to raise_error CanCan::AccessDenied
      end
    end
  end

  describe 'PUT #link' do

    context 'with valid privileges' do
      before(:each) do
        sign_in_oauth :financial_admin
      end

      it 'returns a success response with a training session' do
        general_ledger = GeneralLedger.create! valid_attributes
        training_session = create(:training_session)
        put :link, params: {
          id: general_ledger.to_param,
          general_ledger: { training_session_id: training_session.id }
        }

        expect(response).to be_redirect
      end

      it 'updates the training session of the general ledger' do
        general_ledger = GeneralLedger.create! valid_attributes
        training_session = create(:training_session)
        put :link, params: {
          id: general_ledger.to_param,
          general_ledger: { training_session_id: training_session.id }
        }

        general_ledger.reload
        expect(general_ledger.training_session_id).to eq(training_session.id)
      end

      it 'returns a success response with a training request' do
        general_ledger = GeneralLedger.create! valid_attributes
        training_request = create(:training_request)
        put :link, params: {
          id: general_ledger.to_param,
          general_ledger: { training_request_id: training_request.id }
        }

        expect(response).to be_redirect
      end

      it 'updates the training request of the general ledger' do
        general_ledger = GeneralLedger.create! valid_attributes
        training_request = create(:training_request)
        put :link, params: {
          id: general_ledger.to_param,
          general_ledger: { training_request_id: training_request.id }
        }

        general_ledger.reload
        expect(general_ledger.training_request_id).to eq(training_request.id)
      end

      it 'returns a not found error without a training request or a training session' do
        general_ledger = GeneralLedger.create! valid_attributes
        user = create(:user)
        expect do
          put :link, params: {
            id: general_ledger.to_param,
            general_ledger: { user_id: user.id }
          }
        end.to raise_error ActionController::RoutingError
      end

    end

    context 'with invalid privileges' do
      it 'returns a not authorized error if user has not correct privileges' do
        general_ledger = GeneralLedger.create! valid_attributes
        training_session = create(:training_session)
        expect do
          put :link, params: {
            id: general_ledger.to_param,
            general_ledger: { training_session_id: training_session.id }
          }
        end.to raise_error CanCan::AccessDenied
      end
    end
  end
end
