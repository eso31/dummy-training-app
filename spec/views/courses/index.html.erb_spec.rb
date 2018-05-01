# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'courses/index', type: :view do

  let(:course) { create(:course) }

  before(:each) do
    @courses = assign(:course, Kaminari.paginate_array([create(:course)]).page)
    sign_in_oauth
  end

  it 'renders a list of courses' do
    render
    assert_select 'tr>td', text: /#{Regexp.quote(course.title)}/, count: 1
    assert_select 'tr>td', text: /#{Regexp.quote(course.description)}/, count: 1
  end
end