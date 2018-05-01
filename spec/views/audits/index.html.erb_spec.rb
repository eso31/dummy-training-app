# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'audits/index.html.erb', type: :view do
  let(:first_audit) { create(:audit) }
  let(:second_audit) { create(:audit) }
  before(:each) do
    assign(:audits, Kaminari.paginate_array([first_audit, second_audit]).page)
    assign(:options, actions: { all: '' }, model_names: { all: '' })
    assign(:audit, Audit.new)
  end

  it 'renders a list of audits' do
    render
    assert_select 'tr.audited_audit', count: 2
    assert_select "#audited_audit_#{first_audit.id} td:nth-child(3)",
                  text: first_audit.auditable_type, count: 1
    assert_select "#audited_audit_#{second_audit.id} td:nth-child(3)",
                  text: second_audit.auditable_type, count: 1
  end
end
