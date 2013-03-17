class AddStatementsToTymls < ActiveRecord::Migration
  def change
    add_column :tymls, :statement, :string
  end
end
