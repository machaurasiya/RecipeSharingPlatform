class RecipesController < ApplicationController
  # before_action :set_user
  before_action :set_recipe, only: [:show, :update, :destroy]

  def index
    @recipes = Recipe.all

    render json: @recipes
  end

  def show
    render json: @recipe
  end

  def create
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      render json: @recipe, status: :created, location: @recipe
    else
      render json: @recipe.errors, status: :unprocessable_entity
    end
  end

  def update
    if @recipe.update(recipe_params)
      render json: @recipe
    else
      render json: @recipe.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @recipe.destroy
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  # def set_user

  # end

  def recipe_params
    params.require(:recipe).permit(:title, :description, :instruction, :user_id, :tag_id)
  end
end
