# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'general_ledgers/index', type: :view do

  let(:general_ledgers) do
    # Create a chunk of general ledgers
    Kaminari.paginate_array(Array.new(2) do |i|
      create(:general_ledger, description: "General ledger #{i}")
    end).page
  end

  before(:each) do
    # Assign the general ledgers to show in the view
    assign(:general_ledgers, general_ledgers)

    sign_in_oauth :financial_admin
  end

  it 'renders a list of general_ledgers' do
    render

    # Search for the correct general ledgers
    general_ledgers.each do |g|
      assert_select 'tr>td div:nth-child(1)', text: g.description, count: 1
    end
  end
end
