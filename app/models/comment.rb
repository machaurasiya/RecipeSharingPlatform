class Comment < ApplicationRecord
  belongs_to :comment
  belongs_to :recipe
end
