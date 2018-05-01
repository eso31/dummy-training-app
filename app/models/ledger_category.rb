class LedgerCategory < ApplicationRecord
  audited

  validates :name, presence: true
end
