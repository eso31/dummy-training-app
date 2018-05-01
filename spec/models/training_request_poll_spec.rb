require 'rails_helper'

RSpec.describe TrainingRequestPoll, type: :model do
  subject { create :training_request_poll }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'validates presence of attributes' do
    should validate_presence_of(:vote)
    should validate_presence_of(:training_request)
    should validate_presence_of(:user)
  end


  describe 'Associations' do
    it 'belongs to training_request' do
      should belong_to(:training_request)
    end

    it 'belongs to user' do
      should belong_to(:user)
    end
  end
end
