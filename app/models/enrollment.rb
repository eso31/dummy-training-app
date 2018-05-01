class Enrollment < ApplicationRecord
  resourcify
  audited

  belongs_to :user
  belongs_to :training_session
  has_one :session_rating
  after_update :update_session_rating

  validates :attended, inclusion: { in: [ true, false ] }
  validates :user, uniqueness: { scope: :training_session, message: "You are already enrolled on this session" }

  def set_attended
    attended ? false : true
  end

  # Show with format
  def to_s
    "#{user.email} <#{training_session.title.truncate(50)}>"
  end

  private

  # Remove the session rating if the enrollment is marked as unattended
  def update_session_rating
    session_rating.destroy if session_rating && !attended
  end

end
