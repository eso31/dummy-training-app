class AddRolesForeingKeys < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :users_roles, :users, on_delete: :cascade
    add_foreign_key :users_roles, :roles, on_delete: :restrict
  end
end
