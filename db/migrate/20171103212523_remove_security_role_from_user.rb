class RemoveSecurityRoleFromUser < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :security_role, :string
  end
end
