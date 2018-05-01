class Series < ApplicationRecord
  audited
  validates :name, presence: true

  def to_s
     "#{id}-#{name}"
  end
end
