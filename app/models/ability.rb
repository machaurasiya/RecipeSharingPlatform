# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, :all  
    else
      can :create, Recipe  
      can :read, Recipe
      can :update, Recipe, user_id: user.id 
      can :destroy, Recipe, user_id: user.id
    end
  end
end
