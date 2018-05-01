# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EnrollmentsController, type: :controller do
  let(:training_session) { create(:training_session) }

  let(:valid_attributes) do
    build(:enrollment).attributes
  end

  let(:invalid_attributes) do
    build(:enrollment).attributes.except('attended', 'user', 'training_session')
  end

  let(:valid_session) { {} }

  describe 'POST #create' do
    context 'with workshop admin role' do
      before(:each) do
        sign_in_oauth :workshops_admin
      end

      context 'with valid params' do
        it 'creates a new Enrollment if training session has not reached his max_group_size' do
          expect do
            post :create, params: { training_session_id: training_session.id, enrollment: valid_attributes }, session: valid_session
          end.to change(Enrollment, :count).by(1)
        end

        it "doesn't create a new enrollment if training session reached his max group size" do
          new_training_session = create(:training_session, min_group_size: 0, max_group_size: 0)
          enrollment = create(:enrollment, training_session_id: new_training_session.id).attributes
          expect do
            post :create, params: { training_session_id: new_training_session.id, enrollment: enrollment }, session: valid_session
          end.to change(Enrollment, :count).by(0)
        end

        it 'redirects to the created enrollment' do
          post :create, params: { training_session_id: training_session.id, enrollment: valid_attributes }, session: valid_session
          expect(response).to redirect_to(Enrollment.last.training_session)
        end
      end

      context 'with invalid params' do
        it "don't return a success response" do
          post :create, params: { training_session_id: training_session.id, enrollment: invalid_attributes }, session: valid_session
          expect(response).not_to be_success
        end
      end
    end
  end

  describe 'PUT #update' do
    let(:current_training_session) { create(:training_session) }
    let(:enroll_user) { create(:user) }
    let(:instructor) do
      new_instructor = create(:user)
      current_training_session.instructors = [new_instructor]
      current_training_session.save
      new_instructor
    end
    let(:new_enrollment) do
      Enrollment.create(user: enroll_user, training_session: current_training_session)
    end

    context 'with workshop admin role' do
      before(:each) do
        sign_in_oauth :workshops_admin
      end

      it 'updates the requested enrollment' do
        put :update,
            params: { training_session_id: new_enrollment.training_session_id,
                      id: new_enrollment.id,
                      enrollment: { attended: true } }

        new_enrollment.reload
        expect(new_enrollment.attended).to be_truthy
      end
    end

    context 'with instructor role' do
      before(:each) do
        sign_in_oauth :user, user: instructor
      end

      it 'updates the requested enrollment' do
        put :update,
            params: { training_session_id: new_enrollment.training_session_id,
                      id: new_enrollment.id,
                      enrollment: { attended: true } },
            session: valid_session

        new_enrollment.reload
        expect(new_enrollment.attended).to be_truthy
      end
    end

    context 'with user role' do
      before(:each) do
        sign_in_oauth :user
      end

      it 'it fail to update the requested enrollment' do
        expect do
          put :update,
              params: { training_session_id: new_enrollment.training_session_id,
                        id: new_enrollment.id,
                        enrollment: { attended: true } },
              session: valid_session
        end.to raise_error CanCan::AccessDenied
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'with workshop admin role' do

      before(:each) do
        sign_in_oauth :workshops_admin
      end

      it 'destroys the requested enrollment' do
        enrollment = Enrollment.create! valid_attributes
        expect do
          delete :destroy, params: { training_session_id: training_session.id, id: enrollment.to_param }, session: valid_session
        end.to change(Enrollment, :count).by(-1)
      end

      it 'redirects to the enrollments list' do
        enrollment = Enrollment.create! valid_attributes
        delete :destroy, params: { training_session_id: training_session.id, id: enrollment.to_param }, session: valid_session
        expect(response).to redirect_to(enrollment.training_session)
      end
    end

    context 'with user role' do

      before(:each) do
        sign_in_oauth :user
      end

      it 'raise a CanCan::AccessDenied error' do
        enrollment = Enrollment.create! valid_attributes
        expect do
          delete :destroy, params: { training_session_id: training_session.id, id: enrollment.to_param }, session: valid_session
        end.to raise_error CanCan::AccessDenied
      end
    end
  end
end
