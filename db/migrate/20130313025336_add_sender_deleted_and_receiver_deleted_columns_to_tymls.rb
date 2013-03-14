class AddSenderDeletedAndReceiverDeletedColumnsToTymls < ActiveRecord::Migration
  def change
    add_column :tymls, :sender_deleted, :boolean, default: false
    add_column :tymls, :receiver_deleted, :boolean, default: false
  end
end
