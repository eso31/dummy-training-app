require 'rails_helper'

RSpec.describe 'series/new', type: :view do
  before(:each) do
    @series = assign(:series, create(:series))
  end

  it 'renders new series form' do
    render

    assert_select 'form[action=?][method=?]', series_path(@series), 'post' do

      assert_select 'input[name=?]', 'series[name]'
    end
  end
end
