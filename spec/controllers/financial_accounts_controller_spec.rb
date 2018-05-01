require 'rails_helper'

RSpec.describe FinancialAccountsController, type: :controller do

  before(:each) do
    sign_in_oauth
  end

  let(:valid_attributes) {
    build(:financial_account).attributes
  }

  let(:invalid_attributes) {
    build(:financial_account, name: nil).attributes
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    context 'with valid privileges' do
      it "returns a success response" do
        sign_in_oauth :financial_admin
        financial_account = FinancialAccount.create! valid_attributes
        get :index, params: {}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe "GET #show" do
    context 'with valid privileges' do
      it "returns a success response" do
        sign_in_oauth :financial_admin
        financial_account = FinancialAccount.create! valid_attributes
        get :show, params: {id: financial_account.to_param}, session: valid_session
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
        financial_account = FinancialAccount.create! valid_attributes
        get :edit, params: {id: financial_account.to_param}, session: valid_session
        expect(response).to be_success
      end
    end

    context 'with invalid privileges' do
      it 'returns a not authorized error if user has not correct privileges' do
        financial_account = FinancialAccount.create! valid_attributes
        expect { get :edit, params: {id: financial_account.to_param}, session: valid_session
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
        it "creates a new FinancialAccount" do
          expect {
            post :create, params: {financial_account: valid_attributes}, session: valid_session
          }.to change(FinancialAccount, :count).by(1)
        end

        it "redirects to the created financial_account" do
          post :create, params: {financial_account: valid_attributes}, session: valid_session
          expect(response).to redirect_to(FinancialAccount.last)
        end
      end

      context "with invalid params" do
        it "returns a success response (i.e. to display the 'new' template)" do
          post :create, params: {financial_account: invalid_attributes}, session: valid_session
          expect(response).to be_success
        end
      end
    end

    context 'with invalid privileges' do
      it "returns a not authorized error if user has not correct privileges" do
        expect {
          post :create, params: {financial_account: valid_attributes}, session: valid_session
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
          build(:financial_account, status: "CLOSE").attributes
        }

        it "updates the requested financial_account" do
          financial_account = FinancialAccount.create! valid_attributes
          put :update, params: {id: financial_account.to_param, financial_account: new_attributes}, session: valid_session
          financial_account.reload
          expect(financial_account.status).to eq("CLOSE")
        end

        it "redirects to the financial_account" do
          financial_account = FinancialAccount.create! valid_attributes
          put :update, params: {id: financial_account.to_param, financial_account: valid_attributes}, session: valid_session
          expect(response).to redirect_to(financial_account)
        end
      end

      context "with invalid params" do
        it "returns a success response (i.e. to display the 'edit' template)" do
          financial_account = FinancialAccount.create! valid_attributes
          put :update, params: {id: financial_account.to_param, financial_account: invalid_attributes}, session: valid_session
          expect(response).to be_success
        end
      end
    end

    context 'with invalid privileges' do
      it "returns a not authorized error if user has not correct privileges" do
        financial_account = FinancialAccount.create! valid_attributes
        expect { put :update, params: {id: financial_account.to_param, financial_account: valid_attributes}, session: valid_session
        }.to raise_error CanCan::AccessDenied
      end
    end
  end

  describe "DELETE #destroy" do

    context "with valid privileges" do

      before(:each) do
        sign_in_oauth :financial_admin
      end

      it "destroys the requested financial_account" do
        financial_account = FinancialAccount.create! valid_attributes
        expect {
          delete :destroy, params: {id: financial_account.to_param}, session: valid_session
        }.to change(FinancialAccount, :count).by(-1)
      end

      it "redirects to the financial_accounts list" do
        financial_account = FinancialAccount.create! valid_attributes
        delete :destroy, params: {id: financial_account.to_param}, session: valid_session
        expect(response).to redirect_to(financial_accounts_url)
      end
    end
  end

  context 'with invalid privileges' do
    it "returns a not authorized error if user has not correct privileges" do
      financial_account = FinancialAccount.create! valid_attributes
      expect { delete :destroy, params: {id: financial_account.to_param}, session: valid_session
      }.to raise_error CanCan::AccessDenied
    end
  end
end
