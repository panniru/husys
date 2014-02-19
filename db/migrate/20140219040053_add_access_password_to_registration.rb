class AddAccessPasswordToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :access_password, :string
  end
end
