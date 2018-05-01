class RatingReason < ApplicationRecord
  audited
  enum rating_type: {'student': 'STUDENT', 'instructor': 'INSTRUCTOR'}

  has_many :session_ratings, through: 'session_rating_reasons'
  validates :description, presence: true
  validates :rating_type, presence: true, inclusion: {in: rating_types.keys, message: 'The value: %{value} is not a valid rating type'}
end