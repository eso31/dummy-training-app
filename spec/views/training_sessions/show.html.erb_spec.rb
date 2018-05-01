# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'training_sessions/show', type: :view do
  before(:each) do
    @training_session = assign(:training_session, create(:ts_with_credit,
                                                         title: 'basic',
                                                         description: 'cool'))
    @enrollment = Enrollment.new
    @general_ledger = assign(:general_ledger, create(:general_ledger))
    @session_rating = assign(:session_rating, create(:session_rating))

    sign_in_oauth :workshops_admin
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(@training_session.title)
    expect(rendered).to match(@training_session.description)
    expect(rendered).to match(@training_session.min_group_size.to_s)
    expect(rendered).to match(@training_session.max_group_size.to_s)
    expect(rendered).to match(@training_session.session_type.capitalize)
    expect(rendered).to match(@training_session.course.title)
    expect(rendered).to match(@training_session.class_location.name)
  end
end
