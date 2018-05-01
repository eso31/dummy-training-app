class RenameDurationToDurationInMinutes < ActiveRecord::Migration[5.1]
  def change
    rename_column :training_requests, :duration, :duration_in_minutes
  end
end