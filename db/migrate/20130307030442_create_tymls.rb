class CreateTymls < ActiveRecord::Migration
  def change
    create_table :tymls do |t|
      t.integer  :sender_id
      t.string   :receiver_id
      t.string   :url
      t.string   :note
      t.boolean  :viewed,         :default => false


      t.timestamps
    end
  end
end
