# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'rating_reasons/index', type: :view do
  before(:each) do
    assign(:rating_reasons,
           Kaminari.paginate_array([
                                     create(:rating_reason,
                                            description: 'Material',
                                            rating_type: 'instructor'),
                                     create(:rating_reason,
                                            description: 'Presentation',
                                            rating_type: 'student')
                                   ]).page)

    sign_in_oauth :admin
  end

  it 'renders a list of rating_reasons' do
    render
    assert_select 'tr:nth-child(1)>td:nth-child(1)', text: 'Material',
                                                     count: 1
    assert_select 'tr:nth-child(1)>td:nth-child(2)', text: 'Instructor',
                                                     count: 1

    assert_select 'tr:nth-child(2)>td:nth-child(1)', text: 'Presentation',
                                                     count: 1
    assert_select 'tr:nth-child(2)>td:nth-child(2)', text: 'Student',
                                                     count: 1
  end
end
