class CreateFinancialAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :financial_accounts do |t|
      t.string :name, null: false
      t.string :status, null: false
      t.references :parent_account, foreign_key: {to_table: :financial_accounts}, null: true

      t.timestamps
    end
  end
end
