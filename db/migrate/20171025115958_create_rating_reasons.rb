class CreateRatingReasons < ActiveRecord::Migration[5.1]
  def change
    create_table :rating_reasons do |t|
      t.string :description
      t.string :rating_type

      t.timestamps
    end
  end
end
