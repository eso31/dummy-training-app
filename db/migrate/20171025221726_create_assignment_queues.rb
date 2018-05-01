class CreateAssignmentQueues < ActiveRecord::Migration[5.1]
  def change
    create_table :assignment_queues do |t|
      t.integer :assignment_order, null: false
      t.string :status, null: false
      t.references :user, foreign_key: true
      t.references :training_request, foreign_key: true

      t.timestamps
    end
  end
end
