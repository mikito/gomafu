class App < ActiveRecord::Base
  validates :name, :uniqueness => true, :presence => true
  validates :status_bar_style, :presence => true
  serialize :files, Array
end
