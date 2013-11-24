class App < ActiveRecord::Base
  validates :name, :uniqueness => true
  serialize :files, Array
end
