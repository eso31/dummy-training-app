class ChangeGoogleCalendarIdTypeInTrainingSessions < ActiveRecord::Migration[5.1]
  def change
    change_column :training_sessions, :google_calendar_event_id, :string
    change_column :training_sessions, :google_calendar_id, :string
  end
end
