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
      can :create, Ingredient, user_id: user.id
      can :read, Ingredient
      can :update, Ingredient, user_id: user.id 
      can :destroy, Ingredient, user_id: user.id

      can :create, Tag
      can :read, Tag
      can :create, Comment  
      can :read, Comment
      can :update, Comment, user_id: user.id 
      can :destroy, Comment, user_id: user.id
      can :create, Rating  
      can :read, Rating
      can :update, Rating, user_id: user.id 
      can :destroy, Rating, user_id: user.id
    end
  end
end
