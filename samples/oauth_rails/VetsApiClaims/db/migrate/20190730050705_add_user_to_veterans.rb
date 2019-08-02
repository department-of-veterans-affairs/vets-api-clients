class AddUserToVeterans < ActiveRecord::Migration[5.2]
  def change
  	add_column :test_veterans, :test_user_id, :integer
    add_index  :test_veterans, :test_user_id
  end
end
