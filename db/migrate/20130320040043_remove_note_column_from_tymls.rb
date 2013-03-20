class RemoveNoteColumnFromTymls < ActiveRecord::Migration
  def change
    remove_column :tymls, :note
  end
end
