class TrainingRequestPoll < ApplicationRecord
  audited
  enum vote: {
      approved:'APPROVED', not_approved:'NOT_APPROVED', abstained:'ABSTAINED'
  }

  belongs_to :training_request
  belongs_to :user

  validates :user, presence: true, uniqueness: true
  validates :training_request, presence: true

  validates :vote, presence: true, inclusion: {in: votes.keys , message: 'The value: %{value} is not a valid vote value'}
end
