class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.integer :duration, null: false
      t.integer :min_group_size, null: false
      t.integer :max_group_size, null: false
      t.references :user, index: true, foreign_key: true
      t.references :series, index: true, foreign_key: true

      t.timestamps
    end
  end
end