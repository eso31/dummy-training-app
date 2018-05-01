require 'rails_helper'

describe SessionRatingsController do

  before(:each) do
    sign_in_oauth
  end

  let(:valid_attributes) {
    build(:session_rating).attributes
  }

  let(:invalid_attributes) {
    build(:session_rating, :invalid).attributes
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    context 'with invalid privileges' do
      it "returns a success response" do
        sign_in_oauth :admin
        session_rating = SessionRating.create! valid_attributes
        get :index, params: {}, session: valid_session
        expect(response).to be_success
      end
    end

    context 'with invalid privileges' do
      it 'returns a not authorized error if user has not correct privileges' do
        expect { get :index, params: {}, session: valid_session
        }.to raise_error CanCan::AccessDenied
      end
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      sign_in_oauth :admin
      session_rating = SessionRating.create! valid_attributes
      get :show, params: {id: session_rating.to_param}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      sign_in_oauth :admin
      session_rating = SessionRating.create! valid_attributes
      get :edit, params: {id: session_rating.to_param}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new SessionRating" do
        expect {
          post :create, params: {session_rating: valid_attributes}, session: valid_session
        }.to change(SessionRating, :count).by(1)
      end

      it "redirects to the created session_rating" do
        post :create, params: {session_rating: valid_attributes}, session: valid_session
        expect(response).to redirect_to(SessionRating.last.enrollment.training_session)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {session_rating: invalid_attributes}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe "PUT #update" do

    before(:each) do
      sign_in_oauth :admin
    end

    context "with valid params" do
      let(:new_attributes) {
        build(:session_rating, user_type: 'instructor').attributes
      }

      it "updates the requested session_rating" do
        session_rating = SessionRating.create! valid_attributes
        put :update, params: {id: session_rating.to_param, session_rating: new_attributes}, session: valid_session
        session_rating.reload
        expect(session_rating.user_type).to eql('instructor')
      end

      it "redirects to the session_rating" do
        session_rating = SessionRating.create! valid_attributes
        put :update, params: {id: session_rating.to_param, session_rating: valid_attributes}, session: valid_session
        expect(response).to redirect_to(session_rating.enrollment.training_session)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        session_rating = SessionRating.create! valid_attributes
        put :update, params: {id: session_rating.to_param, session_rating: invalid_attributes}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe "DELETE #destroy" do

    before(:each) do
      sign_in_oauth :admin
    end

    it "destroys the requested session_rating" do
      session_rating = SessionRating.create! valid_attributes
      expect {
        delete :destroy, params: {id: session_rating.to_param}, session: valid_session
      }.to change(SessionRating, :count).by(-1)
    end

    it "redirects to the session_ratings list" do
      session_rating = SessionRating.create! valid_attributes
      delete :destroy, params: {id: session_rating.to_param}, session: valid_session
      expect(response).to redirect_to(session_ratings_url)
    end
  end

end
