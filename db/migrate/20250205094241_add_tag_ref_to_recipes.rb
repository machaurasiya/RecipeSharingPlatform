class AddTagRefToRecipes < ActiveRecord::Migration[7.1]
  def change
    add_reference :recipes, :tag, null: true, foreign_key: true
  end
end
