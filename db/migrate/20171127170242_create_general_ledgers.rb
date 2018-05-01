class CreateGeneralLedgers < ActiveRecord::Migration[5.1]
  def change
    create_table :general_ledgers do |t|
      t.string :transaction_type, null: false
      t.text :description, null: false
      t.datetime :transaction_date, null: true
      t.decimal :amount, null: false
      t.references :financial_account, foreign_key: true
      t.references :ledger_category, foreign_key: true
      t.references :training_request, foreign_key: true
      t.references :training_session, foreign_key: true

      t.timestamps
    end
  end
end
