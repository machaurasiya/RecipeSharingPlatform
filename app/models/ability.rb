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
      
      can :read, Tag
      cannot :create, Tag
      can :create, Comment  
      can :read, Comment
      can :create, Rating  
      can :read, Rating
    end
  end
end
