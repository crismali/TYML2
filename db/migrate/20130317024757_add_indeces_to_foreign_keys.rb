class AddIndecesToForeignKeys < ActiveRecord::Migration
  def change

    add_index :users, :email
    add_index :users, :remember_token

    add_index :tymls, :receiver_id
    add_index :tymls, :sender_id

    add_index :contacts, :contact_id
    add_index :contacts, :user_id

    add_index :comments, :user_id
    add_index :comments, :tyml_id

  end
end
