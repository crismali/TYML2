class ChangeReceiverIdToIntegerType < ActiveRecord::Migration
  def change
    change_column :tymls, :receiver_id, :integer
  end
end
