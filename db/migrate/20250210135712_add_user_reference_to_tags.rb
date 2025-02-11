class AddUserReferenceToTags < ActiveRecord::Migration[7.1]
  def change
    add_reference :tags, :user, foreign_key: true
  end
end
