require 'rails_helper'

RSpec.describe AssignmentQueue, type: :model do
  subject { create :assignment_queue }

  it 'validates presence of attributes' do
    should validate_presence_of(:assignment_order)
    should validate_presence_of(:status)
  end

  describe 'Associations' do
    it 'belongs to training_request' do
      should belong_to(:training_request)
    end
    it 'belongs to user' do
      should belong_to(:user)
    end
  end

  describe 'Queue' do
    before :each do
      # Generate a pair of training admins to test
      create(:training_admin)
      create(:training_admin)

      AssignmentQueue.assignment_round
    end

    it 'should generate a correct assignment round' do
      expect(AssignmentQueue.all.length).to be 2
    end

    it 'should get the assignment queue in assignment_order order defined' do
      result_queue = AssignmentQueue.queue
      expect(result_queue.first.assignment_order).to be < result_queue.second.assignment_order
    end

    it 'should get next in queue with order id 0' do
      expect(AssignmentQueue.next_in_queue.assignment_order).to be(1)
    end
  end

end
