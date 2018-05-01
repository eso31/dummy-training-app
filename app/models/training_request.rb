class TrainingRequest < ApplicationRecord
  audited
  include HasRequestStatus
  include Searchable

  belongs_to :assigned_to_user, class_name: 'User', required: false
  belongs_to :requested_by_user, class_name: 'User'
  has_many :requesters, dependent: :destroy
  has_many :training_request_polls
  has_many :general_ledgers, dependent: :nullify
  has_one  :assignment_queue


  validates :name, presence: true
  validates :requested_by_user, presence: true
  validates :description, presence: true
  validates :duration_in_minutes, presence: true, numericality: true

  # Search for the user if already voted
  def voted?(user)
    !training_request_polls.find_by(user: user).blank?
  end

  # Count the votes and group them by type
  def vote_count
    training_request_polls.group(:vote).count
  end

  # Get the total requested for the training request
  def total_requested
    total_amount_of_type 'REQUESTED'
  end

  def total_planned
    total_amount_of_type 'PLANNED'
  end

  def total_credit
    (total_amount_of_type 'CREDIT') * -1
  end

  def total_debit
    total_amount_of_type 'DEBIT'
  end

  def total_amount_of_type(type)
    request_ledgers = general_ledgers.select do |gl|
      gl.transaction_type == type
    end

    Money.new(request_ledgers.inject(0) do |sum, gl|
      sum + gl.amount
    end * 100)
  end
end
