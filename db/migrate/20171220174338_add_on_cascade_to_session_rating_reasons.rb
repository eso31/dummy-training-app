class AddOnCascadeToSessionRatingReasons < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :session_rating_reasons, :session_ratings, on_delete: :cascade
    add_foreign_key :session_rating_reasons, :rating_reasons, on_delete: :restrict
  end
end