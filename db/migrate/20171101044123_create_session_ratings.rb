class CreateSessionRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :session_ratings do |t|
      t.integer :rating
      t.string :user_type
      t.text :comment
      t.references :enrollment, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
