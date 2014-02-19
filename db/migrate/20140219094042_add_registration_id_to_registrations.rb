class AddRegistrationIdToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :registration_id, :string
  end
end
