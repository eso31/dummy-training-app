class CreateTrainingSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :training_sessions do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.integer :min_group_size, null: false
      t.integer :max_group_size, null: false
      t.datetime :start_date, null: false
      t.string :url, null: false, default: 'Not defined yet'
      t.integer :duration, null: false
      t.decimal :compensation
      t.boolean :compensation_delivered
      t.string :session_type, null: false
      t.references :course, foreign_key: true, index: true, null: false
      t.references :class_location, foreign_key: true, index: true, null: false

      t.timestamps

      #rails generate scaffold TrainingSession title:string description:text min_group_size:integer max_group_size:integer start_date:datetime url:string duration_in_minutes:integer compensation:decimal compensation_delivered:boolean session_type:string course:references class_location:references
    end
  end
end