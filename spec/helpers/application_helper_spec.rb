require 'rails_helper'

RSpec.describe ApplicationHelper, :type => :helper do
  describe '#title' do
    it 'should render the title' do
      helper.title('hello')
      expect(helper.content_for(:title)).to eq('hello')
    end
  end


  describe '#link_button' do
    let (:hmo) {create(:class_location)}
    it 'should render the link ' do
      expect(helper.link_button(hmo, 'Show')).to include(class_location_path(hmo))
      expect(helper.link_button(edit_class_location_path(hmo), 'Edit')).to include(edit_class_location_path(hmo))
      delete_link = helper.link_button(hmo, 'Delete', method: :delete)
      expect(delete_link).to include('data-method="delete"')
      expect(delete_link).to include('data-confirm="Are you sure?"')
    end
  end

end