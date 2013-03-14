class AddColumnsForReceivingEmailNotifications < ActiveRecord::Migration
  def change
    add_column :users, :receive_new_tyml_notifications, :boolean, default: true
    add_column :users, :receive_comment_notifications, :boolean, default: true
  end
end
