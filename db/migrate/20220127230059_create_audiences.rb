class CreateAudiences < ActiveRecord::Migration[7.0]
  def change
    create_table :audiences do |t|
      t.references :course, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :audiences, [:user_id, :course_id], unique: true
  end
end
