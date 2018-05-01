class SessionRating < ApplicationRecord

  audited
  enum user_type: SESSION_RATING_TYPES

  belongs_to :enrollment
  belongs_to :user
  has_and_belongs_to_many :session_rating_reasons, class_name: 'RatingReason', join_table: 'session_rating_reasons'
  validates :user_type, presence: true, inclusion: {in: user_types.keys , message: 'The value: %{value} is not a valid type'}
  validates :rating, presence: true, numericality: true
  validates :user, uniqueness: { scope: :enrollment, message: "You have already rated this training session" }
end