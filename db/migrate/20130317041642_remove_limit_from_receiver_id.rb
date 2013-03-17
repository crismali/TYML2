class RemoveLimitFromReceiverId < ActiveRecord::Migration
  def change
    remove_column :tymls, :receiver_id
    add_column :tymls, :receiver_id, :integer
    add_index :tymls, :receiver_id
  end
end
