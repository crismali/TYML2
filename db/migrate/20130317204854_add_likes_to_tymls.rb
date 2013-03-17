class AddLikesToTymls < ActiveRecord::Migration
  def change
    add_column :tymls, :liked, :boolean, default: false
  end
end
