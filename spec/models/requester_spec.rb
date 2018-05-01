require 'rails_helper'

RSpec.describe Requester, type: :model do

  subject { create :requester }


  it 'should validate presence of attributes' do
    should validate_presence_of(:user)
    should validate_presence_of(:training_request)
    should validate_presence_of(:status)
  end


  describe 'Associations' do
    it 'belongs to user' do
      should belong_to(:user)
    end

    it 'belongs to training_request' do
      should belong_to(:training_request)
    end
  end
end

