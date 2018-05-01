module HasRequestStatus
  extend ActiveSupport::Concern
  included do
    enum status: REQUEST_STATUS

    validates :status, presence: true, inclusion: {in: statuses.keys , message: 'The value: %{value} is not a valid status'}

  end
end