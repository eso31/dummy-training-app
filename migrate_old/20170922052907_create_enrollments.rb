class CreateEnrollments < ActiveRecord::Migration[5.1]
  def change
    create_table :enrollments do |t|
      t.boolean :attended
      t.references :user, foreign_key: true, index: true
      t.references :training_session, foreign_key: true, index: true

      t.timestamps
    end
  end
end