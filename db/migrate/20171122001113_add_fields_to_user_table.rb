class AddFieldsToUserTable < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :language_key, :string, default: 'en'
    add_column :users, :vegetarian, :boolean, defualt: false
    add_column :users, :notification, :boolean, default: false
  end
end