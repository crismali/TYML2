class AddArchivedToTymls < ActiveRecord::Migration
  def change

    add_column :tymls, :archived, :boolean, :default => false

  end

end
