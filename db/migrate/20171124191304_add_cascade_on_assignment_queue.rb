class AddCascadeOnAssignmentQueue < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :assignment_queues, :training_requests
    remove_foreign_key :assignment_queues, :users
    add_foreign_key :assignment_queues, :training_requests, on_delete: :cascade
    add_foreign_key :assignment_queues, :users, on_delete: :cascade
  end
end
