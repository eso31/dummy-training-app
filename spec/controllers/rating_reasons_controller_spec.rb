require 'rails_helper'


describe RatingReasonsController do

  login_user

  let(:valid_attributes) {
    build(:rating_reason).attributes
  }

  let(:invalid_attributes) {
    build(:rating_reason, :invalid).attributes
  }

  let(:valid_session) {{}}

  describe "GET #index" do
    it "returns a success response" do
      rating_reason = RatingReason.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      rating_reason = RatingReason.create! valid_attributes
      get :show, params: {id: rating_reason.to_param}, session: valid_session
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
      rating_reason = RatingReason.create! valid_attributes
      get :edit, params: {id: rating_reason.to_param}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new RatingReason" do
        expect {
          post :create, params: {rating_reason: valid_attributes}, session: valid_session
        }.to change(RatingReason, :count).by(1)
      end

      it "redirects to the created rating_reason" do
        post :create, params: {rating_reason: valid_attributes}, session: valid_session
        expect(response).to redirect_to(RatingReason.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {rating_reason: invalid_attributes}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        build(:rating_reason, description: 'updated desc').attributes
      }

      it "updates the requested rating_reason" do

        rating_reason = RatingReason.create! valid_attributes

        put :update, params: {id: rating_reason.to_param, rating_reason: new_attributes}, session: valid_session
        rating_reason.reload
        expect(rating_reason.description).to eq('updated desc')
      end

      it "redirects to the rating_reason" do
        rating_reason = RatingReason.create! valid_attributes
        put :update, params: {id: rating_reason.to_param, rating_reason: valid_attributes}, session: valid_session
        expect(response).to redirect_to(rating_reason)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        rating_reason = RatingReason.create! valid_attributes
        put :update, params: {id: rating_reason.to_param, rating_reason: invalid_attributes}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested rating_reason" do
      rating_reason = RatingReason.create! valid_attributes
      expect {
        delete :destroy, params: {id: rating_reason.to_param}, session: valid_session
      }.to change(RatingReason, :count).by(-1)
    end

    it "redirects to the rating_reasons list" do
      rating_reason = RatingReason.create! valid_attributes
      delete :destroy, params: {id: rating_reason.to_param}, session: valid_session
      expect(response).to redirect_to(rating_reasons_url)
    end
  end

end
