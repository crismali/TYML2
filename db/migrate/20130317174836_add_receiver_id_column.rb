class AddReceiverIdColumn < ActiveRecord::Migration
  def change
    add_column :tymls, :receiver_id, :integer
  end
end
