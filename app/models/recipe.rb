class Recipe < ApplicationRecord
  belongs_to :user
  belongs_to :tag
  has_many :ingredients

  has_many_attached :recipe_images
end
