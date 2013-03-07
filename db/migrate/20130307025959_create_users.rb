class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string   :name
      t.string   :email
      t.string   :profile_pic
      t.string   :bio
      t.string   :location
      t.string   :password
      t.string   :password_confirmation
      t.string   :password_digest
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip
      t.integer  :sign_in_count,          :default => 0


      t.timestamps
    end
  end
end
