require 'rails_helper'

RSpec.describe SessionRating, type: :model do

  subject { create :session_rating }

  it 'should be valid with valid attributes' do
    expect(subject).to be_valid
  end


  it "validates presence of attributes" do
    should validate_presence_of(:user_type)
    should validate_presence_of(:rating)
  end

  describe "Associations" do
    it "belongs to user" do
      should belong_to(:user)
    end

    it "belongs to enrollment" do
      should belong_to(:enrollment)
    end
  end
end
