class App < ActiveRecord::Base
  validates :bundle_id, :uniqueness => true, :presence => true
  validates :status_bar_style, :presence => true
  serialize :files, Array
end
