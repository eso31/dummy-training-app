# frozen_string_literal: true
module GoogleCalendar

  include ActiveSupport::Concern


  def create_event(args)
    event = Google::Apis::CalendarV3::Event.new(
      start: Google::Apis::CalendarV3::EventDateTime.new(
        date_time: args[:start_date].to_datetime
      ),
      end: Google::Apis::CalendarV3::EventDateTime.new(
        date_time: args[:end_date].to_datetime
      ),
      summary: args[:summary]
    )

    ApplicationController
      .calendar
      .insert_event(ENV['CALENDAR_EMAIL'], event, send_notifications: true)
      .id
  end

  def add_attendee(args)
    event = ApplicationController.calendar.get_event(ENV['CALENDAR_EMAIL'], args[:event_id])
    event.update!(attendees: (event.attendees || []) << args[:attendee])
    ApplicationController.calendar.update_event(ENV['CALENDAR_EMAIL'], args[:event_id], event, send_notifications: true)
  end

  def remove_attendee(args)
    event = ApplicationController.calendar.get_event(ENV['CALENDAR_EMAIL'], args[:event_id])
    event.update!(attendees: (event.attendees.delete(args[:attendee]) || []))
    ApplicationController.calendar.update_event(ENV['CALENDAR_EMAIL'], args[:event_id], event, send_notifications: true)
  end
end