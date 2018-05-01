require 'rails_helper'

RSpec.describe "assignment_queues/show", type: :view do
  before(:each) do
    @assignment_queue = assign(:assignment_queue, create(:assignment_queue))

    sign_in_oauth
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(@assignment_queue.status)
    expect(rendered).to match(@assignment_queue.assignment_order.to_s)
  end
end
