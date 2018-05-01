require 'rails_helper'

RSpec.describe "assignment_queues/edit", type: :view do
  before(:each) do
    @assignment_queue = assign(:assignment_queue, create(:assignment_queue))
  end

  it "renders the edit assignment_queue form" do
    render

    assert_select "form[action=?][method=?]", assignment_queue_path(@assignment_queue), "post" do

      assert_select "input[name=?]", "assignment_queue[assignment_order]"

      assert_select "select[name=?]", "assignment_queue[status]"

    end
  end
end
