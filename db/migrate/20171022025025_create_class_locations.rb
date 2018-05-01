class CreateClassLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :class_locations do |t|
      t.string :name
      t.string :email
      t.string :timezone

      t.timestamps
    end
  end
end
