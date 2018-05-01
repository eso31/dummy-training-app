class UpdateOnCascadeEnrollment < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :enrollments, :training_sessions
    add_foreign_key :enrollments, :training_sessions, on_delete: :cascade
  end
end
