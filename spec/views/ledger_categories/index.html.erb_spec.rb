# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ledger_categories/index', type: :view do

  # Default ledger categories
  let(:ledger_categories) do
    Array.new(2) { |i| create(:ledger_category, name: "Ledger category #{i}") }
  end

  before(:each) do
    assign(:ledger_categories, Kaminari.paginate_array(ledger_categories).page)

    sign_in_oauth :financial_admin
  end

  it 'renders a list of ledger_categories' do
    render
    ledger_categories.each do |c|
      assert_select 'tr>td div:nth-child(1)', text: c.name, count: 1
    end
  end
end
