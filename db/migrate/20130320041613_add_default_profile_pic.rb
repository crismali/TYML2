class AddDefaultProfilePic < ActiveRecord::Migration
  def change
  	change_column :users, :profile_pic, :string, default: "http://tyml2.herokuapp.com/assets/default_avatar-9a8427abf328907f5e983488bcc66bdb.png"
  end
end
