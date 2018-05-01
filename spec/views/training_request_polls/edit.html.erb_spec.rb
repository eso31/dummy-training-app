require 'rails_helper'

RSpec.describe "training_request_polls/edit", type: :view do
  before(:each) do
    @training_request_poll = assign(:training_request_poll, create(:training_request_poll))
    @training_request = assign(:training_request, create(:training_request))
  end

  it 'renders the edit training_request_poll form' do
    render

      assert_select 'form[action=?][method=?]', training_request_training_request_poll_path(@training_request, @training_request_poll), "post" do

      assert_select "select[name=?]", 'training_request_poll[vote]'

      assert_select "textarea[name=?]", "training_request_poll[comment]"
    end
  end
end
