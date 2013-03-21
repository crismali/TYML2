class AddDefaultProfilePicToUsers < ActiveRecord::Migration
  def change
  	change_column :users, :profile_pic, :string, :default => 'default.png'
  end
end
