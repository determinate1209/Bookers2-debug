class RemoveIpFromSees < ActiveRecord::Migration[6.1]
  def change
    remove_column :sees, :ip, :string
  end
end
