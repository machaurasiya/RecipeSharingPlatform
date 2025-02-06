class Recipe < ApplicationRecord
  include Searchable

  belongs_to :user
  belongs_to :tag
  has_many :comments
  has_many :ratings
  has_many :ingredients


  has_many_attached :recipe_images

  mapping do
    indexes :title, type: 'text'
    indexes :description, type: 'text'
  end
end
