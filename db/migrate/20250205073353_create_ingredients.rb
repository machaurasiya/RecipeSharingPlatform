class CreateIngredients < ActiveRecord::Migration[7.1]
  def change
    create_table :ingredients do |t|
      t.belongs_to :recipe, foreign_key: true
      t.string :name
      t.string :quantity

      t.timestamps
    end
  end
end
