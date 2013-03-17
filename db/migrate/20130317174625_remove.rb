class Remove < ActiveRecord::Migration
  def change
    remove_column :tymls, :receiver_id
  end
end
