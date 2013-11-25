class AddColumnStatusBarStyleToApps < ActiveRecord::Migration
  def change
    add_column :apps, :status_bar_style, :string, :default => 'default'
  end
end
