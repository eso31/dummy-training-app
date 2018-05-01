require 'rails_helper'

describe ClassLocationsController do

  before(:each) do
    sign_in_oauth :admin
  end

  let(:valid_attributes) {
    build(:class_location).attributes
  }

  let(:invalid_attributes) {
    build(:class_location, :invalid).attributes
  }

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'returns a success response' do
      class_location = ClassLocation.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      class_location = ClassLocation.create! valid_attributes
      get :show, params: {id: class_location.to_param}, session: valid_session
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
      class_location = ClassLocation.create! valid_attributes
      get :edit, params: {id: class_location.to_param}, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new ClassLocation' do
        expect {
          post :create, params: {class_location: valid_attributes}, session: valid_session
        }.to change(ClassLocation, :count).by(1)
      end

      it 'redirects to the created class_location' do
        post :create, params: {class_location: valid_attributes}, session: valid_session
        expect(response).to redirect_to(ClassLocation.last)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {class_location: invalid_attributes}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) {
        build(:class_location, name:'America/Hermosillo').attributes

      }

      it 'updates the requested class_location' do
        class_location = ClassLocation.create! valid_attributes
        put :update, params: {id: class_location.to_param, class_location: new_attributes}, session: valid_session
        class_location.reload
        expect(class_location.name).to eq 'America/Hermosillo'
      end

      it 'redirects to the class_location' do
        class_location = ClassLocation.create! valid_attributes
        put :update, params: {id: class_location.to_param, class_location: valid_attributes}, session: valid_session
        expect(response).to redirect_to(class_location)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        class_location = ClassLocation.create! valid_attributes
        put :update, params: {id: class_location.to_param, class_location: invalid_attributes}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested class_location' do
      class_location = ClassLocation.create! valid_attributes
      expect {
        delete :destroy, params: {id: class_location.to_param}, session: valid_session
      }.to change(ClassLocation, :count).by(-1)
    end

    it 'redirects to the class_locations list' do
      class_location = ClassLocation.create! valid_attributes
      delete :destroy, params: {id: class_location.to_param}, session: valid_session
      expect(response).to redirect_to(class_locations_url)
    end
  end

end
