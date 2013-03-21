class RemoveDefaultFromProfilePic < ActiveRecord::Migration
  def change
  	change_column :users, :profile_pic, :string
  end
end
