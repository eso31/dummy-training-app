require 'rails_helper'


describe TrainingRequestPollsController do

  let(:training_request) { create(:training_request) }

  before(:each) do
    sign_in_oauth :training_admin
  end

  let(:valid_attributes) {
    build(:training_request_poll).attributes
  }

  let(:invalid_attributes) {
    build(:training_request_poll, :invalid).attributes
  }

  let(:valid_session) { {} }

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: { training_request_id: training_request.id, }, session: valid_session
      expect(response).to be_success
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      training_request_poll = TrainingRequestPoll.create! valid_attributes
      get :edit, params: { training_request_id: training_request.id, id: training_request_poll.to_param}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new TrainingRequestPoll" do
        expect {
          post :create, params: { training_request_id: training_request.id, training_request_poll: valid_attributes}, session: valid_session
        }.to change(TrainingRequestPoll, :count).by(1)
      end

      it "redirects to the created training_request_poll" do
        post :create, params: { training_request_id: training_request.id, training_request_poll: valid_attributes}, session: valid_session
        expect(response).to redirect_to(training_request)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { training_request_id: training_request.id, training_request_poll: invalid_attributes}, session: valid_session
        expect(response).to redirect_to(training_request)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        build(:training_request_poll, vote:'abstained').attributes
      }

      it 'updates the requested training_request_poll' do
        training_request_poll = TrainingRequestPoll.create! valid_attributes
        expect(training_request_poll.vote).to eq('approved')

        put :update, params: { training_request_id: training_request.id, id: training_request_poll.to_param, training_request_poll: new_attributes}, session: valid_session
        training_request_poll.reload

        expect(training_request_poll.vote).to eq('abstained')
      end

      it 'redirects to the training_request_poll' do
        training_request_poll = TrainingRequestPoll.create! valid_attributes
        put :update, params: { training_request_id: training_request.id, id: training_request_poll.to_param, training_request_poll: valid_attributes}, session: valid_session
        expect(response).to redirect_to(training_request)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        training_request_poll = TrainingRequestPoll.create! valid_attributes
        put :update, params: { training_request_id: training_request.id, id: training_request_poll.to_param, training_request_poll: invalid_attributes}, session: valid_session
        expect(response).to redirect_to(training_request)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested training_request_poll' do
      training_request_poll = TrainingRequestPoll.create! valid_attributes
      expect {
        delete :destroy, params: { training_request_id: training_request.id, id: training_request_poll.to_param}, session: valid_session
      }.to change(TrainingRequestPoll, :count).by(-1)
    end

    it "redirects to the training_request_polls list" do
      training_request_poll = TrainingRequestPoll.create! valid_attributes
      delete :destroy, params: { training_request_id: training_request.id, id: training_request_poll.to_param}, session: valid_session
      expect(response).to redirect_to(training_request)
    end
  end

end
