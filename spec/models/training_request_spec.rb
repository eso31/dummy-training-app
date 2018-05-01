require 'rails_helper'

RSpec.describe TrainingRequest, type: :model do

  subject { create :training_request }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'should validate presence of attributes' do
    should validate_presence_of(:name)
    should validate_presence_of(:description)
    should validate_presence_of(:duration_in_minutes)
    should validate_presence_of(:status)
  end

  describe 'Associations' do
    it 'belongs to requested_by' do
      should belong_to(:requested_by_user)
    end

    it 'belongs to assigned_to' do
      should belong_to(:assigned_to_user)
    end
  end
end
