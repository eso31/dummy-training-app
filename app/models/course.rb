class Course < ApplicationRecord
  audited
  include Searchable

  belongs_to :taught_by_user, class_name: 'User'
  belongs_to :series, optional: true

  validates :title, presence: true
  validates :duration_in_minutes, presence: true, numericality: true, length: { maximum: 3 }
  validates :min_group_size, presence: true, numericality: true
  validates :max_group_size, presence: true, numericality: { greater_than: :min_group_size }
end
