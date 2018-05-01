require 'rails_helper'

describe CoursesController do

  before(:each) do
    sign_in_oauth
  end

  let(:valid_attributes) {
    build(:course).attributes
  }

  let(:invalid_attributes) {
    build(:course, :max_group_size => 1).attributes
  }

  let(:valid_session) {{}}

  describe "GET #index" do
    context 'with valid privileges' do
      it "returns a success response" do
        sign_in_oauth :admin
        course = Course.create! valid_attributes
        get :index, params: {}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe "GET #show" do
    context 'with valid privileges' do
      it "returns a success response" do
        sign_in_oauth :admin
        course = Course.create! valid_attributes
        get :show, params: {id: course.to_param}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe "GET #new" do
    context 'with valid privileges' do
      it "returns a success response" do
        sign_in_oauth :admin
        get :new, params: {}, session: valid_session
        expect(response).to be_success
      end
    end

    context 'with invalid privileges' do
      it "returns a not authorized error if user has not correct privileges" do
        expect {
        get :new, params: {}, session: valid_session
        }.to raise_error CanCan::AccessDenied
      end
    end
  end

  describe "GET #edit" do
    context 'with valid privileges' do
      it "returns a success response" do
        sign_in_oauth :admin
        course = Course.create! valid_attributes
        get :edit, params: {id: course.to_param}, session: valid_session
        expect(response).to be_success
      end
    end

    context 'with invalid privileges' do
      it "returns a not authorized error if user has not correct privileges" do
        course = Course.create! valid_attributes
        expect { get :edit, params: {id: course.to_param}, session: valid_session
        }.to raise_error CanCan::AccessDenied
      end
    end
  end

  describe "POST #create" do
    context 'with valid privileges' do

      before(:each) do
        sign_in_oauth :admin
      end

      context "with valid params" do
        it "creates a new Course" do
          expect {
            post :create, params: {course: valid_attributes}, session: valid_session
          }.to change(Course, :count).by(1)
        end

        it "redirects to the created course" do
          post :create, params: {course: valid_attributes}, session: valid_session
          expect(response).to redirect_to(Course.last)
        end
      end

      context "with invalid params" do
        it "returns a success response (i.e. to display the 'new' template)" do
          post :create, params: {course: invalid_attributes}, session: valid_session
          expect(response).to be_success
        end
      end
    end

    context 'with invalid privileges' do
      it "returns a not authorized error if user has not correct privileges" do
        expect {
          post :create, params: {course: valid_attributes}, session: valid_session
        }.to raise_error CanCan::AccessDenied
      end
    end
  end

  describe "PUT #update" do
    context 'with valid privileges' do

      before(:each) do
        sign_in_oauth :admin
      end

      context "with valid params" do
        let(:new_attributes) {
          build(:course, title: 'New Title').attributes
        }

        it "updates the requested course" do
          course = Course.create! valid_attributes
          put :update, params: {id: course.to_param, course: new_attributes}, session: valid_session
          course.reload
          expect(course.title).to eql('New Title')
        end

        it "redirects to the course" do
          course = Course.create! valid_attributes
          put :update, params: {id: course.to_param, course: valid_attributes}, session: valid_session
          expect(response).to redirect_to(course)
        end
      end

      context "with invalid params" do
        it "returns a success response (i.e. to display the 'edit' template)" do
          course = Course.create! valid_attributes
          put :update, params: {id: course.to_param, course: invalid_attributes}, session: valid_session
          expect(response).to be_success
        end
      end
    end

    context 'with invalid privileges' do
      it "returns a not authorized error if user has not correct privileges" do
        course = Course.create! valid_attributes
        expect { put :update, params: {id: course.to_param, course: valid_attributes}, session: valid_session
        }. to raise_error CanCan::AccessDenied
      end
    end
  end

  describe "DELETE #destroy" do

    context 'with valid privileges' do

      before(:each) do
        sign_in_oauth :admin
      end

      it "destroys the requested course" do
        course = Course.create! valid_attributes
        expect {
          delete :destroy, params: {id: course.to_param}, session: valid_session
        }.to change(Course, :count).by(-1)
      end

      it "redirects to the courses list" do
        course = Course.create! valid_attributes
        delete :destroy, params: {id: course.to_param}, session: valid_session
        expect(response).to redirect_to(courses_url)
      end
    end
  end

  context 'with invalid privileges' do
    it "returns a not authorized error if user has not correct privileges" do
      course = Course.create! valid_attributes
      expect {
        delete :destroy, params: {id: course.to_param}, session: valid_session
      }.to raise_error CanCan::AccessDenied
    end
  end

end