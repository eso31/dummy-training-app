require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  subject { create :enrollment }

  it 'should be valid with valid attributes' do
    expect(subject).to be_valid
  end


  it "validates presence of attributes" do
    expect(subject.attended).not_to be_nil
  end

  it "validates return of attended" do
    expect(subject.set_attended).to eql(false)
  end

  describe "Associations" do
    it "belongs to user" do
      should belong_to(:user)
    end

    it "belongs to training session" do
      should belong_to(:training_session)
    end
  end
end
