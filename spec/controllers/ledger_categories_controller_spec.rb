require 'rails_helper'

RSpec.describe LedgerCategoriesController, type: :controller do

  before(:each) do
    sign_in_oauth
  end

  let(:valid_attributes) {
    build(:ledger_category).attributes
  }

  let(:invalid_attributes) {
    build(:ledger_category, name: nil).attributes
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    context 'with valid privileges' do
      it "returns a success response" do
        sign_in_oauth :admin
        ledger_category = LedgerCategory.create! valid_attributes
        get :index, params: {}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe "GET #show" do
    context 'with valid privileges' do
      it "returns a success response" do
        sign_in_oauth :admin
        ledger_category = LedgerCategory.create! valid_attributes
        get :show, params: {id: ledger_category.to_param}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe "GET #new" do
    context 'with valid privileges' do
      it "returns a success response" do
        sign_in_oauth :financial_admin
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

  describe "GET #edit" do
    context 'with valid privileges' do
      it "returns a success response" do
        sign_in_oauth :financial_admin
        ledger_category = LedgerCategory.create! valid_attributes
        get :edit, params: {id: ledger_category.to_param}, session: valid_session
        expect(response).to be_success
      end
    end

    context 'with invalid privileges' do
      it 'returns a not authorized error if user has not correct privileges' do
        ledger_category = LedgerCategory.create! valid_attributes
        expect { get :edit, params: {id: ledger_category.to_param}, session: valid_session
        }.to raise_error CanCan::AccessDenied
      end
    end
  end

  describe "POST #create" do
    context 'with valid privileges' do

      before(:each) do
        sign_in_oauth :financial_admin
      end

      context "with valid params" do
        it "creates a new LedgerCategory" do
          expect {
            post :create, params: {ledger_category: valid_attributes}, session: valid_session
          }.to change(LedgerCategory, :count).by(1)
        end

        it "redirects to the created ledger_category" do
          post :create, params: {ledger_category: valid_attributes}, session: valid_session
          expect(response).to redirect_to(LedgerCategory.last)
        end
      end

      context "with invalid params" do
        it "returns a success response (i.e. to display the 'new' template)" do
          post :create, params: {ledger_category: invalid_attributes}, session: valid_session
          expect(response).to be_success
        end
      end
    end

    context 'with invalid privileges' do
      it 'returns a not authorized error if user has not correct privileges' do
        expect {
          post :create, params: {ledger_category: valid_attributes}, session: valid_session
        }.to raise_error CanCan::AccessDenied
      end
    end
  end

  describe "PUT #update" do
    context 'with valid privileges' do

      before(:each) do
        sign_in_oauth :financial_admin
      end

      context "with valid params" do
        let(:new_attributes) {
          build(:ledger_category, name: "Updated").attributes
        }

        it "updates the requested ledger_category" do
          ledger_category = LedgerCategory.create! valid_attributes
          put :update, params: {id: ledger_category.to_param, ledger_category: new_attributes}, session: valid_session
          ledger_category.reload
          expect(ledger_category.name).to eq("Updated")
        end

        it "redirects to the ledger_category" do
          ledger_category = LedgerCategory.create! valid_attributes
          put :update, params: {id: ledger_category.to_param, ledger_category: valid_attributes}, session: valid_session
          expect(response).to redirect_to(ledger_category)
        end
      end

        context "with invalid params" do
          it "returns a success response (i.e. to display the 'edit' template)" do
            ledger_category = LedgerCategory.create! valid_attributes
            put :update, params: {id: ledger_category.to_param, ledger_category: invalid_attributes}, session: valid_session
            expect(response).to be_success
          end
        end
      end

    context 'with invalid privileges' do
      it 'returns a not authorized error if user has not correct privileges' do
        ledger_category = LedgerCategory.create! valid_attributes
        expect { put :update, params: {id: ledger_category.to_param, ledger_category: valid_attributes}, session: valid_session
        }.to raise_error CanCan::AccessDenied
      end
    end
  end

  describe "DELETE #destroy" do
    context 'with valid privileges' do

      before(:each) do
        sign_in_oauth :financial_admin
      end

      it "destroys the requested ledger_category" do
        ledger_category = LedgerCategory.create! valid_attributes
        expect {
          delete :destroy, params: {id: ledger_category.to_param}, session: valid_session
        }.to change(LedgerCategory, :count).by(-1)
      end

      it "redirects to the ledger_categories list" do
        ledger_category = LedgerCategory.create! valid_attributes
        delete :destroy, params: {id: ledger_category.to_param}, session: valid_session
        expect(response).to redirect_to(ledger_categories_url)
      end
    end

    context 'with invalid privileges' do
      it 'returns a not authorized error if user has not correct privileges' do
        ledger_category = LedgerCategory.create! valid_attributes
        expect {
          delete :destroy, params: {id: ledger_category.to_param}, session: valid_session
        }.to raise_error CanCan::AccessDenied
      end
    end
  end
end