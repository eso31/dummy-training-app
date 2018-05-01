class UpdateOnCascadeRequesters < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :requesters, :training_requests
    remove_foreign_key :requesters, :users
    add_foreign_key :requesters, :training_requests, on_delete: :cascade
    add_foreign_key :requesters, :users, on_delete: :cascade
  end
end
