class AddCascadeOnSessionRating < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :session_ratings, :users
    remove_foreign_key :session_ratings, :enrollments
    add_foreign_key :session_ratings, :users, on_delete: :cascade
    add_foreign_key :session_ratings, :enrollments, on_delete: :cascade
  end
end
