require 'rails_helper'

RSpec.describe RatingReason, type: :model do
  subject { create(:rating_reason) }

  it 'should validate required attributes' do
    should validate_presence_of(:rating_type)
    should validate_presence_of(:description)
  end

end
