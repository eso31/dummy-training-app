class CreateTrainingSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :training_sessions do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.integer :min_group_size, null: false, default: 5
      t.integer :max_group_size, null: false, default: 10
      t.datetime :start_date, null: false
      t.string :url
      t.integer :duration_in_minutes, null: false, default:120
      t.decimal :compensation
      t.boolean :compensation_delivered
      t.string :session_type, null: false
      t.integer :google_calendar_id
      t.integer :google_calendar_event_id
      t.references :course, foreign_key: true
      t.references :class_location, foreign_key: true

      t.timestamps
    end
  end
end
