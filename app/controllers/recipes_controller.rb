class RecipesController < ApplicationController
  include Rails.application.routes.url_helpers
  # load_and_authorize_resource
  # authorize_resource class: false
  before_action :set_recipe, only: [:show, :update, :destroy]

  def index
    @recipes = if params[:q].present?
      Recipe.joins(:tag).where("tags.tag_name LIKE ?", "%#{params[:q]}%").or(Recipe.where("title LIKE ?", "%#{params[:q]}%"))
    else
      Recipe.all
    end
    render json: @recipes
  end

  def show
    if @recipe.recipe_images.attached?
      # image_url = url_for(@recipe.recipe_images.first) #for show only ane image 
      image_urls = @recipe.recipe_images.map { |image| url_for(image) } if @recipe.recipe_images.attached?
    else
      image_url = nil
    end

    # render json: { recipe: @recipe, image_url: image_url }
    render json: { recipe: @recipe, image_urls: image_urls }
  end

  def create
    @recipe = Recipe.new(recipe_params)

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
