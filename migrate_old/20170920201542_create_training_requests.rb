class CreateTrainingRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :training_requests do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.string :location, null: false
      t.integer :duration, null: false
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false
      t.string :status, null: false, default: 'New'
      t.string :reference_file
      t.references :assigned_to, index: true
      t.references :requested_by, null: false, index: true

      t.timestamps
    end
  end
end

#rails generate scaffold TrainingRequest name:string description:string location:string duration:integer start_date:datetime end_date:datetime status:string reference_file:string assigned_to_user:references requested_by_user:references