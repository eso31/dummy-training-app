class ClassLocation < ApplicationRecord
  audited
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :timezone, presence: true
end
