class CreateTrainingRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :training_requests do |t|
      t.string :name, :null => false
      t.text :description, :null => false
      t.string :location, :null => true
      t.integer :duration
      t.datetime :start_date, :null => true
      t.datetime :end_date, :null => true
      t.string :status, :null => false
      t.string :reference_file, :null => true
      t.references :assigned_to_user, foreign_key: {to_table: :users}
      t.references :requested_by_user, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
