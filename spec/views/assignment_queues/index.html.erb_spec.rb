# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'assignment_queues/index', type: :view do

  let(:queues) do
    [create(:assignment_queue)]
  end

  before(:each) do
    @assignment_queues = assign(:assignment_queue, Kaminari
                                                     .paginate_array(queues)
                                                     .page)

    sign_in_oauth
  end

  it 'renders a list of assignment_queues' do
    render
    assert_select 'tr>td', text: 'Active', count: 1
  end
end