class CreateSeries < ActiveRecord::Migration[5.1]
  def change
    create_table :series do |t|
      t.string :name, null: false
      t.string :text, null: false

      t.timestamps
    end
    #rails generate scaffold Series name:string description:text
  end
end
