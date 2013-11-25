class AddColumnNameToApps < ActiveRecord::Migration
  def change
    add_column :apps, :name, :string, :null => false
  end
end
