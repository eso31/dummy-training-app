class Requester < ApplicationRecord
  audited
  include HasRequestStatus

  belongs_to :user
  belongs_to :training_request

  validates :user, presence: true
  validates :training_request, presence: true
  validates :status, presence: true

  def to_s
    if training_request.nil? then
      training_request_s = "unknown training request  id:#{training_request_id}"
    else
      training_request_s = training_request.name
    end

    if user.nil? then
      user_s = " unknown user id: #{user_id}"
    else
      user_s = user.to_s
    end

    "#{user_s}, #{training_request_s}"
  end
end
