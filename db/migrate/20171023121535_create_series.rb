class CreateSeries < ActiveRecord::Migration[5.1]
  def change
    create_table :series do |t|
      t.string :name,:null => false
      t.text :description, :null => true

      t.timestamps
    end
  end
end
