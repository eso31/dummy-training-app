require 'rails_helper'

RSpec.describe TrainingSession, type: :model do
  subject { create :training_session }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'should validate presence of attributes' do
    should validate_presence_of(:title)
    should validate_presence_of(:description)
    should validate_presence_of(:min_group_size)
    should validate_presence_of(:max_group_size)
    should validate_presence_of(:start_date)
    should validate_presence_of(:duration_in_minutes)
    should validate_presence_of(:session_type)
  end


  describe 'Associations' do
    it 'belongs to course' do
      should belong_to(:course)
    end

    it 'belongs to class_location' do
      should belong_to(:class_location)
    end
  end

  describe 'Instructors roles' do

    it 'add the instructor role when a instructor is added' do
      u = create(:user)
      subject.instructors = [u]
      subject.save
      expect(u.has_role?(:instructor, subject)).to eq true
    end

    it 'clear the instructor roles when updated' do
      u = create(:user)
      subject.instructors = [u]
      subject.save
      subject.instructors = []
      subject.save
      expect(u.has_role?(:instructor, subject)).to eq false
    end

    it 'add the instructor role to several users' do
      users = create_list(:user, 2)
      subject.instructors = users
      subject.save

      instructors = users.inject(true) do |acc, u|
        acc && u.has_role?(:instructor, subject)
      end

      expect(instructors).to eq true
    end

    it 'update the instructor role to several users' do
      users = create_list(:user, 2)

      subject.instructors = users
      subject.save
      subject.instructors = []
      subject.save

      instructors = users.inject(false) do |acc, u|
        acc || u.has_role?(:instructor, subject)
      end

      expect(instructors).to eq false
    end
  end
end
