class CreateLedgerCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :ledger_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
