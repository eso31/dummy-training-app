class DeleteUserLanguageField < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :language_key
  end
end
