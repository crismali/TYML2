class SetProfilePicDefaultToNil < ActiveRecord::Migration
  def change
  	change_column :users, :profile_pic, :string, :default => nil
  end
end
