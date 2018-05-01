require 'rails_helper'

RSpec.describe 'series/edit', type: :view do
  before(:each) do
    @series = assign(:series, create(:series))
  end

  it 'renders the edit series form' do
    render

    assert_select 'form[action=?][method=?]', series_path(@series), 'post' do

      assert_select 'input[name=?]', 'series[name]'

      assert_select 'textarea[name=?]', 'series[description]'
    end
  end
end
