require 'rails_helper'

RSpec.describe "assignment_queues/new", type: :view do

  before(:each) do
    assign(:assignment_queue, build(:assignment_queue))
  end

  it "renders new assignment_queue form" do
    render

    assert_select "form[action=?][method=?]", assignment_queues_path, "post" do

      assert_select "input[name=?]", "assignment_queue[assignment_order]"

      assert_select "select[name=?]", "assignment_queue[status]"
    end
  end
end
