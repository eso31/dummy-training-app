class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string :title, null: false
      t.string :description
      t.integer :duration_in_minutes, null: false, numericality: true, length: { maximum: 3 }
      t.integer :min_group_size, null: false, numericality: true, length: { maximum: 3 }
      t.integer :max_group_size, null: false, numericality: true, length: { maximum: 3 }
      t.references :taught_by_user, foreign_key: {to_table: :users}
      t.references :series, foreign_key: true, null: true

      t.timestamps
    end
  end
end
