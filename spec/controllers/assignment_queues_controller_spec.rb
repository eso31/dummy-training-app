require 'rails_helper'

describe AssignmentQueuesController do

  before(:each) do
    sign_in_oauth
  end

  let(:valid_attributes) {
    build(:assignment_queue).attributes
  }

  let(:invalid_attributes) {
    build(:assignment_queue, :invalid).attributes
  }

  let(:valid_session) { {} }

  describe 'GET #index' do
    context 'with valid privileges' do
      it 'returns a success response' do
        sign_in_oauth :admin
        get :index, params: {}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'GET #show' do
    context 'with valid privileges' do
      it 'returns a success response' do
        sign_in_oauth :admin
        assignment_queue = AssignmentQueue.create! valid_attributes
        get :show, params: {id: assignment_queue.to_param}, session: valid_session
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
        assignment_queue = AssignmentQueue.create! valid_attributes
        get :edit, params: {id: assignment_queue.to_param}, session: valid_session
        expect(response).to be_success
      end
    end

    context 'with invalid privileges' do
      it 'returns a not authorized error if user has not correct privileges' do
        assignment_queue = AssignmentQueue.create! valid_attributes
        expect { get :edit, params: {id: assignment_queue.to_param}, session: valid_session
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
        it 'creates a new AssignmentQueue' do
          expect {
            post :create, params: {assignment_queue: valid_attributes}, session: valid_session
          }.to change(AssignmentQueue, :count).by(1)
        end

        it 'redirects to the created assignment_queue' do
          post :create, params: {assignment_queue: valid_attributes}, session: valid_session
          expect(response).to redirect_to(AssignmentQueue.last)
        end
      end

      context 'with invalid params' do
        it "returns a success response (i.e. to display the 'new' template)" do
          post :create, params: {assignment_queue: invalid_attributes}, session: valid_session
          expect(response).to be_success
        end
      end
    end

    context 'with invalid privileges' do
      it 'returns a not authorized error if user has not correct privileges' do
        expect {
          post :create, params: {assignment_queue: valid_attributes}, session: valid_session
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
          build(:assignment_queue, status: 'assigned').attributes
        }

        it 'updates the requested assignment_queue' do
          assignment_queue = AssignmentQueue.create! valid_attributes
          put :update, params: {id: assignment_queue.to_param, assignment_queue: new_attributes}, session: valid_session
          assignment_queue.reload
          expect(assignment_queue.status).to eql('assigned')
        end

        it 'redirects to the assignment_queue' do
          assignment_queue = AssignmentQueue.create! valid_attributes
          put :update, params: {id: assignment_queue.to_param, assignment_queue: valid_attributes}, session: valid_session
          expect(response).to redirect_to(assignment_queue)
        end
      end

      context 'with invalid params' do
        it "returns a success response (i.e. to display the 'edit' template)" do
          assignment_queue = AssignmentQueue.create! valid_attributes
          put :update, params: {id: assignment_queue.to_param, assignment_queue: invalid_attributes}, session: valid_session
          expect(response).to be_success
        end
      end
    end

    context 'with invalid privileges' do
      it 'returns a not authorized error if user has not correct privileges' do
        assignment_queue = AssignmentQueue.create! valid_attributes
        expect { put :update, params: {id: assignment_queue.to_param, assignment_queue: valid_attributes}, session: valid_session
        }.to raise_error CanCan::AccessDenied
      end
    end
  end

  describe 'DELETE #destroy' do

    context 'with valid privileges' do

      before(:each) do
        sign_in_oauth :admin
      end

      it 'destroys the requested assignment_queue' do
        assignment_queue = AssignmentQueue.create! valid_attributes
        expect {
          delete :destroy, params: {id: assignment_queue.to_param}, session: valid_session
        }.to change(AssignmentQueue, :count).by(-1)
      end

      it 'redirects to the assignment_queues list' do
        assignment_queue = AssignmentQueue.create! valid_attributes
        delete :destroy, params: {id: assignment_queue.to_param}, session: valid_session
        expect(response).to redirect_to(assignment_queues_url)
      end
    end

    context 'with invalid privileges' do
      it 'returns a not authorized error if user has not correct privileges' do
        assignment_queue = AssignmentQueue.create! valid_attributes
        expect {
          delete :destroy, params: {id: assignment_queue.to_param}, session: valid_session
        }.to raise_error CanCan::AccessDenied
      end
    end
  end

  describe 'POST #assignment_round' do
    context 'with valid privileges' do
      before(:each) do
        sign_in_oauth :admin
      end

      context 'with valid params' do
        it 'creates a new Assignment Round' do
          create(:training_admin)
          create(:training_admin)
          expect do
            post :assignment_round, session: valid_session
          end.to change(AssignmentQueue, :count).by(2)
        end

        it 'redirects to the index' do
          post :assignment_round, session: valid_session
          expect(response).to redirect_to(action: :index)
        end
      end
    end

    context 'with invalid privileges' do
      it 'returns a not authorized error if user has not correct privileges' do
        expect do
          post :assignment_round, session: valid_session
        end.to raise_error CanCan::AccessDenied
      end
    end
  end
end
