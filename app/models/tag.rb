class Tag < ApplicationRecord
  include Searchable
  
  has_many :recipes
end
