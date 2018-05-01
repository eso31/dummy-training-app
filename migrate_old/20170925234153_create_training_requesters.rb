class CreateTrainingRequesters < ActiveRecord::Migration[5.1]
  def change
    create_table :training_requesters do |t|
      t.references :user, foreign_key: true, index: true, null: false
      t.references :training_request, foreign_key: true, index: true, null: false
      t.string :status, foreign_key: true, default: 'New'

      t.timestamps
    end
  end
  #rails generate scaffold Requester user:references training_request:references status:string

end