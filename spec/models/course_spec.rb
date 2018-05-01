require 'rails_helper'

RSpec.describe Course, type: :model do
  subject { create :course }

  it 'should be valid with valid attributes' do
    expect(subject).to be_valid
  end


  it "validates presence of attributes" do
    should validate_presence_of(:title)
    should validate_presence_of(:duration_in_minutes)
    should validate_presence_of(:max_group_size)
  end

  describe "Associations" do
    it "belongs to user" do
      should belong_to(:taught_by_user)
    end

    it "belongs to series" do
      should belong_to(:series)
    end
  end
end