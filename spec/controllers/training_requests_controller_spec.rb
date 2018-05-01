require 'rails_helper'

describe TrainingRequestsController do

  before(:each) do
    sign_in_oauth
  end

  let(:valid_attributes) {
    build(:training_request).attributes
  }

  let(:invalid_attributes) {
    build(:training_request, :invalid).attributes
  }

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'returns a success response' do
      training_request = TrainingRequest.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      training_request = TrainingRequest.create! valid_attributes
      get :show, params: {id: training_request.to_param}, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      sign_in_oauth :admin
      training_request = TrainingRequest.create! valid_attributes
      get :edit, params: {id: training_request.to_param}, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'POST #create' do

    context 'as an admin user' do

      before(:each) do
        sign_in_oauth :admin
      end

      it 'create the training request with the selected admin' do
        create(:training_admin)
        actual = create(:training_admin)
        AssignmentQueue.assignment_round
        tr_params = valid_attributes.merge('assigned_to_user_id' => actual.id)
        post :create, params: { training_request: tr_params }
        expect(TrainingRequest.first.assigned_to_user_id).to eq(actual.id)
      end
    end

    context 'as a normal user' do



      it 'create the training request with the next admin in queue' do
        first = create(:training_admin)
        actual = create(:training_admin)
        AssignmentQueue.assignment_round
        post :create, params: { training_request: valid_attributes.merge('assigned_to_user_id' => actual.id) }
        expect(TrainingRequest.first.assigned_to_user_id).to eq(first.id)
      end

      it 'update the status of the assignment queue after the training admin is assigned' do
        post :create, params: { training_request: valid_attributes }
        expect(AssignmentQueue.queue).to be_empty
      end

    end
  end

  describe 'PUT #update' do

    before (:each) do
      sign_in_oauth :admin
    end

    context 'with valid params' do
      let(:new_attributes) {
         build(:training_request, name: 'Name Changed', status: 'approved').attributes
      }

      it 'updates the requested training_request' do
        training_request = TrainingRequest.create! valid_attributes
        put :update, params: {id: training_request.to_param, training_request: new_attributes}, session: valid_session
        training_request.reload
        expect(training_request.name).to eq 'Name Changed'
        expect(training_request.approved?).to be_truthy

      end

      it 'redirects to the training_request' do
        training_request = TrainingRequest.create! valid_attributes
        put :update, params: {id: training_request.to_param, training_request: valid_attributes}, session: valid_session
        expect(response).to redirect_to(training_request)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        training_request = TrainingRequest.create! valid_attributes
        put :update, params: {id: training_request.to_param, training_request: invalid_attributes}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'DELETE #destroy' do

    before (:each) do
      sign_in_oauth :admin
    end

    it 'destroys the requested training_request' do
      training_request = TrainingRequest.create! valid_attributes
      expect {
        delete :destroy, params: {id: training_request.to_param}, session: valid_session
      }.to change(TrainingRequest, :count).by(-1)
    end

    it 'redirects to the training_requests list' do
      training_request = TrainingRequest.create! valid_attributes
      delete :destroy, params: {id: training_request.to_param}, session: valid_session
      expect(response).to redirect_to(training_requests_url)
    end
  end

end
