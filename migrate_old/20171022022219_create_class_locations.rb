class CreateClassLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :class_locations do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :timezone, null: false

      t.timestamps
    end
  end
end


# rails generate scaffold ClassLocation name:string email:string timezone:string