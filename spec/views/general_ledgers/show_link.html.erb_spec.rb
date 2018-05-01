# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'general_ledgers/show_link', type: :view do
  let(:general_ledgers) do

    # Create a chunk of general ledgers
    Kaminari.paginate_array(Array.new(2) do |i|
      create(:general_ledger, description: "General ledger #{i}",
                              training_session_id: nil)
    end).page
  end

  let(:training_session) do
    create(:training_session)
  end

  let(:training_request) do
    create(:training_request)
  end

  before(:each) do
    sign_in_oauth :financial_admin
  end

  it 'renders a list of general ledgers' do
    assign(:general_ledgers, general_ledgers)

    render

    # Search for the correct general ledgers
    general_ledgers.each do |g|
      assert_select 'tr>td div:nth-child(1)', text: g.description, count: 1
    end
  end

  it 'renders a training session with a ts assigned' do
    assign(:general_ledgers, general_ledgers)
    assign(:training_session, training_session)

    render

    assert_select '.card-header', text: /#{Regexp.quote(training_session.title)}/
  end

  it 'renders a training session with a ts assigned' do
    assign(:general_ledgers, general_ledgers)
    assign(:training_request, training_request)

    render

    assert_select '.card-header', text: /#{Regexp.quote(training_request.name)}/
  end

end
