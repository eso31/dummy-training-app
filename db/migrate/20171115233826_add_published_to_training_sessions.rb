class AddPublishedToTrainingSessions < ActiveRecord::Migration[5.1]
  def change
    add_column :training_sessions, :published, :boolean, default: true
  end
end
