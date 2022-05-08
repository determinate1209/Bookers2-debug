class AddUserIdToSees < ActiveRecord::Migration[6.1]
  def change
    add_column :sees, :user_id, :integer
  end
end
