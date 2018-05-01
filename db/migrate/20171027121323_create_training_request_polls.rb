class CreateTrainingRequestPolls < ActiveRecord::Migration[5.1]
  def change
    create_table :training_request_polls do |t|
      t.string :vote, null: false
      t.text :comment
      t.references :training_request, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
