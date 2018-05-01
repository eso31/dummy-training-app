class CreateSessionRatingReasons < ActiveRecord::Migration[5.1]
  def change
    create_join_table :session_ratings, :rating_reasons, table_name: :session_rating_reasons  do |t|
      t.belongs_to :session_rating_id, index: true
      t.belongs_to :rating_reason_id, index: true
    end
  end
end
