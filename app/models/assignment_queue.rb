class AssignmentQueue < ApplicationRecord

  resourcify
  audited

  include Searchable

  belongs_to :user
  belongs_to :training_request, required: false

  enum status: ASSIGNMENT_STATUS

  validates :status, presence: true, inclusion: {in: statuses.keys , message: 'The value: %{value} is not a valid status'}
  validates :assignment_order, presence: true, numericality: true

  scope :queue, lambda {
    where(status: 'ACTIVE')
      .order(:id, :assignment_order)
      .uniq(&:user_id)
  }

  # Generates a new assignment round for the
  # pending training requests
  def self.assignment_round
    AssignmentQueue.create(User.with_role(:training_admin).map
                               .with_index do |u, i|
                                 { assignment_order: (i + 1),
                                   status: 'ACTIVE',
                                   user_id: u.id }
                               end)
  end

  # Get the next value in the queue
  def self.next_in_queue
    queue.first
  end

end