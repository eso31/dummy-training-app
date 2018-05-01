class CreateInstructors < ActiveRecord::Migration[5.1]
  def change
    create_table :instructors do |t|
      t.references :training_session, foreign_key: {on_delete: :cascade}, index: true
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end

  end
end
