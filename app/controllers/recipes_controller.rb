class RecipesController < ApplicationController
  # load_and_authorize_resource
  # authorize_resource class: false
  before_action :set_recipe, only: [:show, :update, :destroy]

  def index
    # @recipes = Recipe.all

    @recipes = params[:q].present? ? Recipe.search(params[:q]) : Recipe.all
    render json: @recipes
  end

  def show
    render json: @recipe
  end

  def create
    @recipe = Recipe.new(recipe_params)

    # if params[:recipe][:recipe_images].present?
    #   params[:recipe][:recipe_images].each do |image|
    #     @recipe.recipe_images.attach(image)
    #   end
    # end

    if params[:recipe][:recipe_images].present?
      images = params[:recipe][:recipe_images].is_a?(Array) ? params[:recipe][:recipe_images] : [params[:recipe][:recipe_images]]
    
      images.each do |image|
        @recipe.recipe_images.attach(image)
      end
    end

    if @recipe.save
      render json: @recipe, status: :created, location: @recipe
    else
      render json: @recipe.errors, status: :unprocessable_entity
    end
  end

  def update
    if @recipe.update(recipe_params)

      if params[:recipe][:recipe_images].present?
        images = params[:recipe][:recipe_images].is_a?(Array) ? params[:recipe][:recipe_images] : [params[:recipe][:recipe_images]]
      
        images.each do |image|
          @recipe.recipe_images.attach(image)
        end
      end
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

  def recipe_params
    params.require(:recipe).permit(:title, :description, :instruction, :user_id, :tag_id, recipe_images: [])
  end
end
