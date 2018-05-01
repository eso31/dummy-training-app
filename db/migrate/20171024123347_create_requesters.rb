class CreateRequesters < ActiveRecord::Migration[5.1]
  def change
    create_table :requesters do |t|
      t.references :user, index: true, foreign_key: true
      # TODO add foreing key
      t.references :training_request, index: true, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
