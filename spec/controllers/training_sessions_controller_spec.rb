require 'rails_helper'


describe TrainingSessionsController do

  before(:each) do
    sign_in_oauth
  end

  let(:valid_attributes) {
    u = create(:user)
    attr = build(:training_session).attributes
    attr['instructors_attributes'] = [u.attributes]

    attr
  }

  let(:invalid_attributes) {
    build(:training_session, :invalid).attributes
  }

  let(:valid_session) {{}}

  describe 'GET #index' do
    it 'returns a success response' do
      training_session = TrainingSession.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      training_session = TrainingSession.create! valid_attributes
      get :show, params: {id: training_session.to_param}, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'GET #new' do
    context 'with valid privileges' do
      it 'returns a success response if user has correct privileges' do
        sign_in_oauth :workshops_admin
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
        sign_in_oauth :workshops_admin
        training_session = TrainingSession.create! valid_attributes
        get :edit, params: {id: training_session.to_param}, session: valid_session
        expect(response).to be_success
      end
    end


    context 'with invalid privileges' do
      it 'returns a not authorized error if user has not correct privileges' do
        training_session = TrainingSession.create! valid_attributes
        expect do
          get :edit, params: {id: training_session.to_param}, session: valid_session
        end.to raise_error CanCan::AccessDenied
      end
    end
  end

  describe 'POST #create' do
    context 'with valid privileges' do

      before(:each) do
        sign_in_oauth :workshops_admin
      end

      context 'with valid params' do

        it 'creates a new TrainingSession' do
          expect {
            post :create, params: {training_session: valid_attributes}, session: valid_session
          }.to change(TrainingSession, :count).by(1)
        end

        it 'redirects to the created training_session' do
          post :create, params: {training_session: valid_attributes}, session: valid_session
          expect(response).to redirect_to(TrainingSession.last)
        end
      end

      context 'with invalid params' do
        it "returns a success response (i.e. to display the 'new' template)" do
          post :create, params: {training_session: invalid_attributes}, session: valid_session
          expect(response).to be_success
        end
      end
    end

    context 'with invalid privileges' do
      it 'returns a not authorized error if user has not correct privileges' do
        expect do
          post :create, params: {training_session: valid_attributes}, session: valid_session
        end.to raise_error CanCan::AccessDenied
      end
    end
  end

  describe 'PUT #update' do

    context 'with valid privileges' do

      before(:each) do
        sign_in_oauth :workshops_admin
      end

      context 'with valid params' do
        let(:new_attributes) {
          build(:training_session, title: 'basic php').attributes
        }

        it 'updates the requested training_session' do
          valid_attributes['title'] = 'advanced php'
          training_session = TrainingSession.create! valid_attributes
          expect(training_session.title).to eq('advanced php')
          put :update, params: {id: training_session.to_param, training_session: new_attributes}, session: valid_session

          training_session.reload

          expect(training_session.title).to eq('basic php')
        end

        it 'redirects to the training_session' do
          training_session = TrainingSession.create! valid_attributes
          put :update, params: {id: training_session.to_param, training_session: valid_attributes}, session: valid_session
          expect(response).to redirect_to(training_session)
        end
      end

      context 'with invalid params' do
        it "returns a success response (i.e. to display the 'edit' template)" do
          training_session = TrainingSession.create! valid_attributes
          put :update, params: {id: training_session.to_param, training_session: invalid_attributes}, session: valid_session
          expect(response).to be_success
        end
      end
    end

    context 'with invalid privileges' do
      let(:new_attributes) {
        build(:training_session, title: 'basic php').attributes
      }

      it 'returns a not authorized error if user has not correct privileges' do
        training_session = TrainingSession.create! valid_attributes
        expect do
          put :update, params: {id: training_session.to_param, training_session: new_attributes}, session: valid_session
        end.to raise_error CanCan::AccessDenied
      end
    end

  end

  describe "DELETE #destroy" do

    context 'with valid privileges' do

      before(:each) do
        sign_in_oauth :workshops_admin
      end

      it "destroys the requested training_session" do
        training_session = TrainingSession.create! valid_attributes
        expect {
          delete :destroy, params: {id: training_session.to_param}, session: valid_session
        }.to change(TrainingSession, :count).by(-1)
      end

      it "redirects to the training_sessions list" do
        training_session = TrainingSession.create! valid_attributes
        delete :destroy, params: {id: training_session.to_param}, session: valid_session
        expect(response).to redirect_to(training_sessions_url)
      end
    end

    context 'with invalid privileges' do
      it 'returns a not authorized error if user has not correct privileges' do
        training_session = TrainingSession.create! valid_attributes
        expect do
          delete :destroy, params: {id: training_session.to_param}, session: valid_session
        end.to raise_error CanCan::AccessDenied
      end
    end

  end

end