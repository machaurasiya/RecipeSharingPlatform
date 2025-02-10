class IngredientsController < ApplicationController
  before_action :set_recipe
  before_action :set_ingredient, only: [:show, :update, :destroy]

  def index
    @ingredients = @recipe.ingredients.all

    render json: @ingredients
  end

  def show
    render json: @ingredient
  end

  def create
    @ingredient = @recipe.ingredients.new(ingredient_params)

    if @ingredient.save
        render json: @ingredient, status: :created, location: recipe_ingredient_url(@recipe, @ingredient)
    else
      render json: @ingredient.errors, status: :unprocessable_entity
    end
  end

  def update
    if @ingredient.update(ingredient_params)
      render json: @ingredient
    else
      render json: @ingredient.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @ingredient.destroy
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def set_ingredient
    @ingredient = Ingredient.find(params[:id])
  end

  def ingredient_params
    params.require(:ingredient).permit(:recipe_id, :name, :quantity)
  end
end
