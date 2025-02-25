class RatingsController < ApplicationController
  before_action :authorize_request
  load_and_authorize_resource
  before_action :set_recipe
  before_action :set_rating, only: [:show, :update, :destroy]

  def index
    @ratings = @recipe.ratings.all

    render json: @ratings
  end

  def show
    render json: @rating
  end

  def create
    @rating = @recipe.ratings.new(rating_params)
    @rating.user = current_user

    if @rating.save
        render json: @rating, status: :created, location: recipe_rating_url(@recipe, @rating)
    else
      render json: @rating.errors, status: :unprocessable_entity
    end
  end

  def update
    if @rating.update(rating_params)
      render json: @rating
    else
      render json: @rating.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @rating.destroy
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def set_rating
    @rating = Rating.find(params[:id])
  end

  def rating_params
    params.require(:rating).permit(:user_id, :recipe_id, :point)
  end
end
