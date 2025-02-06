class User < ApplicationRecord
  has_many :recipes
  has_many :comments
  has_one :rating
  
  enum role: %i[admin user]
  after_initialize :set_default_role, if: :new_record?

  private

  def set_default_role
    self.role ||= :user
  end
end
