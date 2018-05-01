class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  protect_from_forgery with: :exception

  require 'google/apis/calendar_v3'

  include GoogleCalendar

  def self.calendar
    define_calendar
  end

  protected

  def self.define_calendar

    return @calendar if @calendar

    scope = 'https://www.googleapis.com/auth/calendar'

    authorizer = Google::Auth::ServiceAccountCredentials.make_creds(
      json_key_io: File.open('training-app-6f3d7342e127.json'),
      scope: scope
    )
    authorizer.fetch_access_token!

    @calendar = Google::Apis::CalendarV3::CalendarService.new
    @calendar.authorization = authorizer
    @calendar
  end

end
