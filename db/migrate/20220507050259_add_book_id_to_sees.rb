class AddBookIdToSees < ActiveRecord::Migration[6.1]
  def change
    add_column :sees, :book_id, :integer
  end
end
