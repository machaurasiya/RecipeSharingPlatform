class User < ApplicationRecord
  has_many :recipes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :rating, dependent: :destroy
  
  enum role: %i[admin user]
  after_initialize :set_default_role, if: :new_record?

  private

  def set_default_role
    self.role ||= :user
  end
end
