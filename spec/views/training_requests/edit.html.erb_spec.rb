require 'rails_helper'

RSpec.describe 'training_requests/edit', type: :view do
  before(:each) do
    @training_request = assign(:training_request, create(:training_request))
    @users = AssignmentQueue.queue.map(&:user)
  end

  context 'as an admin user' do
    before(:each) do
      sign_in_oauth :admin
    end

    it 'renders the edit training_request form' do
      render

      assert_select 'form[action=?][method=?]', training_request_path(@training_request), 'post' do

        assert_select 'input[name=?]', 'training_request[name]'

        assert_select 'textarea[name=?]', 'training_request[description]'

        assert_select 'input[name=?]', 'training_request[location]'

        assert_select 'input[name=?]', 'training_request[duration_in_minutes]'

        assert_select 'select[name=?]', 'training_request[status]'

        assert_select 'input[name=?]', 'training_request[reference_file]'

        assert_select 'input[name=?]', 'training_request[assigned_to_user_id]'

        assert_select 'input[name=?]', 'training_request[requested_by_user_id]'
      end
    end

  end

  context 'as a normal user' do
    before(:each) do
      sign_in_oauth :user
    end

    it 'renders the edit training_request form' do
      render

      assert_select 'form[action=?][method=?]', training_request_path(@training_request), 'post' do

        assert_select 'input[name=?]', 'training_request[name]'

        assert_select 'textarea[name=?]', 'training_request[description]'

        assert_select 'input[name=?]', 'training_request[location]'

        assert_select 'input[name=?]', 'training_request[duration_in_minutes]'

        assert_select 'input[name=?]', 'training_request[reference_file]'

        assert_select 'select[name=?]', 'training_request[status]', false

        assert_select 'input[name=?]', 'training_request[requested_by_user_id]', false
      end
    end

  end
end
