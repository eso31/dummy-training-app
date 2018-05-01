class AddInstructors < ActiveRecord::Migration[5.1]
  def change
    create_join_table :training_sessions, :users, table_name: :instructors  do |t|
      t.index [:training_session_id, :user_id]
    end

    add_foreign_key :instructors, :training_sessions, on_delete: :cascade
    add_foreign_key :instructors, :users, on_delete: :restrict
  end
end
