class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.belongs_to :user, foreign_key: true
      t.string :title
      t.string :description
      t.string :instruction

      t.timestamps
    end
  end
end
