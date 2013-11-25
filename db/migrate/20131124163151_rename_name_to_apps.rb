class RenameNameToApps < ActiveRecord::Migration
  def change
    rename_column :apps, :name, :bundle_id
  end
end
