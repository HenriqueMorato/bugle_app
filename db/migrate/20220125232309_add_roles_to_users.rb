class AddRolesToUsers < ActiveRecord::Migration[7.0]
  def up
    execute <<~SQL
      CREATE TYPE user_role AS ENUM ('user', 'admin');
    SQL
    add_column :users, :role, :user_role, default: 'user'
    add_index :users, :role
  end

  def down
    remove_column :users, :role
    execute <<~SQL
      DROP TYPE catalog_status;
    SQL
  end
end
