class AddUseridRoleidToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_id, :string
    add_column :users, :role_id, :integer
  end
end
