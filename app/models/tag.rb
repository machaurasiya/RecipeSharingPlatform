class Tag < ApplicationRecord
  include Searchable
  
  belongs_to :user
  has_many :recipes
end
