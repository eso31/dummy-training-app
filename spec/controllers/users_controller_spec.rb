# frozen_string_literal: true

require 'rails_helper'

describe UsersController do

  before(:each) do
    sign_in_oauth
  end

  let(:valid_attributes) { attributes_for(:user) }

  let(:invalid_attributes) { attributes_for(:user, :invalid) }

  let(:valid_session) { {} }

  describe 'GET #index' do
    context 'with valid privileges' do
      it 'returns a success response' do
        sign_in_oauth :admin
        user = User.create! valid_attributes
        get :index, params: {}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'GET #show' do
    context 'with valid privileges' do
      it 'returns a success response' do
        sign_in_oauth :admin
        user = User.create! valid_attributes
        get :show, params: { id: user.to_param }, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'GET #new' do
    context 'with valid privileges' do
      it 'returns a success response' do
        sign_in_oauth :admin
        get :new, params: valid_attributes, session: valid_session
        expect(response).to be_success
      end
    end

    context 'with invalid privileges' do
      it 'returns a not authorized error if user has not correct privileges' do
        expect {get :new, params: valid_attributes, session: valid_session
        }.to raise_error CanCan::AccessDenied
      end
    end
  end

  describe 'GET #edit' do
    context 'with valid privileges' do
      it 'returns a success response' do
        sign_in_oauth :admin
        user = User.create! valid_attributes
        get :edit, params: { id: user.to_param }, session: valid_session
        expect(response).to be_success
      end
    end

    context 'with invalid privileges' do
      it 'returns a not authorized error if user has not correct privileges' do
        user = User.create! valid_attributes
        expect { get :edit, params: { id: user.to_param }, session: valid_session
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
        it 'creates a new User' do
          expect do
            post :create, params: { user: valid_attributes }, session: valid_session
          end.to change(User, :count).by(1)
        end

        it 'redirects to the created user' do
          post :create, params: { user: valid_attributes }, session: valid_session
          expect(response).to redirect_to(User.last)
        end
      end

      context 'with invalid params' do
        it "returns a success response (i.e. to display the 'new' template)" do
          post :create, params: { user: invalid_attributes }, session: valid_session
          expect(response).to be_success
        end
      end
    end

    context 'with invalid privileges' do
      it 'returns a not authorized error if user has not correct privileges' do
        expect { post :create, params: { user: valid_attributes }, session: valid_session
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
        let(:new_attributes) do
          build(:user, email: 'new@example.com', first_name: 'Gotcha',
                last_name: 'Woop', password: 'no_so_secret').attributes
        end

        it 'updates the requested user' do
          user = User.create! valid_attributes
          put :update, params: { id: user.to_param, user: new_attributes }, session: valid_session
          user.reload
          expect(user.email).to eq('new@example.com')
          expect(user.first_name).to eq('Gotcha')
          expect(user.last_name).to eq('Woop')
        end

        it 'redirects to the user' do
          user = User.create! valid_attributes
          put :update, params: { id: user.to_param, user: valid_attributes }, session: valid_session
          expect(response).to redirect_to(user)
        end

        context 'with invalid params' do
          it "returns a success response (i.e. to display the 'edit' template)" do
            user = User.create! valid_attributes
            put :update, params: { id: user.to_param, user: invalid_attributes }, session: valid_session
            expect(response).to be_success
          end
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'with valid privileges' do
      before(:each) do
        sign_in_oauth :admin
      end

      it 'destroys the requested user' do
        user = User.create! valid_attributes
        expect do
          delete :destroy, params: { id: user.to_param }, session: valid_session
        end.to change(User, :count).by(-1)
      end

      it 'redirects to the users list' do
        user = User.create! valid_attributes
        delete :destroy, params: { id: user.to_param }, session: valid_session
        expect(response).to redirect_to(users_url)
      end
    end

    context 'with invalid privileges' do
      it "returns a not authorized error if user has not correct privileges" do
        user = User.create! valid_attributes
        expect { delete :destroy, params: { id: user.to_param }, session: valid_session
        }.to raise_error CanCan::AccessDenied
      end
    end
  end

  describe 'GET #available_training_admins' do

    before(:each) do
      sign_in_oauth :admin
    end

    it 'returns a success response' do

      create(:training_admin)
      create(:training_admin)

      AssignmentQueue.assignment_round

      get :available_training_admins, format: :json
      expect(response).to be_success
    end
  end
end