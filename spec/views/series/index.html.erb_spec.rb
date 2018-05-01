require 'rails_helper'

RSpec.describe 'series/new', type: :view do
  let(:series) {create(:series)}

  before(:each) do
    assign(:series, series)
    sign_in_oauth :admin
  end

  it 'renders new series form' do
    render
    assert_select 'input[name=?]', 'series[name]'
  end
end
